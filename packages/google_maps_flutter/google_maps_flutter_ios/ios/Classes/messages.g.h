// Copyright 2013 The Flutter Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.
// Autogenerated from Pigeon (v22.4.2), do not edit directly.
// See also: https://pub.dev/packages/pigeon

#import <Foundation/Foundation.h>

@protocol FlutterBinaryMessenger;
@protocol FlutterMessageCodec;
@class FlutterError;
@class FlutterStandardTypedData;

NS_ASSUME_NONNULL_BEGIN

/// Pigeon equivalent of MapType
typedef NS_ENUM(NSUInteger, FGMPlatformMapType) {
  FGMPlatformMapTypeNone = 0,
  FGMPlatformMapTypeNormal = 1,
  FGMPlatformMapTypeSatellite = 2,
  FGMPlatformMapTypeTerrain = 3,
  FGMPlatformMapTypeHybrid = 4,
};

/// Wrapper for FGMPlatformMapType to allow for nullability.
@interface FGMPlatformMapTypeBox : NSObject
@property(nonatomic, assign) FGMPlatformMapType value;
- (instancetype)initWithValue:(FGMPlatformMapType)value;
@end

typedef NS_ENUM(NSUInteger, FGMPlatformMarkerType) {
  FGMPlatformMarkerTypeLegacy = 0,
  FGMPlatformMarkerTypeAdvanced = 1,
};

/// Wrapper for FGMPlatformMarkerType to allow for nullability.
@interface FGMPlatformMarkerTypeBox : NSObject
@property(nonatomic, assign) FGMPlatformMarkerType value;
- (instancetype)initWithValue:(FGMPlatformMarkerType)value;
@end

@class FGMPlatformCameraPosition;
@class FGMPlatformCameraUpdate;
@class FGMPlatformCircle;
@class FGMPlatformHeatmap;
@class FGMPlatformCluster;
@class FGMPlatformClusterManager;
@class FGMPlatformMarker;
@class FGMPlatformPolygon;
@class FGMPlatformPolyline;
@class FGMPlatformTile;
@class FGMPlatformTileOverlay;
@class FGMPlatformEdgeInsets;
@class FGMPlatformLatLng;
@class FGMPlatformLatLngBounds;
@class FGMPlatformCameraTargetBounds;
@class FGMPlatformMapViewCreationParams;
@class FGMPlatformMapConfiguration;
@class FGMPlatformPoint;
@class FGMPlatformTileLayer;
@class FGMPlatformZoomRange;

/// Pigeon representatation of a CameraPosition.
@interface FGMPlatformCameraPosition : NSObject
/// `init` unavailable to enforce nonnull fields, see the `make` class method.
- (instancetype)init NS_UNAVAILABLE;
+ (instancetype)makeWithBearing:(double)bearing
                         target:(FGMPlatformLatLng *)target
                           tilt:(double)tilt
                           zoom:(double)zoom;
@property(nonatomic, assign) double bearing;
@property(nonatomic, strong) FGMPlatformLatLng *target;
@property(nonatomic, assign) double tilt;
@property(nonatomic, assign) double zoom;
@end

/// Pigeon representation of a CameraUpdate.
@interface FGMPlatformCameraUpdate : NSObject
/// `init` unavailable to enforce nonnull fields, see the `make` class method.
- (instancetype)init NS_UNAVAILABLE;
+ (instancetype)makeWithJson:(id)json;
/// The update data, as JSON. This should only be set from
/// CameraUpdate.toJson, and the native code must interpret it according to the
/// internal implementation details of the CameraUpdate class.
@property(nonatomic, strong) id json;
@end

/// Pigeon equivalent of the Circle class.
@interface FGMPlatformCircle : NSObject
/// `init` unavailable to enforce nonnull fields, see the `make` class method.
- (instancetype)init NS_UNAVAILABLE;
+ (instancetype)makeWithJson:(id)json;
/// The circle data, as JSON. This should only be set from
/// Circle.toJson, and the native code must interpret it according to the
/// internal implementation details of that method.
@property(nonatomic, strong) id json;
@end

/// Pigeon equivalent of the Heatmap class.
@interface FGMPlatformHeatmap : NSObject
/// `init` unavailable to enforce nonnull fields, see the `make` class method.
- (instancetype)init NS_UNAVAILABLE;
+ (instancetype)makeWithJson:(id)json;
/// The heatmap data, as JSON. This should only be set from
/// Heatmap.toJson, and the native code must interpret it according to the
/// internal implementation details of that method.
@property(nonatomic, strong) id json;
@end

