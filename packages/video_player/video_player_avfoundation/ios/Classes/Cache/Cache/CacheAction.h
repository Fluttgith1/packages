// Copyright 2013 The Flutter Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

#import <Foundation/Foundation.h>

typedef enum { CacheTypeLocal = 0, CacheTypeRemote } CacheType;

@interface CacheAction : NSObject

- (instancetype)initWithActionType:(CacheType)cacheType range:(NSRange)range;

/*!
 * @property cacheType
 * CacheTypeRemote and CacheTypeLocal are cache optimization options.
 * CacheTypeRemote acts as a local cache refresh action by setting the
 * NSURLRequestReloadIgnoringLocalAndRemoteCacheData flag. When this cache policy is used, it means
 * Ignore local cache data, and instruct proxies and other intermediates to disregard their caches
 * so far as the protocol allows. CacheTypeLocal uses localCache. It does not validate the relevance
 * of it.
 */
@property(nonatomic) CacheType cacheType;

/*!
 * @property range
 * An NSRange that specifies the range of data to be cached.
 */
@property(nonatomic) NSRange range;

@end
