import 'package:flutter/material.dart';
import 'package:overlay_support/overlay_support.dart';

class OverlayNotification extends StatefulWidget {
  OverlayNotification({Key key, this.themeColor, this.subtitle, this.title})
      : super(key: key);
  final Color themeColor;
  final String subtitle;
  final String title;

  @override
  _OverlayNotificationState createState() => _OverlayNotificationState();
}

class _OverlayNotificationState extends State<OverlayNotification> {
  @override
  Widget build(BuildContext context) {
    return (Card(
      margin: const EdgeInsets.symmetric(horizontal: 4),
      child: SafeArea(
        child: ListTile(
          leading: SizedBox.fromSize(
              size: const Size(40, 40),
              child: ClipOval(
                  child: Container(
                color: widget.themeColor,
              ))),
          title: Text(widget.title),
          subtitle: Text(widget.subtitle),
          trailing: IconButton(
            icon: Icon(Icons.close),
            onPressed: () {
              OverlaySupportEntry.of(context).dismiss();
            },
          ),
        ),
      ),
    ));
  }
}