/// Pigeon equivalent of Cluster.
@interface FGMPlatformCluster : NSObject
/// `init` unavailable to enforce nonnull fields, see the `make` class method.
- (instancetype)init NS_UNAVAILABLE;
+ (instancetype)makeWithClusterManagerId:(NSString *)clusterManagerId
                                position:(FGMPlatformLatLng *)position
                                  bounds:(FGMPlatformLatLngBounds *)bounds
                               markerIds:(NSArray<NSString *> *)markerIds;
@property(nonatomic, copy) NSString *clusterManagerId;
@property(nonatomic, strong) FGMPlatformLatLng *position;
@property(nonatomic, strong) FGMPlatformLatLngBounds *bounds;
@property(nonatomic, copy) NSArray<NSString *> *markerIds;
@end

/// Pigeon equivalent of the ClusterManager class.
@interface FGMPlatformClusterManager : NSObject
/// `init` unavailable to enforce nonnull fields, see the `make` class method.
- (instancetype)init NS_UNAVAILABLE;
+ (instancetype)makeWithIdentifier:(NSString *)identifier;
@property(nonatomic, copy) NSString *identifier;
@end

/// Pigeon equivalent of the Marker class.
@interface FGMPlatformMarker : NSObject
/// `init` unavailable to enforce nonnull fields, see the `make` class method.
- (instancetype)init NS_UNAVAILABLE;
+ (instancetype)makeWithJson:(id)json;
/// The marker data, as JSON. This should only be set from
/// Marker.toJson, and the native code must interpret it according to the
/// internal implementation details of that method.
@property(nonatomic, strong) id json;
@end

/// Pigeon equivalent of the Polygon class.
@interface FGMPlatformPolygon : NSObject
/// `init` unavailable to enforce nonnull fields, see the `make` class method.
- (instancetype)init NS_UNAVAILABLE;
+ (instancetype)makeWithJson:(id)json;
/// The polygon data, as JSON. This should only be set from
/// Polygon.toJson, and the native code must interpret it according to the
/// internal implementation details of that method.
@property(nonatomic, strong) id json;
@end

/// Pigeon equivalent of the Polyline class.
@interface FGMPlatformPolyline : NSObject
/// `init` unavailable to enforce nonnull fields, see the `make` class method.
- (instancetype)init NS_UNAVAILABLE;
+ (instancetype)makeWithJson:(id)json;
/// The polyline data, as JSON. This should only be set from
/// Polyline.toJson, and the native code must interpret it according to the
/// internal implementation details of that method.
@property(nonatomic, strong) id json;
@end

/// Pigeon equivalent of the Tile class.
@interface FGMPlatformTile : NSObject
/// `init` unavailable to enforce nonnull fields, see the `make` class method.
- (instancetype)init NS_UNAVAILABLE;
+ (instancetype)makeWithWidth:(NSInteger)width
                       height:(NSInteger)height
                         data:(nullable FlutterStandardTypedData *)data;
@property(nonatomic, assign) NSInteger width;
@property(nonatomic, assign) NSInteger height;
@property(nonatomic, strong, nullable) FlutterStandardTypedData *data;
@end

/// Pigeon equivalent of the TileOverlay class.
@interface FGMPlatformTileOverlay : NSObject
/// `init` unavailable to enforce nonnull fields, see the `make` class method.
- (instancetype)init NS_UNAVAILABLE;
+ (instancetype)makeWithJson:(id)json;
/// The tile overlay data, as JSON. This should only be set from
/// TileOverlay.toJson, and the native code must interpret it according to the
/// internal implementation details of that method.
@property(nonatomic, strong) id json;
@end

/// Pigeon equivalent of Flutter's EdgeInsets.
@interface FGMPlatformEdgeInsets : NSObject
/// `init` unavailable to enforce nonnull fields, see the `make` class method.
- (instancetype)init NS_UNAVAILABLE;
+ (instancetype)makeWithTop:(double)top bottom:(double)bottom left:(double)left right:(double)right;
@property(nonatomic, assign) double top;
@property(nonatomic, assign) double bottom;
@property(nonatomic, assign) double left;
@property(nonatomic, assign) double right;
@end

