// 🐦 Flutter imports:
import 'package:flutter/material.dart';

// 📦 Package imports:
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:provider/provider.dart';

// 🌎 Project imports:
import '../../AdsWidget/Google/Native/GoogleNative.dart';
import '../../MainJson/MainJson.dart';

class NativeRN extends HookWidget {
  final BuildContext parentContext;

  const NativeRN({required this.parentContext, super.key});

  @override
  Widget build(BuildContext context) {
    final nativeWidget = useState<Widget>(const SizedBox(
      height: 0,
      width: 0,
    ));

    showAd() {
      MainJson mainJson = context.read<MainJson>();
      if ((mainJson.data![mainJson.version]['globalConfig']['globalAdFlag'] ?? false) ==
          false) {
        nativeWidget.value = const SizedBox(
          height: 0,
          width: 0,
        );
        return;
      }
      if ((mainJson.data![mainJson.version]['globalConfig']['globalNative'] ?? false) ==
          false) {
        nativeWidget.value = const SizedBox(
          height: 0,
          width: 0,
        );
        return;
      }
      if ((mainJson.data![mainJson.version]['screens']
                      [ModalRoute.of(parentContext)?.settings.name]
                  ['localAdFlag'] ??
              false) ==
          false) {
        nativeWidget.value = const SizedBox(
          height: 0,
          width: 0,
        );
        return;
      }
      switch (mainJson.data![mainJson.version]['screens']
          [ModalRoute.of(parentContext)?.settings.name]['native']) {
        case 0:
          nativeWidget.value = const GoogleNative();
          break;
        default:
          nativeWidget.value = const SizedBox(
            height: 0,
            width: 0,
          );
          break;
      }
    }

    useEffect(() {
      showAd();
      return () {};
    }, []);
    return nativeWidget.value;
  }
}
