import 'dart:io';

class AdManager {
  static String get bannerAdUnitId {
    if (Platform.isAndroid) {
      return 'ca-app-pub-8554258589106363/2140693005';
    } else {
      return "Unsupported platform";
    }
  }

  static String get bannerAdUnitId2 {
    if (Platform.isAndroid) {
      return 'ca-app-pub-8554258589106363/9827611332';
    } else {
      return "Unsupported platform";
    }
  }

  static String get interstitialAdUnitId {
    if (Platform.isAndroid) {
      return 'ca-app-pub-8554258589106363/5888366325';
    } else {
      return "Unsupported platform";
    }
  }
}