/// Pigeon equivalent of LatLng.
@interface FGMPlatformLatLng : NSObject
/// `init` unavailable to enforce nonnull fields, see the `make` class method.
- (instancetype)init NS_UNAVAILABLE;
+ (instancetype)makeWithLatitude:(double)latitude longitude:(double)longitude;
@property(nonatomic, assign) double latitude;
@property(nonatomic, assign) double longitude;
@end

/// Pigeon equivalent of LatLngBounds.
@interface FGMPlatformLatLngBounds : NSObject
/// `init` unavailable to enforce nonnull fields, see the `make` class method.
- (instancetype)init NS_UNAVAILABLE;
+ (instancetype)makeWithNortheast:(FGMPlatformLatLng *)northeast
                        southwest:(FGMPlatformLatLng *)southwest;
@property(nonatomic, strong) FGMPlatformLatLng *northeast;
@property(nonatomic, strong) FGMPlatformLatLng *southwest;
@end

/// Pigeon equivalent of CameraTargetBounds.
///
/// As with the Dart version, it exists to distinguish between not setting a
/// a target, and having an explicitly unbounded target (null [bounds]).
@interface FGMPlatformCameraTargetBounds : NSObject
+ (instancetype)makeWithBounds:(nullable FGMPlatformLatLngBounds *)bounds;
@property(nonatomic, strong, nullable) FGMPlatformLatLngBounds *bounds;
@end

/// Information passed to the platform view creation.
@interface FGMPlatformMapViewCreationParams : NSObject
/// `init` unavailable to enforce nonnull fields, see the `make` class method.
- (instancetype)init NS_UNAVAILABLE;
+ (instancetype)
    makeWithInitialCameraPosition:(FGMPlatformCameraPosition *)initialCameraPosition
                 mapConfiguration:(FGMPlatformMapConfiguration *)mapConfiguration
                   initialCircles:(NSArray<FGMPlatformCircle *> *)initialCircles
                   initialMarkers:(NSArray<FGMPlatformMarker *> *)initialMarkers
                  initialPolygons:(NSArray<FGMPlatformPolygon *> *)initialPolygons
                 initialPolylines:(NSArray<FGMPlatformPolyline *> *)initialPolylines
                  initialHeatmaps:(NSArray<FGMPlatformHeatmap *> *)initialHeatmaps
              initialTileOverlays:(NSArray<FGMPlatformTileOverlay *> *)initialTileOverlays
           initialClusterManagers:(NSArray<FGMPlatformClusterManager *> *)initialClusterManagers
                       markerType:(FGMPlatformMarkerType)markerType;
@property(nonatomic, strong) FGMPlatformCameraPosition *initialCameraPosition;
@property(nonatomic, strong) FGMPlatformMapConfiguration *mapConfiguration;
@property(nonatomic, copy) NSArray<FGMPlatformCircle *> *initialCircles;
@property(nonatomic, copy) NSArray<FGMPlatformMarker *> *initialMarkers;
@property(nonatomic, copy) NSArray<FGMPlatformPolygon *> *initialPolygons;
@property(nonatomic, copy) NSArray<FGMPlatformPolyline *> *initialPolylines;
@property(nonatomic, copy) NSArray<FGMPlatformHeatmap *> *initialHeatmaps;
@property(nonatomic, copy) NSArray<FGMPlatformTileOverlay *> *initialTileOverlays;
@property(nonatomic, copy) NSArray<FGMPlatformClusterManager *> *initialClusterManagers;
@property(nonatomic, assign) FGMPlatformMarkerType markerType;
@end

/// Pigeon equivalent of MapConfiguration.
@interface FGMPlatformMapConfiguration : NSObject
+ (instancetype)makeWithCompassEnabled:(nullable NSNumber *)compassEnabled
                    cameraTargetBounds:(nullable FGMPlatformCameraTargetBounds *)cameraTargetBounds
                               mapType:(nullable FGMPlatformMapTypeBox *)mapType
                  minMaxZoomPreference:(nullable FGMPlatformZoomRange *)minMaxZoomPreference
                 rotateGesturesEnabled:(nullable NSNumber *)rotateGesturesEnabled
                 scrollGesturesEnabled:(nullable NSNumber *)scrollGesturesEnabled
                   tiltGesturesEnabled:(nullable NSNumber *)tiltGesturesEnabled
                   trackCameraPosition:(nullable NSNumber *)trackCameraPosition
                   zoomGesturesEnabled:(nullable NSNumber *)zoomGesturesEnabled
                     myLocationEnabled:(nullable NSNumber *)myLocationEnabled
               myLocationButtonEnabled:(nullable NSNumber *)myLocationButtonEnabled
                               padding:(nullable FGMPlatformEdgeInsets *)padding
                     indoorViewEnabled:(nullable NSNumber *)indoorViewEnabled
                        trafficEnabled:(nullable NSNumber *)trafficEnabled
                      buildingsEnabled:(nullable NSNumber *)buildingsEnabled
                                 mapId:(nullable NSString *)mapId
                                 style:(nullable NSString *)style;
