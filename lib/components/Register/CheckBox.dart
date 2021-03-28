import 'package:flutter/material.dart';

// ignore: must_be_immutable
class CheckBoxState extends StatefulWidget {
  CheckBoxState({Key key, this.isCheck, this.currentCheckState})
      : super(key: key);
  bool isCheck = false;
  Function currentCheckState;

  @override
  _CheckBoxStateState createState() => _CheckBoxStateState();
}

class _CheckBoxStateState extends State<CheckBoxState> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Checkbox(
        materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
        value: widget.isCheck,
        onChanged: (bool value) {
          setState(
            () {
              widget.isCheck = value;
              widget.currentCheckState(value);
            },
          );
        },
      ),
    );
  }
}
