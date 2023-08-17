// Copyright 2013 The Flutter Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

#import <XCTest/XCTest.h>
#import "FVPContentDownloader.h"
#import "FVPContentCacheWorker.h"

@interface FVPContentDownloaderTests : XCTestCase

@property (nonatomic, strong) FVPContentCacheWorker *cacheWorker;
@property (nonatomic, strong) FVPContentDownloader *contentDownloader;
@property (nonatomic, strong) XCTestExpectation *expectation;

@end

@implementation FVPContentDownloaderTests

- (void)setUp {
    [super setUp];
    // Initialize cacheWorker and other necessary objects
    NSURL *testURL = [NSURL URLWithString:@"https://example.com/test-video.mp4"];
    NSError *error = nil;
    self.cacheWorker = [[FVPContentCacheWorker alloc] initWithURL:testURL error:error];
    XCTAssertNotNil(self.cacheWorker);
    XCTAssertNil(error);
    
    self.expectation = [self expectationWithDescription:@"Download completion"];
    
    self.contentDownloader = [[FVPContentDownloader alloc] initWithURL:testURL cacheWorker:self.cacheWorker];
}

- (void)tearDown {
    self.cacheWorker = nil;
    self.contentDownloader = nil;
    self.expectation = nil;
    [super tearDown];
}
@end
