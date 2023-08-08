// Copyright 2013 The Flutter Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

#import "FVPResourceLoader.h"
#import "FVPContentCacheWorker.h"
#import "FVPContentDownloader.h"
#import "FVPContentInfo.h"
#import "FVPResourceLoadingRequestWorker.h"

NSString *const mFVPResourceLoaderErrorDomainE = @"FVPFilePlayerResourceLoaderErrorDomain";

@interface FVPResourceLoader () <FVPResourceLoadingRequestWorkerDelegate>

@property(nonatomic, strong, readwrite) NSURL *url;
@property(nonatomic, strong) FVPContentCacheWorker *cacheWorker;
@property(nonatomic, strong) FVPContentDownloader *contentDownloader;
@property(nonatomic, strong)
    NSMutableArray<FVPResourceLoadingRequestWorker *> *pendingRequestWorkers;

@property(nonatomic, getter=isCancelled) BOOL cancelled;

@end

@implementation FVPResourceLoader

- (void)dealloc {
  [_contentDownloader cancel];
}

- (instancetype)initWithURL:(NSURL *)url error:(NSError *)error {
  self = [super init];
  if (self) {
    _url = url;
      _cacheWorker = [[FVPContentCacheWorker alloc] initWithURL:url error:error];
    _contentDownloader = [[FVPContentDownloader alloc] initWithURL:url cacheWorker:_cacheWorker];
    _pendingRequestWorkers = [NSMutableArray array];
  }
  return self;
}

- (instancetype)init {
  NSAssert(NO, @"Use - initWithURL: instead");
  return nil;
}

- (void)addRequest:(AVAssetResourceLoadingRequest *)request {
  if (self.pendingRequestWorkers.count > 0) {
    [self startNoCacheWorkerWithRequest:request];
  } else {
    [self startWorkerWithRequest:request];
  }
}

- (void)removeRequest:(AVAssetResourceLoadingRequest *)request {
  __block FVPResourceLoadingRequestWorker *requestWorker = nil;
  [self.pendingRequestWorkers
      enumerateObjectsUsingBlock:^(FVPResourceLoadingRequestWorker *_Nonnull obj, NSUInteger idx,
                                   BOOL *_Nonnull stop) {
        if (obj.request == request) {
          requestWorker = obj;
          *stop = YES;
        }
      }];
  if (requestWorker) {
    [requestWorker finish];
    [self.pendingRequestWorkers removeObject:requestWorker];
  }
}

- (void)cancel {
  [self.contentDownloader cancel];
  [self.pendingRequestWorkers removeAllObjects];

  [[FVPContentDownloaderStatus shared] removeURL:self.url];
}

#pragma mark - FVPResourceLoadingRequestWorkerDelegate

- (void)resourceLoadingRequestWorker:(FVPResourceLoadingRequestWorker *)requestWorker
                didCompleteWithError:(NSError *)error {
  [self removeRequest:requestWorker.request];
  if (error && [self.delegate respondsToSelector:@selector(resourceLoader:didFailWithError:)]) {
    [self.delegate resourceLoader:self didFailWithError:error];
  }
  if (self.pendingRequestWorkers.count == 0) {
    [[FVPContentDownloaderStatus shared] removeURL:self.url];
  }
}

#pragma mark - Helper

- (void)startNoCacheWorkerWithRequest:(AVAssetResourceLoadingRequest *)request {
  [[FVPContentDownloaderStatus shared] addURL:self.url];
  FVPContentDownloader *contentDownloader =
      [[FVPContentDownloader alloc] initWithURL:self.url cacheWorker:self.cacheWorker];
  FVPResourceLoadingRequestWorker *requestWorker =
      [[FVPResourceLoadingRequestWorker alloc] initWithContentDownloader:contentDownloader
                                                  resourceLoadingRequest:request];
  [self.pendingRequestWorkers addObject:requestWorker];
  requestWorker.delegate = self;
  [requestWorker startWork];
}

- (void)startWorkerWithRequest:(AVAssetResourceLoadingRequest *)request {
  [[FVPContentDownloaderStatus shared] addURL:self.url];
  FVPResourceLoadingRequestWorker *requestWorker =
      [[FVPResourceLoadingRequestWorker alloc] initWithContentDownloader:self.contentDownloader
                                                  resourceLoadingRequest:request];
  [self.pendingRequestWorkers addObject:requestWorker];
  requestWorker.delegate = self;
  [requestWorker startWork];
}

- (NSError *)loaderCancelledError {
  NSError *error = [[NSError alloc]
      initWithDomain:mFVPResourceLoaderErrorDomainE
                code:-3
            userInfo:@{NSLocalizedDescriptionKey : @"FVP Resource loader cancelled"}];
  return error;
}

@end
