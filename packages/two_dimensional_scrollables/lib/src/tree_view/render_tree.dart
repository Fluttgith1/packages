// Copyright 2013 The Flutter Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'dart:collection' show LinkedHashMap;
import 'dart:math' as math;

import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';

import '../common/implementation_span.dart';
import 'tree_delegate.dart';
import 'tree_span.dart';
import 'tree_temp.dart';

/// A render object for viewing [RenderBox]es in a tree format that extends in
/// both the horizontal and vertical dimensions.
///
/// [RenderTreeViewport] is the visual workhorse of the [TreeView]. It
/// displays a subset of its [TreeViewNode] rows according to its own dimensions
/// and the given [verticalOffset] and [horizontalOffset]. As the offset varies,
/// different nodes are visible through the viewport.
class RenderTreeViewport extends RenderTwoDimensionalViewport {
  /// Creates a viewport for [RenderBox] objects in a tree format of rows.
  RenderTreeViewport({
    required Map<UniqueKey, TreeViewNodesAnimation> activeAnimations,
    required Map<int, int> rowDepths,
    required TreeViewTraversalOrder traversalOrder,
    required double indentation,
    required super.horizontalOffset,
    required super.horizontalAxisDirection,
    required super.verticalOffset,
    required super.verticalAxisDirection,
    required TreeRowDelegateMixin super.delegate,
    required super.childManager,
    super.cacheExtent,
    super.clipBehavior,
  })  : _activeAnimations = activeAnimations,
        _rowDepths = rowDepths,
        _traversalOrder = traversalOrder,
        _indentation = indentation,
        super(
          mainAxis: traversalOrder == TreeViewTraversalOrder.depthFirst
              ? Axis.vertical
              : Axis.horizontal,
        );

  @override
  TreeRowDelegateMixin get delegate => super.delegate as TreeRowDelegateMixin;
  @override
  set delegate(TreeRowDelegateMixin value) {
    super.delegate = value;
  }

  /// The currently active [TreeViewNode] animations.
  ///
  /// Since the index of animating nodes can change at any time, the unique key
  /// is used to track an animation of nodes across frames.
  Map<UniqueKey, TreeViewNodesAnimation> get activeAnimations {
    return _activeAnimations;
  }

  Map<UniqueKey, TreeViewNodesAnimation> _activeAnimations;
  set activeAnimations(Map<UniqueKey, TreeViewNodesAnimation> value) {
    if (_activeAnimations == value) {
      return;
    }
    _activeAnimations = value;
    markNeedsLayout(withDelegateRebuild: true);
  }

  /// The depth of each currently active node in the tree.
  ///
  /// This is used to properly set the [ChildVicinity] for the [traversalOrder].
  Map<int, int> get rowDepths => _rowDepths;
  Map<int, int> _rowDepths;
  set rowDepths(Map<int, int> value) {
    if (_rowDepths == value) {
      return;
    }
    _rowDepths = value;
    markNeedsLayout();
  }

  /// The order in which child nodes of the tree will be traversed.
  ///
  /// The default traversal order is [TreeViewTraversalOrder.depthFirst].
  TreeViewTraversalOrder get traversalOrder => _traversalOrder;
  TreeViewTraversalOrder _traversalOrder;
  set traversalOrder(TreeViewTraversalOrder value) {
    if (_traversalOrder == value) {
      return;
    }
    _traversalOrder = value;
    // We don't need to layout again. This is used when we visit children.
  }

  /// The number of pixels by which child nodes will be offset in the cross axis
  /// based on their [TreeViewNodeParentData.depth].
  ///
  /// If zero, can alternatively offset children in [TreeView.treeRowBuilder]
  /// for more options to customize the indented space.
  double get indentation => _indentation;
  double _indentation;
  set indentation(double value) {
    if (_indentation == value) {
      return;
    }
    assert(indentation >= 0.0);
    _indentation = value;
    markNeedsLayout();
  }

  // Cached metrics
  Map<int, _Span> _rowMetrics = <int, _Span>{};
  int? _firstRow;
  int? _lastRow;
  double _furthestHorizontalExtent = 0.0;
  // How far rows should be laid out in a given frame.
  double get _targetRowPixel {
    return cacheExtent + verticalOffset.pixels + viewportDimension.height;
  }

