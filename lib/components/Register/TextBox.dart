import 'package:flutter/material.dart';
import 'package:email_validator/email_validator.dart';

class TextBox extends StatefulWidget {
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
      this.maxLine,
      this.emailValidator,
      this.length});

  final String text;
  final double width;
  final double height;
  final TextInputType keyboardType;
  final Color formColor;
  final Color textColor;
  final bool require;
  final Icon icon;
  final int minLine;
  final int maxLine;
  final bool emailValidator;
  int length;
  TextEditingController input = TextEditingController();

  @override
  _TextBoxState createState() => _TextBoxState();
}

class _TextBoxState extends State<TextBox> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Container(
        width: widget.width,
        height: widget.height,
        child: TextFormField(
          maxLength: widget.length,
          // ignore: deprecated_member_use
          controller: widget.input,
          keyboardType: widget.keyboardType,
          minLines: widget.minLine,
          maxLines: widget.maxLine,
          decoration: InputDecoration(
            labelText: widget.text,
            prefixIcon: widget.icon,
            contentPadding:
                EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
            fillColor: widget.formColor,
            filled: true,
            border: new OutlineInputBorder(
                borderSide: BorderSide.none,
                borderRadius: const BorderRadius.all(
                  const Radius.circular(10.0),
                )),
            focusedBorder: OutlineInputBorder(
              borderSide:
                  const BorderSide(color: Colors.blueAccent, width: 2.0),
              borderRadius: BorderRadius.circular(10.0),
            ),
          ),
          validator: (value) {
            if (widget.require == true) {
              if (value == null || value.isEmpty) {
                return 'This field is required';
              }
            }
            if (widget.emailValidator == true) {
              // ignore: unnecessary_statements
              if (!value.contains("@")) {
                return "Please enter a valid email address";
              }
            }
            return null;
          },
        ),
      ),
    );
  }
}
