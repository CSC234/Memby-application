import 'package:flutter/material.dart';
// import 'package:memby/constants.dart';

class Textfield extends StatelessWidget {
  final String text;
  final String value;
  final Function onChange;
  final TextEditingController controller;
  final double fontsize;
  final Color colorCircle, textColor;
  final int min;
  final double width;
  final int max;

  final Icon icon;

  const Textfield(
      {Key key,
      this.onChange,
      this.width,
      this.value,
      this.text,
      this.controller,
      this.colorCircle,
      this.textColor,
      this.min,
      this.max,
      this.icon,
      this.fontsize})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      child: Column(children: [
        TextFormField(
          onChanged: onChange,
          // (text) {
          //   print("First text field: $text");
          // },
          // textAlignVertical: TextAlignVertical.top,
          // initialValue: value,
          minLines: min,
          maxLines: max,
          keyboardType: TextInputType.text,
          controller: controller,
          decoration: InputDecoration(
            labelText: text,
            border: OutlineInputBorder(
                borderSide: BorderSide(
              width: 5,
              color: Color(0xFFD5D8DE),
            )),
          ),
        ),
        SizedBox(
          height: 15,
        )
      ]),
    );
  }
}
