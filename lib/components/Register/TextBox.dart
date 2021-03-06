import 'package:flutter/material.dart';
import 'package:memby/constants.dart';
import 'package:memby/firebase.dart';
import 'package:memby/screens/registerScreen.dart';
import 'package:provider/provider.dart';

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
      this.length,
      this.checkPhone});

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
  final bool checkPhone;
  int length;
  TextEditingController input = TextEditingController();

  @override
  _TextBoxState createState() => _TextBoxState();
}

class _TextBoxState extends State<TextBox> {
  bool isDuplicate = true;
  FocusNode myFocusNode = new FocusNode();

  @override
  void initState() {
    super.initState();

    myFocusNode = FocusNode();
  }

  @override
  void dispose() {
    // Clean up the focus node when the Form is disposed.
    myFocusNode.dispose();

    super.dispose();
  }

  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Container(
        width: widget.width,
        height: widget.height,
        child: TextFormField(
          textInputAction: TextInputAction.go,
          focusNode: myFocusNode,
          maxLength: widget.length,
          // ignore: deprecated_member_use
          controller: widget.input,
          keyboardType: widget.keyboardType,
          minLines: widget.minLine,
          maxLines: widget.maxLine,
          decoration: InputDecoration(
            labelText: widget.text,
            hintStyle: TextStyle(color: Colors.black),
            prefixIcon: widget.icon,
            labelStyle: TextStyle(color: Colors.grey),
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
              borderSide: const BorderSide(
                color: Colors.grey,
                width: 2.0,
              ),
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
              if (!RegExp(
                      r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+.[a-zA-Z]+")
                  .hasMatch(value)) {
                return "Please enter a valid email address";
              }
            }
            if (widget.checkPhone == true) {
              if (value.length != 10) {
                return "Please enter a valid phone number";
              }
              if (isDuplicate == true) {
                return "This phone number has been used";
              }
              if (!RegExp(
                      r'^(\+\d{1,2}\s)?\(?\d{3}\)?[\s.-]?\d{3}[\s.-]?\d{4}$')
                  .hasMatch(value)) {
                return "Please enter a valid phone number";
              }
            }
            return null;
          },
          onChanged: (value) async {
            if (widget.checkPhone == true && value.length == 10) {
              // If it return false => The phoneNo is not duplicate
              //              true  => The phoneNo is duplicated
              bool status = await context
                  .read<FlutterFireAuthService>()
                  .isCustomerPhoneDuplicate(value);
              setState(() {
                isDuplicate = status;
              });
            }
          },
          onTap: () => {
            setState(() {
              FocusScope.of(context).requestFocus(myFocusNode);
            })
          },
          onEditingComplete: () => {
            setState(() {
              myFocusNode.nextFocus();
            })
          },
        ),
      ),
    );
  }
}