  // Maps the index of parents to the animation key of their children.
  final Map<int, UniqueKey> _animationLeadingIndices = <int, UniqueKey>{};
  // Maps the key of child node animations to the fixed distance they are
  // traversing during the animation. Determined at the start of the animation.
  final Map<UniqueKey, double> _animationOffsets = <UniqueKey, double>{};
  void _updateAnimationCache() {
    _animationLeadingIndices.clear();
    _activeAnimations.forEach(
      (UniqueKey key, TreeViewNodesAnimation animation) {
        _animationLeadingIndices[animation.fromIndex] = key;
      },
    );
    // Remove any stored offsets or clip layers that are no longer actively
    // animating.
    _animationOffsets.removeWhere((UniqueKey key, _) {
      return !_activeAnimations.keys.contains(key);
    });
    _clipHandles.removeWhere(
      (UniqueKey key, LayerHandle<ClipRectLayer> handle) {
        if (!_activeAnimations.keys.contains(key)) {
          handle.layer = null;
          return true;
        }
        return false;
      },
    );
  }

  @override
  void dispose() {
    _clipHandles.removeWhere(
      (UniqueKey key, LayerHandle<ClipRectLayer> handle) {
        handle.layer = null;
        return true;
      },
    );
    for (final _Span span in _rowMetrics.values) {
      span.dispose();
    }
    super.dispose();
  }

  void _computeAnimationOffsetFor(UniqueKey key, double position) {
    assert(_activeAnimations[key] != null);
    double currentPosition = position;
    final int startingIndex = _activeAnimations[key]!.fromIndex;
    final int lastIndex = _activeAnimations[key]!.toIndex;
    int currentIndex = startingIndex;
    double totalAnimatingOffset = 0.0;
    // We animate only a portion of children that would be visible/in the cache
    // extent, unless all children would fit on the screen.
    while (currentIndex <= lastIndex && currentPosition < _targetRowPixel) {
      _Span? span = _rowMetrics.remove(currentIndex);
      assert(needsDelegateRebuild || span != null);
      final TreeRow configuration = needsDelegateRebuild
          ? delegate.buildRow(ChildVicinity(
              xIndex: _rowDepths[currentIndex]!,
              yIndex: currentIndex,
            ))
          : span!.configuration;
      span ??= _Span();
      final double extent = configuration.extent.calculateExtent(
        TreeRowExtentDelegate(
          viewportExtent: viewportDimension.height,
          precedingExtent: position,
        ),
      );
      totalAnimatingOffset += extent;
      currentPosition += extent;
      currentIndex++;
    }
    // For the life of this animation, which affects all children following
    // startingIndex (regardless of if they are a child of the triggering
    // parent), they will be offset by totalAnimatingOffset * the
    // animation value. This is because even though more children can be
    // scrolled into view, the same distance must be maintained for a smooth
    // animation.
    _animationOffsets[key] = totalAnimatingOffset;
  }

  void _updateRowMetrics() {
    assert(needsDelegateRebuild || didResize);
    _firstRow = null;
    _lastRow = null;
    double totalAnimationOffset = 0.0;
    double startOfRow = 0;
    final Map<int, _Span> newRowMetrics = <int, _Span>{};
    for (int row = 0; row < delegate.rowCount; row++) {
      final double leadingOffset = startOfRow;
      _Span? span = _rowMetrics.remove(row);
      assert(needsDelegateRebuild || span != null);
      final TreeRow configuration = needsDelegateRebuild
          ? delegate.buildRow(ChildVicinity(
              xIndex: _rowDepths[row]!,
              yIndex: row,
            ))
          : span!.configuration;
      span ??= _Span();
      final double extent = configuration.extent.calculateExtent(
        TreeRowExtentDelegate(
          viewportExtent: viewportDimension.height,
          precedingExtent: leadingOffset,
        ),
      );
      if (_animationLeadingIndices.keys.contains(row)) {
        final UniqueKey animationKey = _animationLeadingIndices[row]!;
        if (_animationOffsets[animationKey] == null) {
          // We have not computed the distance this block is traversing over the
          // lifetime of the animation.
          _computeAnimationOffsetFor(animationKey, startOfRow);
        }
        // We add the offset accounting for the animation value.
        totalAnimationOffset += _animationOffsets[animationKey]! *
            (1 - _activeAnimations[animationKey]!.value);
      }
      span.update(
        configuration: configuration,
        leadingOffset: leadingOffset,
        extent: extent,
        animationOffset: totalAnimationOffset,
      );
      newRowMetrics[row] = span;
      if (span.trailingOffset >= verticalOffset.pixels && _firstRow == null) {
        _firstRow = row;
      }
      if (span.trailingOffset - totalAnimationOffset >= _targetRowPixel &&
          _lastRow == null) {
        _lastRow = row;
      }
      startOfRow = span.trailingOffset;
      totalAnimationOffset = 0.0;
    }
    for (final _Span span in _rowMetrics.values) {
      span.dispose();
    }
    _rowMetrics = newRowMetrics;
    if (_firstRow != null) {
      _lastRow ??= _rowMetrics.length - 1;
    }
  }

