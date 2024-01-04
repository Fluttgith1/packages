// Copyright 2013 The Flutter Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

#import <Flutter/Flutter.h>
#import <GoogleMaps/GoogleMaps.h>

// Defines polyline controllable by Flutter.
@interface FLTGoogleMapPolylineController : NSObject
@property(strong, nonatomic) GMSPolyline *polyline;

- (instancetype)initPolylineWithPath:(GMSMutablePath *)path
                          identifier:(NSString *)identifier
                             mapView:(GMSMapView *)mapView;
- (void)removePolyline;
- (void)setPattern:(NSArray<GMSStrokeStyle *> *)styles lengths:(NSArray<NSNumber *> *)lengths;
@end

@interface FLTPolylinesController : NSObject
- (instancetype)init:(FlutterMethodChannel *)methodChannel
             mapView:(GMSMapView *)mapView
           registrar:(NSObject<FlutterPluginRegistrar> *)registrar;
- (void)addPolylines:(NSArray *)polylinesToAdd;
- (void)changePolylines:(NSArray *)polylinesToChange;
- (void)removePolylineWithIdentifiers:(NSArray *)identifiers;
- (void)didTapPolylineWithIdentifier:(NSString *)identifier;
- (bool)hasPolylineWithIdentifier:(NSString *)identifier;
+ (GMSMutablePath *)getPath:(NSDictionary *)polyline;
@end
