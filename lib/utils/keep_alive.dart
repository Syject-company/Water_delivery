import 'package:flutter/material.dart';

class KeepAliveChild extends StatefulWidget {
  const KeepAliveChild({
    Key? key,
    required this.child,
  }) : super(key: key);

  final Widget child;

  @override
  _KeepAliveChildState createState() => _KeepAliveChildState();
}

class _KeepAliveChildState extends State<KeepAliveChild>
    with AutomaticKeepAliveClientMixin<KeepAliveChild> {
  @override
  Widget build(BuildContext context) {
    super.build(context);
    return widget.child;
  }

  @override
  bool get wantKeepAlive => true;
}
