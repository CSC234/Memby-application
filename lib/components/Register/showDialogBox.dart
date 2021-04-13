import 'package:flutter/material.dart';

class ShowDialogBox extends StatefulWidget {
  ShowDialogBox(
      {Key key,
      this.title,
      this.content,
      this.confirmButtonYes,
      this.confirmButtonNo})
      : super(key: key);
  final String title;
  final String content;
  final String confirmButtonYes;
  final String confirmButtonNo;

  @override
  _ShowDialogBoxState createState() => _ShowDialogBoxState();
}

class _ShowDialogBoxState extends State<ShowDialogBox> {
  _showMaterialDialog() {
    showDialog(
        context: context,
        builder: (_) => new AlertDialog(
              title: new Text(widget.title),
              content: new Text(widget.content),
              actions: <Widget>[
                // ignore: deprecated_member_use
                FlatButton(
                  child: Text(widget.confirmButtonYes),
                  onPressed: () {
                    return Navigator.of(context).pop();
                  },
                ),
                TextButton(
                  child: Text(widget.confirmButtonNo),
                  onPressed: () {
                    return true;
                  },
                )
              ],
            ));
  }

  @override
  Widget build(BuildContext context) {
    return (_showMaterialDialog());
  }
}
