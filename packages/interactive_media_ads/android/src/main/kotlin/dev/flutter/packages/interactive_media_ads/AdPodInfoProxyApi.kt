package dev.flutter.packages.interactive_media_ads

import com.google.ads.interactivemedia.v3.api.AdPodInfo

class AdPodInfoProxyApi(pigeonRegistrar: PigeonProxyApiRegistrar) :
    PigeonApiAdPodInfo(pigeonRegistrar) {
  override fun adPosition(pigeon_instance: AdPodInfo): Long {
    return pigeon_instance.adPosition.toLong()
  }

  override fun maxDuration(pigeon_instance: AdPodInfo): Double {
    return pigeon_instance.maxDuration
  }

  override fun podIndex(pigeon_instance: AdPodInfo): Long {
    return pigeon_instance.podIndex.toLong()
  }

  override fun timeOffset(pigeon_instance: AdPodInfo): Double {
    return pigeon_instance.timeOffset
  }

  override fun totalAds(pigeon_instance: AdPodInfo): Long {
    return pigeon_instance.totalAds.toLong()
  }

  override fun isBumper(pigeon_instance: AdPodInfo): Boolean {
    return pigeon_instance.isBumper
  }
}