@property(nonatomic, strong, nullable) NSNumber *compassEnabled;
@property(nonatomic, strong, nullable) FGMPlatformCameraTargetBounds *cameraTargetBounds;
@property(nonatomic, strong, nullable) FGMPlatformMapTypeBox *mapType;
@property(nonatomic, strong, nullable) FGMPlatformZoomRange *minMaxZoomPreference;
@property(nonatomic, strong, nullable) NSNumber *rotateGesturesEnabled;
@property(nonatomic, strong, nullable) NSNumber *scrollGesturesEnabled;
@property(nonatomic, strong, nullable) NSNumber *tiltGesturesEnabled;
@property(nonatomic, strong, nullable) NSNumber *trackCameraPosition;
@property(nonatomic, strong, nullable) NSNumber *zoomGesturesEnabled;
@property(nonatomic, strong, nullable) NSNumber *myLocationEnabled;
@property(nonatomic, strong, nullable) NSNumber *myLocationButtonEnabled;
@property(nonatomic, strong, nullable) FGMPlatformEdgeInsets *padding;
@property(nonatomic, strong, nullable) NSNumber *indoorViewEnabled;
@property(nonatomic, strong, nullable) NSNumber *trafficEnabled;
@property(nonatomic, strong, nullable) NSNumber *buildingsEnabled;
@property(nonatomic, copy, nullable) NSString *mapId;
@property(nonatomic, copy, nullable) NSString *style;
@end

/// Pigeon representation of an x,y coordinate.
@interface FGMPlatformPoint : NSObject
/// `init` unavailable to enforce nonnull fields, see the `make` class method.
- (instancetype)init NS_UNAVAILABLE;
+ (instancetype)makeWithX:(double)x y:(double)y;
@property(nonatomic, assign) double x;
@property(nonatomic, assign) double y;
@end

/// Pigeon equivalent of GMSTileLayer properties.
@interface FGMPlatformTileLayer : NSObject
/// `init` unavailable to enforce nonnull fields, see the `make` class method.
- (instancetype)init NS_UNAVAILABLE;
+ (instancetype)makeWithVisible:(BOOL)visible
                         fadeIn:(BOOL)fadeIn
                        opacity:(double)opacity
                         zIndex:(NSInteger)zIndex;
@property(nonatomic, assign) BOOL visible;
@property(nonatomic, assign) BOOL fadeIn;
@property(nonatomic, assign) double opacity;
@property(nonatomic, assign) NSInteger zIndex;
@end

/// Pigeon equivalent of MinMaxZoomPreference.
@interface FGMPlatformZoomRange : NSObject
+ (instancetype)makeWithMin:(nullable NSNumber *)min max:(nullable NSNumber *)max;
@property(nonatomic, strong, nullable) NSNumber *min;
@property(nonatomic, strong, nullable) NSNumber *max;
@end

/// The codec used by all APIs.
NSObject<FlutterMessageCodec> *FGMGetMessagesCodec(void);

/// Interface for non-test interactions with the native SDK.
///
/// For test-only state queries, see [MapsInspectorApi].
@protocol FGMMapsApi
/// Returns once the map instance is available.
- (void)waitForMapWithError:(FlutterError *_Nullable *_Nonnull)error;
/// Updates the map's configuration options.
///
/// Only non-null configuration values will result in updates; options with
/// null values will remain unchanged.
- (void)updateWithMapConfiguration:(FGMPlatformMapConfiguration *)configuration
                             error:(FlutterError *_Nullable *_Nonnull)error;
