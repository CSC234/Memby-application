import 'package:flutter/material.dart';

class TextBox extends StatelessWidget {
  TextBox(
      {this.text,
      this.height,
      this.width,
      this.keyboardType,
      this.formColor,
      this.textColor,
      this.input,
      this.require,
      this.icon,
      this.minLine,
      this.maxLine});

  final String text;
  final double width;
  final double height;
  final TextInputType keyboardType;
  final Color formColor;
  final Color textColor;
  final String input;
  final bool require;
  final Icon icon;
  final int minLine;
  final int maxLine;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(5.0),
      child: Container(
        width: width,
        height: height,
        child: TextFormField(
          keyboardType: keyboardType,
          minLines: minLine,
          maxLines: maxLine,
          decoration: InputDecoration(
            prefixIcon: icon,
            contentPadding:
                EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
            hintText: text,
            fillColor: formColor,
            filled: true,
            border: new OutlineInputBorder(
                
                borderRadius: const BorderRadius.all(
              const Radius.circular(25.0),
            )),
            focusedBorder: OutlineInputBorder(
              borderSide:
                  const BorderSide(color: Colors.blueAccent, width: 2.0),
              borderRadius: BorderRadius.circular(25.0),
            ),
          ),
        ),
      ),
    );
  }
}
