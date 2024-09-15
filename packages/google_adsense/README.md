# google_adsense
[Google AdSense](https://adsense.google.com/intl/en_us/start/) plugin for Flutter Web

Generally integration with AdSense requires:

1. Adding an [AdSense code](https://support.google.com/adsense/answer/9274634?hl=en&ref_topic=28893&sjid=9002959242386336076-EU) usually in between the `<head></head>` tag to connect your site with AdSense account. Allows using **Auto ads**
2.  Adding [ad unit code](https://support.google.com/adsense/answer/9274025?sjid=9002959242386336076-EU) in between the `<body><body/>` tags of your pages where you want ad to appear. Ad unit code snippet is unique per **ad unit** that you need to create in your AdSense account first. You might have several ad units added to your website

Since Flutter apps are not rendered as traditional HTML pages and there is no easy way to access final DOM tree from Dart, this plugin provides an `AdUnitWidget` that you can configure and place in the desired location in your app UI


## Installation
run `flutter pub add google_adsense`

## Usage
#### Initialize AdSense
Before displaying ads, initialize the AdSense with your ad client ID.
<?code-excerpt "example/lib/main.dart (init)"?>
```dart
import 'package:google_adsense/google_adsense.dart';

void main() {
  Adsense().initialize('your_ad_client_id');
  runApp(const MyApp());
}

```
#### Display AdUnitWidget
<?code-excerpt "example/lib/main.dart (adUnit)"?>
```dart
Adsense().adUnit(
  adSlot: 'your_ad_slot_id',
  isAdTest: true,
  adUnitParams: <String, dynamic>{
    AdUnitParams.AD_FORMAT: 'auto',
    AdUnitParams.FULL_WIDTH_RESPONSIVE: true,
  },
)
```
## Testing and common errors

### Failed to load resource: the server responded with a status of 400
Make sure to replace `your_ad_client_id` and `your_ad_slot_id` with the relevant values

### Failed to load resource: the server responded with a status of 403
1. When happening in **testing/staging** environment it is likely related to the fact that ads are only filled when requested from an authorized domain. If you are testing locally, you can specify additional run arguments in IDE my editing `Run/Debug Configuration` or by passing them directly to `flutter run` command:  
    `--web-port=8080`  
    `--web-hostname=your-domain.com`
2. When happening in **production** it might be that your domain was not yet approved or was disapproved. Login to your AdSense account to check your domain approval status

### Ad unfilled  

There is no deterministic way to make sure your ads are 100% filled even when testing. Some of the way to increase the fill rate:


- Add AD_TEST parameter with value `true`  
- Make sure AD_FORMAT is `auto` (default setting)
- Make sure FULL_WIDTH_RESPONSIVE is `true` (default setting)
- Try resizing the window or making sure that adUnitWidget width is less than ~1300px 