/// Updates the set of circles on the map.
- (void)updateCirclesByAdding:(NSArray<FGMPlatformCircle *> *)toAdd
                     changing:(NSArray<FGMPlatformCircle *> *)toChange
                     removing:(NSArray<NSString *> *)idsToRemove
                        error:(FlutterError *_Nullable *_Nonnull)error;
/// Updates the set of heatmaps on the map.
- (void)updateHeatmapsByAdding:(NSArray<FGMPlatformHeatmap *> *)toAdd
                      changing:(NSArray<FGMPlatformHeatmap *> *)toChange
                      removing:(NSArray<NSString *> *)idsToRemove
                         error:(FlutterError *_Nullable *_Nonnull)error;
/// Updates the set of custer managers for clusters on the map.
- (void)updateClusterManagersByAdding:(NSArray<FGMPlatformClusterManager *> *)toAdd
                             removing:(NSArray<NSString *> *)idsToRemove
                                error:(FlutterError *_Nullable *_Nonnull)error;
/// Updates the set of markers on the map.
- (void)updateMarkersByAdding:(NSArray<FGMPlatformMarker *> *)toAdd
                     changing:(NSArray<FGMPlatformMarker *> *)toChange
                     removing:(NSArray<NSString *> *)idsToRemove
                        error:(FlutterError *_Nullable *_Nonnull)error;
/// Updates the set of polygonss on the map.
- (void)updatePolygonsByAdding:(NSArray<FGMPlatformPolygon *> *)toAdd
                      changing:(NSArray<FGMPlatformPolygon *> *)toChange
                      removing:(NSArray<NSString *> *)idsToRemove
                         error:(FlutterError *_Nullable *_Nonnull)error;
/// Updates the set of polylines on the map.
- (void)updatePolylinesByAdding:(NSArray<FGMPlatformPolyline *> *)toAdd
                       changing:(NSArray<FGMPlatformPolyline *> *)toChange
                       removing:(NSArray<NSString *> *)idsToRemove
                          error:(FlutterError *_Nullable *_Nonnull)error;
/// Updates the set of tile overlays on the map.
- (void)updateTileOverlaysByAdding:(NSArray<FGMPlatformTileOverlay *> *)toAdd
                          changing:(NSArray<FGMPlatformTileOverlay *> *)toChange
                          removing:(NSArray<NSString *> *)idsToRemove
                             error:(FlutterError *_Nullable *_Nonnull)error;
/// Gets the screen coordinate for the given map location.
///
/// @return `nil` only when `error != nil`.
- (nullable FGMPlatformPoint *)screenCoordinatesForLatLng:(FGMPlatformLatLng *)latLng
                                                    error:(FlutterError *_Nullable *_Nonnull)error;
/// Gets the map location for the given screen coordinate.
///
/// @return `nil` only when `error != nil`.
- (nullable FGMPlatformLatLng *)latLngForScreenCoordinate:(FGMPlatformPoint *)screenCoordinate
                                                    error:(FlutterError *_Nullable *_Nonnull)error;
/// Gets the map region currently displayed on the map.
///
/// @return `nil` only when `error != nil`.
- (nullable FGMPlatformLatLngBounds *)visibleMapRegion:(FlutterError *_Nullable *_Nonnull)error;
/// Moves the camera according to [cameraUpdate] immediately, with no
/// animation.
- (void)moveCameraWithUpdate:(FGMPlatformCameraUpdate *)cameraUpdate
                       error:(FlutterError *_Nullable *_Nonnull)error;
/// Moves the camera according to [cameraUpdate], animating the update.
- (void)animateCameraWithUpdate:(FGMPlatformCameraUpdate *)cameraUpdate
                          error:(FlutterError *_Nullable *_Nonnull)error;
/// Gets the current map zoom level.
///
/// @return `nil` only when `error != nil`.
- (nullable NSNumber *)currentZoomLevel:(FlutterError *_Nullable *_Nonnull)error;
/// Show the info window for the marker with the given ID.
- (void)showInfoWindowForMarkerWithIdentifier:(NSString *)markerId
                                        error:(FlutterError *_Nullable *_Nonnull)error;
/// Hide the info window for the marker with the given ID.
- (void)hideInfoWindowForMarkerWithIdentifier:(NSString *)markerId
                                        error:(FlutterError *_Nullable *_Nonnull)error;
/// Returns true if the marker with the given ID is currently displaying its
/// info window.
///
/// @return `nil` only when `error != nil`.
- (nullable NSNumber *)
    isShowingInfoWindowForMarkerWithIdentifier:(NSString *)markerId
                                         error:(FlutterError *_Nullable *_Nonnull)error;