  void _updateFirstAndLastVisibleRow() {
    _firstRow = null;
    _lastRow = null;
    for (int row = 0; row < _rowMetrics.length; row++) {
      final double endOfRow = _rowMetrics[row]!.trailingOffset;
      if (endOfRow >= verticalOffset.pixels && _firstRow == null) {
        _firstRow = row;
      }
      if (endOfRow >= _targetRowPixel && _lastRow == null) {
        _lastRow = row;
        break;
      }
    }
    if (_firstRow != null) {
      _lastRow ??= _rowMetrics.length - 1;
    }
  }

  void _updateScrollBounds() {
    final double maxHorizontalExtent = math.max(
      0.0,
      _furthestHorizontalExtent - viewportDimension.width,
    );
    final double maxVerticalExtent = math.max(
      0.0,
      _rowMetrics[_lastRow!]!.trailingOffset - viewportDimension.height,
    );

    final bool acceptedDimension = horizontalOffset.applyContentDimensions(
          0.0,
          maxHorizontalExtent,
        ) &&
        verticalOffset.applyContentDimensions(
          0.0,
          maxVerticalExtent,
        );

    if (!acceptedDimension) {
      _updateFirstAndLastVisibleRow();
    }
  }

  @override
  void layoutChildSequence() {
    assert(verticalAxisDirection == AxisDirection.down &&
        horizontalAxisDirection == AxisDirection.right);

    _updateAnimationCache();
    if (needsDelegateRebuild || didResize) {
      // Recomputes the table metrics, invalidates any cached information.
      _furthestHorizontalExtent = 0.0;
      _updateRowMetrics();
    } else {
      // Updates the visible cells based on cached table metrics.
      _updateFirstAndLastVisibleRow();
    }

    if (_firstRow == null) {
      assert(_lastRow == null);
      return;
    }
    assert(_firstRow != null && _lastRow != null);

    _Span rowSpan;
    double rowOffset =
        -verticalOffset.pixels + _rowMetrics[_firstRow!]!.leadingOffset;
    for (int row = _firstRow!; row <= _lastRow!; row++) {
      rowSpan = _rowMetrics[row]!;
      final double rowHeight = rowSpan.extent;
      if (_animationLeadingIndices.keys.contains(row)) {
        rowOffset -= rowSpan.animationOffset;
      }
      rowOffset += rowSpan.configuration.padding.leading;

      final ChildVicinity vicinity = ChildVicinity(
        xIndex: _rowDepths[row]!,
        yIndex: row,
      );
      final RenderBox child = buildOrObtainChildFor(vicinity)!;
      final TwoDimensionalViewportParentData parentData = parentDataOf(child);
      final BoxConstraints childConstraints = BoxConstraints(
        minHeight: rowHeight,
        maxHeight: rowHeight,
        // Width is allowed to be unbounded.
      );
      child.layout(childConstraints, parentUsesSize: true);
      parentData.layoutOffset = Offset(
        (_rowDepths[row]! * indentation) - horizontalOffset.pixels,
        rowOffset,
      );
      rowOffset += rowHeight + rowSpan.configuration.padding.trailing;
      _furthestHorizontalExtent = math.max(
        parentData.layoutOffset!.dx + child.size.width,
        _furthestHorizontalExtent,
      );
    }
    _updateScrollBounds();
  }

  final Map<UniqueKey, LayerHandle<ClipRectLayer>> _clipHandles =
      <UniqueKey, LayerHandle<ClipRectLayer>>{};

