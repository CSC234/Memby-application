import 'package:flutter/material.dart';

class RoundedButton extends StatelessWidget {
  final Function onPress;
  final String title;
  final Color color;

  RoundedButton({this.color, this.onPress, this.title});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 45,
      child: ElevatedButton(
        onPressed: onPress,
        child: Text(
          title,
          style: TextStyle(fontSize: 16),
        ),
        style: ButtonStyle(
          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8.0),
            ),
          ),
          backgroundColor: MaterialStateProperty.resolveWith<Color>(
            (Set<MaterialState> states) {
              if (states.contains(MaterialState.pressed)) return color;
              return color; // Use the component's default.
            },
          ),
        ),
      ),
    );
  }
}
