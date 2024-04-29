package dev.flutter.packages.interactive_media_ads

import com.google.ads.interactivemedia.v3.api.AdErrorEvent
import com.google.ads.interactivemedia.v3.api.AdEvent
import com.google.ads.interactivemedia.v3.api.BaseManager

class BaseManagerProxyApi(pigeonRegistrar: PigeonProxyApiRegistrar) :
    PigeonApiBaseManager(pigeonRegistrar) {
  override fun addAdErrorListener(
      pigeon_instance: BaseManager,
      errorListener: AdErrorEvent.AdErrorListener
  ) {
    pigeon_instance.addAdErrorListener(errorListener)
  }

  override fun addAdEventListener(
      pigeon_instance: BaseManager,
      adEventListener: AdEvent.AdEventListener
  ) {
    pigeon_instance.addAdEventListener(adEventListener)
  }

  override fun destroy(pigeon_instance: BaseManager) {
    pigeon_instance.destroy()
  }

  override fun init(pigeon_instance: BaseManager) {
    pigeon_instance.init()
  }
}
