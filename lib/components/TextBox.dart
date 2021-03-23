import 'package:flutter/material.dart';
import 'package:validators/validators.dart';
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
      this.emailValidator});

  final String text;
  final double width;
  final double height;
  final TextInputType keyboardType;
  final Color formColor;
  final Color textColor;
  final TextEditingController input;
  final bool require;
  final Icon icon;
  final int minLine;
  final int maxLine;
  final bool emailValidator;
  final _formKey = GlobalKey<FormState>();

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
            if (value == null || value.isEmpty) {
              return 'Please enter some text';
            }
            if (widget.emailValidator == true) {
              EmailValidator.validate(value) ? null : "Invalid email";
            }
            return null;
          },
        ),
      ),
    );
  }
}
