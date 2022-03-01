import 'package:mesbaha/app/additions/public_folder.dart';

class AdHelper {
  // static const bool isTest = true;
  static String get bannerAd {
    if (PublicVariables.isTest) {
      return 'ca-app-pub-3940256099942544/6300978111';
    }
    return 'ca-app-pub-2400508280875448/9366550092';
  }
}
