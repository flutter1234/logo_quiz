// 🐦 Flutter imports:
import 'package:flutter/material.dart';

// 📦 Package imports:
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:provider/provider.dart';

// 🌎 Project imports:
import '../../../MainJson/MainJson.dart';

class GoogleBanner extends HookWidget {
  const GoogleBanner({super.key});

  @override
  Widget build(BuildContext context) {
    final bannerAd = useState<BannerAd?>(null);
    final isLoading = useState<bool>(true);
    final isFailed = useState<bool>(true);
    final bannerWidget = useState<AdWidget?>(null);

    MainJson mainJson = context.read<MainJson>();

    loadAd() {
      bannerAd.value = BannerAd(
        adUnitId: '${mainJson.data!['adIds']['google']['banner']}',
        request: const AdRequest(),
        size: AdSize.banner,
        listener: BannerAdListener(
          // Called when an ad is successfully received.
          onAdLoaded: (ad) {
            debugPrint('$ad loaded.');

            isLoading.value = false;
            isFailed.value = false;
          },
          onAdFailedToLoad: (ad, error) {
            isLoading.value = false;
            isFailed.value = true;
            debugPrint('BannerAd failed to load: $error');

            ad.dispose();
          },

          onAdOpened: (Ad ad) {},

          onAdClosed: (Ad ad) {},

          onAdImpression: (Ad ad) {},
        ),
      );

      bannerAd.value!.load();
      bannerWidget.value = AdWidget(ad: bannerAd.value!);
    }

    useEffect(() {
      loadAd();
      return () {};
    }, []);
    return isFailed.value
        ? const SizedBox(
            height: 0,
            width: 0,
          )
        : isLoading.value
            ? const SizedBox(
                height: 0,
                width: 0,
              )
            : Container(
                alignment: Alignment.center,
                width: bannerAd.value!.size.width.toDouble(),
                height: bannerAd.value!.size.height.toDouble(),
                child: bannerWidget.value,
              );
  }
}
