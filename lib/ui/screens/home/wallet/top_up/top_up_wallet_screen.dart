import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:water/app_colors.dart';
import 'package:water/ui/shared_widgets/app_bar.dart';
import 'package:water/ui/shared_widgets/button/app_bar_back_button.dart';
import 'package:water/ui/shared_widgets/text/text.dart';

class TopUpWalletScreen extends StatefulWidget {
  TopUpWalletScreen({required this.url});

  final String url;

  @override
  _TopUpWalletScreenState createState() => _TopUpWalletScreenState();
}

class _TopUpWalletScreenState extends State<TopUpWalletScreen> {
  double _progress = 0.0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(),
      body: _buildBody(),
    );
  }

  PreferredSizeWidget _buildAppBar() {
    return WaterAppBar(
      title: WaterText(
        'screen.top_up_wallet'.tr(),
        fontSize: 24.0,
        textAlign: TextAlign.center,
        fontWeight: FontWeight.w800,
        color: AppColors.primaryText,
      ),
      leading: AppBarBackButton(
        onPressed: () {
          Navigator.of(context).pop(false);
        },
      ),
    );
  }

  Widget _buildBody() {
    return Stack(
      children: [
        InAppWebView(
          initialUrlRequest: URLRequest(
            url: Uri.parse(widget.url),
          ),
          initialOptions: InAppWebViewGroupOptions(
            crossPlatform: InAppWebViewOptions(
              useShouldOverrideUrlLoading: true,
              mediaPlaybackRequiresUserGesture: false,
            ),
            android: AndroidInAppWebViewOptions(
              useHybridComposition: true,
              useWideViewPort: false,
            ),
            ios: IOSInAppWebViewOptions(
              allowsInlineMediaPlayback: true,
            ),
          ),
          onProgressChanged: (_, progress) {
            setState(() => _progress = progress / 100);
          },
          onLoadStop: (controller, _) async {
            final html = await controller.getHtml();

            if (html == null) {
              return;
            }

            if (html.contains('{"isSuccessfulPayment":true}')) {
              Navigator.of(context).pop(true);
            } else if (html.contains('{"isSuccessfulPayment":false}')) {
              Navigator.of(context).pop(false);
            }
          },
        ),
        if (_progress < 1.0)
          SizedBox(
            height: 3.0,
            child: LinearProgressIndicator(
              value: _progress,
              backgroundColor: AppColors.primaryLight,
            ),
          ),
      ],
    );
  }
}