/// Sets the style to the given map style string, where an empty string
/// indicates that the style should be cleared.
///
/// If there was an error setting the style, such as an invalid style string,
/// returns the error message.
- (nullable NSString *)setStyle:(NSString *)style error:(FlutterError *_Nullable *_Nonnull)error;
/// Returns the error string from the last attempt to set the map style, if
/// any.
///
/// This allows checking asynchronously for initial style failures, as there
/// is no way to return failures from map initialization.
- (nullable NSString *)lastStyleError:(FlutterError *_Nullable *_Nonnull)error;
/// Clears the cache of tiles previously requseted from the tile provider.
- (void)clearTileCacheForOverlayWithIdentifier:(NSString *)tileOverlayId
                                         error:(FlutterError *_Nullable *_Nonnull)error;
/// Takes a snapshot of the map and returns its image data.
- (nullable FlutterStandardTypedData *)takeSnapshotWithError:
    (FlutterError *_Nullable *_Nonnull)error;
/// Returns true if the map supports advanced markers
///
/// @return `nil` only when `error != nil`.
- (nullable NSNumber *)isAdvancedMarkersAvailable:(FlutterError *_Nullable *_Nonnull)error;
@end

extern void SetUpFGMMapsApi(id<FlutterBinaryMessenger> binaryMessenger,
                            NSObject<FGMMapsApi> *_Nullable api);

extern void SetUpFGMMapsApiWithSuffix(id<FlutterBinaryMessenger> binaryMessenger,
                                      NSObject<FGMMapsApi> *_Nullable api,
                                      NSString *messageChannelSuffix);

/// Interface for calls from the native SDK to Dart.
@interface FGMMapsCallbackApi : NSObject
- (instancetype)initWithBinaryMessenger:(id<FlutterBinaryMessenger>)binaryMessenger;
- (instancetype)initWithBinaryMessenger:(id<FlutterBinaryMessenger>)binaryMessenger
                   messageChannelSuffix:(nullable NSString *)messageChannelSuffix;
/// Called when the map camera starts moving.
- (void)didStartCameraMoveWithCompletion:(void (^)(FlutterError *_Nullable))completion;
/// Called when the map camera moves.
- (void)didMoveCameraToPosition:(FGMPlatformCameraPosition *)cameraPosition
                     completion:(void (^)(FlutterError *_Nullable))completion;
/// Called when the map camera stops moving.
- (void)didIdleCameraWithCompletion:(void (^)(FlutterError *_Nullable))completion;
/// Called when the map, not a specifc map object, is tapped.
- (void)didTapAtPosition:(FGMPlatformLatLng *)position
              completion:(void (^)(FlutterError *_Nullable))completion;
/// Called when the map, not a specifc map object, is long pressed.
- (void)didLongPressAtPosition:(FGMPlatformLatLng *)position
                    completion:(void (^)(FlutterError *_Nullable))completion;
/// Called when a marker is tapped.
- (void)didTapMarkerWithIdentifier:(NSString *)markerId
                        completion:(void (^)(FlutterError *_Nullable))completion;
/// Called when a marker drag starts.
- (void)didStartDragForMarkerWithIdentifier:(NSString *)markerId
                                 atPosition:(FGMPlatformLatLng *)position
                                 completion:(void (^)(FlutterError *_Nullable))completion;
/// Called when a marker drag updates.
- (void)didDragMarkerWithIdentifier:(NSString *)markerId
                         atPosition:(FGMPlatformLatLng *)position
                         completion:(void (^)(FlutterError *_Nullable))completion;
/// Called when a marker drag ends.
- (void)didEndDragForMarkerWithIdentifier:(NSString *)markerId
                               atPosition:(FGMPlatformLatLng *)position
                               completion:(void (^)(FlutterError *_Nullable))completion;
/// Called when a marker's info window is tapped.
- (void)didTapInfoWindowOfMarkerWithIdentifier:(NSString *)markerId
                                    completion:(void (^)(FlutterError *_Nullable))completion;
/// Called when a circle is tapped.
- (void)didTapCircleWithIdentifier:(NSString *)circleId
                        completion:(void (^)(FlutterError *_Nullable))completion;
