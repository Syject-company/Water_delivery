import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:water/ui/constants/colors.dart';
import 'package:water/ui/icons/app_icons.dart';
import 'package:water/ui/screens/home/home_navigator.dart';
import 'package:water/ui/shared_widgets/app_bar.dart';
import 'package:water/ui/shared_widgets/button/app_bar_icon_button.dart';
import 'package:water/ui/shared_widgets/text/text.dart';

class WalletTopUpScreen extends StatefulWidget {
  WalletTopUpScreen({required this.url});

  final String url;

  @override
  _WalletTopUpScreenState createState() => _WalletTopUpScreenState();
}

class _WalletTopUpScreenState extends State<WalletTopUpScreen> {
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
        'Top Up Wallet',
        fontSize: 24.0,
        lineHeight: 2.0,
        textAlign: TextAlign.center,
      ),
      actions: [
        AppBarIconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: AppIcons.close,
        )
      ],
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
          onProgressChanged: (controller, progress) {
            setState(() => _progress = progress / 100);
          },
          onLoadStop: (controller, url) {
            if (url.toString().contains('/Account/return')) {
              homeNavigator.pop();
            }
          },
        ),
        if (_progress < 1.0)
          SizedBox(
            height: 3.0,
            child: LinearProgressIndicator(
              value: _progress,
              backgroundColor: AppColors.secondary,
            ),
          ),
      ],
    );
  }
}
