import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:mesbaha/app/bannerAd/ad_helper.dart';

import '../additions/public_folder.dart';

class BoxAd extends StatefulWidget {
  const BoxAd({Key key}) : super(key: key);

  @override
  _BoxAdState createState() => _BoxAdState();
}

class _BoxAdState extends State<BoxAd> {
  AdSize size = AdSize.banner;
  BannerAd _bannerAd;

  void initBanner() {
    _bannerAd = BannerAd(
      adUnitId: AdHelper.bannerAd,
      size: size,
      request: const AdRequest(),
      listener: BannerAdListener(onAdLoaded: (ad) {
        setState(() {
          PublicVariables.isReady = true;
        });
      }, onAdFailedToLoad: (ad, error) {
        log('Banner ad Error');
      }),
    );
    _bannerAd.load();
  }

  @override
  void initState() {
    super.initState();
    initBanner();
  }

  @override
  Widget build(BuildContext context) {
    if (PublicVariables.isReady) {
      return Container(
        width: size.width.toDouble(),
        height: 35,
        child: AdWidget(ad: _bannerAd),
        alignment: Alignment.center,
      );
    }
    return const SizedBox();
  }
}