  @override
  void paint(PaintingContext context, Offset offset) {
    if (_firstRow == null) {
      assert(_lastRow == null);
      return;
    }
    assert(_firstRow != null && _lastRow != null);

    if (_animationLeadingIndices.isEmpty) {
      // There are no animations running.
      _paintRows(
        context,
        offset,
        leadingRow: 0,
        trailingRow: delegate.rowCount - 1,
      );
      return;
    }

    // We are animating.
    // Separate animating segments to clip for any overlap.
    int leadingIndex = _firstRow!;
    final List<int> animationIndices = _animationLeadingIndices.keys.toList()
      ..sort();
    final List<({int leadingIndex, int trailingIndex})> paintSegments =
        <({int leadingIndex, int trailingIndex})>[];
    while (animationIndices.isNotEmpty) {
      final int trailingIndex = animationIndices.removeAt(0);
      paintSegments.add((
        leadingIndex: leadingIndex,
        trailingIndex: trailingIndex - 1,
      ));
      leadingIndex = trailingIndex;
    }
    paintSegments.add((leadingIndex: leadingIndex, trailingIndex: _lastRow!));

    // Paint, clipping for all but the first segment.
    _paintRows(
      context,
      offset,
      leadingRow: 0,
      trailingRow: paintSegments.removeAt(0).trailingIndex,
    );
    // Paint the rest with clip layers.
    while (paintSegments.isNotEmpty) {
      final ({int leadingIndex, int trailingIndex}) segment =
          paintSegments.removeAt(0);
      final int parentIndex = segment.leadingIndex - 1;
      final double leadingOffset = _rowMetrics[parentIndex]!.trailingOffset;
      final double trailingOffset =
          _rowMetrics[segment.trailingIndex]!.trailingOffset;
      final Rect rect = Rect.fromPoints(
        Offset(0.0, leadingOffset),
        Offset(viewportDimension.width, trailingOffset),
      );
      // We use the same animation key to keep track of the clip layer, unless
      // this is the odd man out segment.
      final UniqueKey key = _animationLeadingIndices[leadingIndex]!;
      _clipHandles[key] ??= LayerHandle<ClipRectLayer>();
      _clipHandles[key]!.layer = context.pushClipRect(
        needsCompositing,
        offset,
        rect,
        (PaintingContext context, Offset offset) {
          _paintRows(
            context,
            offset,
            leadingRow: segment.leadingIndex,
            trailingRow: segment.trailingIndex,
          );
        },
        oldLayer: _clipHandles[key]!.layer,
      );
    }
  }

  void _paintRows(
    PaintingContext context,
    Offset offset, {
    required int leadingRow,
    required int trailingRow,
  }) {
    // Row decorations
    final LinkedHashMap<Rect, TreeRowDecoration> foregroundRows =
        LinkedHashMap<Rect, TreeRowDecoration>();
    final LinkedHashMap<Rect, TreeRowDecoration> backgroundRows =
        LinkedHashMap<Rect, TreeRowDecoration>();

    int currentRow = leadingRow;
    while (currentRow <= trailingRow) {
      final _Span rowSpan = _rowMetrics[currentRow]!;
      final TreeRow configuration = rowSpan.configuration;
      if (configuration.backgroundDecoration != null ||
          configuration.foregroundDecoration != null) {
        final RenderBox child = getChildFor(
          ChildVicinity(xIndex: _rowDepths[currentRow]!, yIndex: currentRow),
        )!;

        Rect getRowRect(bool consumePadding) {
          final TwoDimensionalViewportParentData parentData =
              parentDataOf(child);
          // Decoration rects cover the whole row from the left and right
          // edge of the viewport.
          return Rect.fromPoints(
            Offset(0.0, parentData.layoutOffset!.dy),
            Offset(viewportDimension.width, rowSpan.trailingOffset),
          );
        }

        if (configuration.backgroundDecoration != null) {
          final Rect rect = getRowRect(
            configuration.backgroundDecoration!.consumeSpanPadding,
          );
          backgroundRows[rect] = configuration.backgroundDecoration!;
        }
        if (configuration.foregroundDecoration != null) {
          final Rect rect = getRowRect(
            configuration.foregroundDecoration!.consumeSpanPadding,
          );
          foregroundRows[rect] = configuration.foregroundDecoration!;
        }
      }
      currentRow++;
    }

    // Get to painting.
    // Background decorations first.
    backgroundRows.forEach((Rect rect, TreeRowDecoration decoration) {
      final TreeRowDecorationPaintDetails paintingDetails =
          TreeRowDecorationPaintDetails(
        canvas: context.canvas,
        rect: rect,
        axisDirection: horizontalAxisDirection,
      );
      decoration.paint(paintingDetails);
    });
    // Child nodes.
    for (int row = leadingRow; row <= trailingRow; row++) {
      final RenderBox cell = getChildFor(
        ChildVicinity(xIndex: _rowDepths[row]!, yIndex: row),
      )!;
      final TwoDimensionalViewportParentData cellParentData =
          parentDataOf(cell);
      if (cellParentData.isVisible) {
        context.paintChild(cell, offset + cellParentData.paintOffset!);
      }
    }
    // Foreground decorations.
    foregroundRows.forEach((Rect rect, TreeRowDecoration decoration) {
      final TreeRowDecorationPaintDetails paintingDetails =
          TreeRowDecorationPaintDetails(
        canvas: context.canvas,
        rect: rect,
        axisDirection: horizontalAxisDirection,
      );
      decoration.paint(paintingDetails);
    });
  }
}

class _Span extends ImplementedSpan {
  double get animationOffset => _animationOffset;
  late double _animationOffset;

  @override
  void update({
    required TreeRow configuration,
    required double leadingOffset,
    required double extent,
    double animationOffset = 0.0,
  }) {
    _animationOffset = animationOffset;
    super.update(
      configuration: configuration,
      leadingOffset: leadingOffset,
      extent: extent,
    );
  }
}