/// Called when a marker cluster is tapped.
- (void)didTapCluster:(FGMPlatformCluster *)cluster
           completion:(void (^)(FlutterError *_Nullable))completion;
/// Called when a polygon is tapped.
- (void)didTapPolygonWithIdentifier:(NSString *)polygonId
                         completion:(void (^)(FlutterError *_Nullable))completion;
/// Called when a polyline is tapped.
- (void)didTapPolylineWithIdentifier:(NSString *)polylineId
                          completion:(void (^)(FlutterError *_Nullable))completion;
/// Called to get data for a map tile.
- (void)tileWithOverlayIdentifier:(NSString *)tileOverlayId
                         location:(FGMPlatformPoint *)location
                             zoom:(NSInteger)zoom
                       completion:(void (^)(FGMPlatformTile *_Nullable,
                                            FlutterError *_Nullable))completion;
@end

/// Dummy interface to force generation of the platform view creation params,
/// which are not used in any Pigeon calls, only the platform view creation
/// call made internally by Flutter.
@protocol FGMMapsPlatformViewApi
- (void)createViewType:(nullable FGMPlatformMapViewCreationParams *)type
                 error:(FlutterError *_Nullable *_Nonnull)error;
@end

extern void SetUpFGMMapsPlatformViewApi(id<FlutterBinaryMessenger> binaryMessenger,
                                        NSObject<FGMMapsPlatformViewApi> *_Nullable api);

extern void SetUpFGMMapsPlatformViewApiWithSuffix(id<FlutterBinaryMessenger> binaryMessenger,
                                                  NSObject<FGMMapsPlatformViewApi> *_Nullable api,
                                                  NSString *messageChannelSuffix);

/// Inspector API only intended for use in integration tests.
@protocol FGMMapsInspectorApi
/// @return `nil` only when `error != nil`.
- (nullable NSNumber *)areBuildingsEnabledWithError:(FlutterError *_Nullable *_Nonnull)error;
/// @return `nil` only when `error != nil`.
- (nullable NSNumber *)areRotateGesturesEnabledWithError:(FlutterError *_Nullable *_Nonnull)error;
/// @return `nil` only when `error != nil`.
- (nullable NSNumber *)areScrollGesturesEnabledWithError:(FlutterError *_Nullable *_Nonnull)error;
/// @return `nil` only when `error != nil`.
- (nullable NSNumber *)areTiltGesturesEnabledWithError:(FlutterError *_Nullable *_Nonnull)error;
/// @return `nil` only when `error != nil`.
- (nullable NSNumber *)areZoomGesturesEnabledWithError:(FlutterError *_Nullable *_Nonnull)error;
/// @return `nil` only when `error != nil`.
- (nullable NSNumber *)isCompassEnabledWithError:(FlutterError *_Nullable *_Nonnull)error;
/// @return `nil` only when `error != nil`.
- (nullable NSNumber *)isMyLocationButtonEnabledWithError:(FlutterError *_Nullable *_Nonnull)error;
/// @return `nil` only when `error != nil`.
- (nullable NSNumber *)isTrafficEnabledWithError:(FlutterError *_Nullable *_Nonnull)error;
- (nullable FGMPlatformTileLayer *)tileOverlayWithIdentifier:(NSString *)tileOverlayId
                                                       error:
                                                           (FlutterError *_Nullable *_Nonnull)error;
- (nullable FGMPlatformHeatmap *)heatmapWithIdentifier:(NSString *)heatmapId
                                                 error:(FlutterError *_Nullable *_Nonnull)error;
/// @return `nil` only when `error != nil`.
- (nullable FGMPlatformZoomRange *)zoomRange:(FlutterError *_Nullable *_Nonnull)error;
/// @return `nil` only when `error != nil`.
- (nullable NSArray<FGMPlatformCluster *> *)
    clustersWithIdentifier:(NSString *)clusterManagerId
                     error:(FlutterError *_Nullable *_Nonnull)error;
@end

extern void SetUpFGMMapsInspectorApi(id<FlutterBinaryMessenger> binaryMessenger,
                                     NSObject<FGMMapsInspectorApi> *_Nullable api);

extern void SetUpFGMMapsInspectorApiWithSuffix(id<FlutterBinaryMessenger> binaryMessenger,
                                               NSObject<FGMMapsInspectorApi> *_Nullable api,
                                               NSString *messageChannelSuffix);

NS_ASSUME_NONNULL_END
