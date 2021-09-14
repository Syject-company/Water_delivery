import 'package:flutter/material.dart';

export 'error_alert.dart';
export 'successful_payment_alert.dart';
export 'top_up_wallet_alert.dart';

Future<void> showWaterDialog(
  BuildContext context,
  Widget dialog,
) async {
  return showDialog(
    context: context,
    builder: (_) => dialog,
    barrierDismissible: false,
  );
}
