// Copyright 2013 The Flutter Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

#import <XCTest/XCTest.h>
#import "message.gen.h"

@interface ACMessageSearchReply ()
+ (ACMessageSearchReply *)fromList:(NSArray *)list;
- (NSArray *)toList;
@end

@interface RunnerTests : XCTestCase

@end

@implementation RunnerTests

- (void)testToMapAndBack {
  ACMessageSearchReply *reply = [[ACMessageSearchReply alloc] init];
  reply.result = @"foobar";
  NSArray *list = [reply toList];
  ACMessageSearchReply *copy = [ACMessageSearchReply fromList:list];
  XCTAssertEqual(reply.result, copy.result);
}

- (void)testHandlesNull {
  ACMessageSearchReply *reply = [[ACMessageSearchReply alloc] init];
  reply.result = nil;
  NSArray *list = [reply toList];
  ACMessageSearchReply *copy = [ACMessageSearchReply fromList:list];
  XCTAssertEqualObjects(copy.result, [NSNull null]);
}

- (void)testHandlesNullFirst {
  ACMessageSearchReply *reply = [[ACMessageSearchReply alloc] init];
  reply.error = @"foobar";
  NSArray *list = [reply toList];
  ACMessageSearchReply *copy = [ACMessageSearchReply fromList:list];
  XCTAssertEqual(reply.error, copy.error);
}

@end
