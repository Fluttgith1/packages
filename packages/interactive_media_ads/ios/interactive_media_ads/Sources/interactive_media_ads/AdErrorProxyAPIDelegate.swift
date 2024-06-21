//
//  AdErrorProxyAPIDelegate.swift
//  interactive_media_ads
//
//  Created by Maurice Parrish on 6/21/24.
//

import Foundation
import GoogleInteractiveMediaAds

class AdErrorProxyAPIDelegate: PigeonDelegateIMAAdError {
  func type(pigeonApi: PigeonApiIMAAdError, pigeonInstance: IMAAdError) throws -> AdErrorType {
    switch pigeonInstance.type {
    case .adLoadingFailed:
      return .loadingFailed
    case .adPlayingFailed:
      return .adPlayingFailed
    case .adUnknownErrorType:
      return .unknown
    @unknown default:
      return .unknown
    }
  }
  
  func code(pigeonApi: PigeonApiIMAAdError, pigeonInstance: IMAAdError) throws -> AdErrorCode {
    switch pigeonInstance.code {
    case .VAST_MALFORMED_RESPONSE:
      return .vastMalformedResponse
    case .VAST_TRAFFICKING_ERROR:
      return .vastTraffickingError
    case .VAST_LOAD_TIMEOUT:
      return .vastLoadTimeout
    case .VAST_TOO_MANY_REDIRECTS:
      return .vastTooManyRedirects
    case .VAST_INVALID_URL:
      return .vastInvalidUrl
    case .VIDEO_PLAY_ERROR:
      return .videoPlayError
    case .VAST_MEDIA_LOAD_TIMEOUT:
      return .vastMediaLoadTimeout
    case .VAST_LINEAR_ASSET_MISMATCH:
      return .vastLinearAssetMismatch
    case .COMPANION_AD_LOADING_FAILED:
      return .companionAdLoadingFailed
    case .UNKNOWN_ERROR:
      return .unknownError
    case .PLAYLIST_MALFORMED_RESPONSE:
      return .playlistMalformedResponse
    case .FAILED_TO_REQUEST_ADS:
      return .failedToRequestAds
    case .REQUIRED_LISTENERS_NOT_ADDED:
      return .requiredListenersNotAdded
    case .VAST_ASSET_NOT_FOUND:
      return .vastAssetNotFound
    case .ADSLOT_NOT_VISIBLE:
      return .adslotNotVisible
    case .VAST_EMPTY_RESPONSE:
      return .vastEmptyResponse
    case .FAILED_LOADING_AD:
      return .failedLoadingAd
    case .STREAM_INITIALIZATION_FAILED:
      return .streamInitializationFailed
    case .INVALID_ARGUMENTS:
      return .invalidArguments
    case .API_ERROR:
      return .apiError
    case .OS_RUNTIME_TOO_OLD:
      return .osRuntimeTooOld
    case .VIDEO_ELEMENT_USED:
      return .videoElementUsed
    case .VIDEO_ELEMENT_REQUIRED:
      return .videoElementRequired
    case .CONTENT_PLAYHEAD_MISSING:
      return .contentPlayheadMissing
    @unknown default:
      return .unknownError
    }
  }
  
  func message(pigeonApi: PigeonApiIMAAdError, pigeonInstance: IMAAdError) throws -> String? {
    return pigeonInstance.message
  }
}
