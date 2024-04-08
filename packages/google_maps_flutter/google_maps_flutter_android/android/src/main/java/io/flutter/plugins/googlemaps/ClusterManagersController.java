// Copyright 2013 The Flutter Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

package io.flutter.plugins.googlemaps;

import android.content.Context;
import androidx.annotation.NonNull;
import androidx.annotation.Nullable;
import com.google.android.gms.maps.GoogleMap;
import com.google.android.gms.maps.model.Marker;
import com.google.android.gms.maps.model.MarkerOptions;
import com.google.maps.android.clustering.Cluster;
import com.google.maps.android.clustering.ClusterItem;
import com.google.maps.android.clustering.ClusterManager;
import com.google.maps.android.clustering.view.DefaultClusterRenderer;
import com.google.maps.android.collections.MarkerManager;
import io.flutter.plugin.common.MethodChannel;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Set;

/**
 * Controls cluster managers and exposes interfaces for adding and removing cluster items for
 * specific cluster managers.
 */
class ClusterManagersController
    implements GoogleMap.OnCameraIdleListener,
        ClusterManager.OnClusterClickListener<MarkerBuilder> {
  @NonNull private final Context context;
  @NonNull private final HashMap<String, ClusterManager<MarkerBuilder>> clusterManagerIdToManager;
  @NonNull private final MethodChannel methodChannel;
  @Nullable private MarkerManager markerManager;
  @Nullable private GoogleMap googleMap;

  @Nullable
  private ClusterManager.OnClusterItemClickListener<MarkerBuilder> clusterItemClickListener;

  @Nullable
  private ClusterManagersController.OnClusterItemRendered<MarkerBuilder>
      clusterItemRenderedListener;

  ClusterManagersController(MethodChannel methodChannel, Context context) {
    this.clusterManagerIdToManager = new HashMap<>();
    this.context = context;
    this.methodChannel = methodChannel;
  }

  void init(GoogleMap googleMap, MarkerManager markerManager) {
    this.markerManager = markerManager;
    this.googleMap = googleMap;
  }

  void setClusterItemClickListener(
      @Nullable ClusterManager.OnClusterItemClickListener<MarkerBuilder> listener) {
    clusterItemClickListener = listener;
    initListenersForClusterManagers();
  }

  void setClusterItemRenderedListener(
      @Nullable ClusterManagersController.OnClusterItemRendered<MarkerBuilder> listener) {
    clusterItemRenderedListener = listener;
  }

  private void initListenersForClusterManagers() {
    for (Map.Entry<String, ClusterManager<MarkerBuilder>> entry :
        clusterManagerIdToManager.entrySet()) {
      initListenersForClusterManager(entry.getValue(), this, clusterItemClickListener);
    }
  }

  private void initListenersForClusterManager(
      ClusterManager<MarkerBuilder> clusterManager,
      @Nullable ClusterManager.OnClusterClickListener<MarkerBuilder> clusterClickListener,
      @Nullable ClusterManager.OnClusterItemClickListener<MarkerBuilder> clusterItemClickListener) {
    clusterManager.setOnClusterClickListener(clusterClickListener);
    clusterManager.setOnClusterItemClickListener(clusterItemClickListener);
  }

  /** Adds new ClusterManagers to the controller. */
  void addClusterManagers(@NonNull List<Object> clusterManagersToAdd) {
    for (Object clusterToAdd : clusterManagersToAdd) {
      addClusterManager(clusterToAdd);
    }
  }

  /** Adds new ClusterManager to the controller. */
  void addClusterManager(Object clusterManagerData) {
    String clusterManagerId = getClusterManagerId(clusterManagerData);
    if (clusterManagerId == null) {
      throw new IllegalArgumentException("clusterManagerId was null");
    }
    ClusterManager<MarkerBuilder> clusterManager =
        new ClusterManager<>(context, googleMap, markerManager);
    ClusterRenderer clusterRenderer = new ClusterRenderer(context, googleMap, clusterManager, this);
    clusterManager.setRenderer(clusterRenderer);
    initListenersForClusterManager(clusterManager, this, clusterItemClickListener);
    clusterManagerIdToManager.put(clusterManagerId, clusterManager);
  }

  /** Removes ClusterManagers by given cluster manager IDs from the controller. */
  public void removeClusterManagers(@NonNull List<Object> clusterManagerIdsToRemove) {
    for (Object rawClusterManagerId : clusterManagerIdsToRemove) {
      if (rawClusterManagerId == null) {
        continue;
      }
      String clusterManagerId = (String) rawClusterManagerId;
      removeClusterManager(clusterManagerId);
    }
  }

  /**
   * Removes the ClusterManagers by the given cluster manager ID from the controller. The reference
   * to this cluster manager is removed from the clusterManagerIdToManager and it will be garbage
   * collected later.
   */
  private void removeClusterManager(Object clusterManagerId) {
    // Remove the cluster manager from the hash map to allow it to be garbage collected.
    final ClusterManager<MarkerBuilder> clusterManager =
        clusterManagerIdToManager.remove(clusterManagerId);
    if (clusterManager == null) {
      return;
    }
    initListenersForClusterManager(clusterManager, null, null);
    clusterManager.clearItems();
    clusterManager.cluster();
  }

  /** Adds item to the ClusterManager it belongs to. */
  public void addItem(MarkerBuilder item) {
    ClusterManager<MarkerBuilder> clusterManager =
        clusterManagerIdToManager.get(item.clusterManagerId());
    if (clusterManager != null) {
      clusterManager.addItem(item);
      clusterManager.cluster();
    }
  }

  /** Removes item from the ClusterManager it belongs to. */
  public void removeItem(MarkerBuilder item) {
    ClusterManager<MarkerBuilder> clusterManager =
        clusterManagerIdToManager.get(item.clusterManagerId());
    if (clusterManager != null) {
      clusterManager.removeItem(item);
      clusterManager.cluster();
    }
  }

  /** Called when ClusterRenderer has rendered new visible marker to the map. */
  void onClusterItemRendered(@NonNull MarkerBuilder item, @NonNull Marker marker) {
    // If map is being disposed, clusterItemRenderedListener might have been cleared and
    // set to null.
    if (clusterItemRenderedListener != null) {
      clusterItemRenderedListener.onClusterItemRendered(item, marker);
    }
  }

  /** Reads clusterManagerId from object data. */
  @SuppressWarnings("unchecked")
  private static String getClusterManagerId(Object clusterManagerData) {
    Map<String, Object> clusterMap = (Map<String, Object>) clusterManagerData;
    return (String) clusterMap.get("clusterManagerId");
  }

  /**
   * Requests all current clusters from the algorithm of the requested ClusterManager and converts
   * them to result response.
   */
  public void getClustersWithClusterManagerId(
      String clusterManagerId, MethodChannel.Result result) {
    ClusterManager<MarkerBuilder> clusterManager = clusterManagerIdToManager.get(clusterManagerId);
    if (clusterManager == null) {
      result.error(
          "Invalid clusterManagerId", "getClusters called with invalid clusterManagerId", null);
      return;
    }

    final Set<? extends Cluster<MarkerBuilder>> clusters =
        clusterManager.getAlgorithm().getClusters(googleMap.getCameraPosition().zoom);
    result.success(Convert.clustersToJson(clusterManagerId, clusters));
  }

  @Override
  public void onCameraIdle() {
    for (Map.Entry<String, ClusterManager<MarkerBuilder>> entry :
        clusterManagerIdToManager.entrySet()) {
      entry.getValue().onCameraIdle();
    }
  }

  @Override
  public boolean onClusterClick(Cluster<MarkerBuilder> cluster) {
    if (cluster.getSize() > 0) {
      MarkerBuilder[] builders = cluster.getItems().toArray(new MarkerBuilder[0]);
      String clusterManagerId = builders[0].clusterManagerId();
      methodChannel.invokeMethod("cluster#onTap", Convert.clusterToJson(clusterManagerId, cluster));
    }

    // Return false to allow the default behavior of the cluster click event to occur.
    return false;
  }

  /**
   * ClusterRenderer builds marker options for new markers to be rendered to the map. After cluster
   * item (marker) is rendered, it is sent to the listeners for control.
   */
  private static class ClusterRenderer extends DefaultClusterRenderer<MarkerBuilder> {
    private final ClusterManagersController clusterManagersController;

    public ClusterRenderer(
        Context context,
        GoogleMap map,
        ClusterManager<MarkerBuilder> clusterManager,
        ClusterManagersController clusterManagersController) {
      super(context, map, clusterManager);
      this.clusterManagersController = clusterManagersController;
    }

    @Override
    protected void onBeforeClusterItemRendered(
        @NonNull MarkerBuilder item, @NonNull MarkerOptions markerOptions) {
      // Builds new markerOptions for new marker created by the ClusterRenderer under
      // ClusterManager.
      item.update(markerOptions);
    }

    @Override
    protected void onClusterItemRendered(@NonNull MarkerBuilder item, @NonNull Marker marker) {
      super.onClusterItemRendered(item, marker);
      clusterManagersController.onClusterItemRendered(item, marker);
    }
  }

  /** Interface for handling situations where clusterManager adds new visible marker to the map. */
  public interface OnClusterItemRendered<T extends ClusterItem> {
    void onClusterItemRendered(@NonNull T item, @NonNull Marker marker);
  }
}
