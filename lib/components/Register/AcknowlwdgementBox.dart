import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart' as launcher;
import 'package:memby/components/Register/CheckBox.dart';

class AcknowledgementBox extends StatefulWidget {
  AcknowledgementBox({Key key, this.isCheck, this.currentCheckState})
      : super(key: key);
  bool isCheck = false;
  Function currentCheckState;

  @override
  _AcknowledgementBoxState createState() => _AcknowledgementBoxState();
}

class _AcknowledgementBoxState extends State<AcknowledgementBox> {
  // pushToScreen(BuildContext ctx) {
  //   Navigator.of(ctx).push(
  //     MaterialPageRoute(
  //       builder: (_) => PopupWindow(),
  //     ),
  //   );
  // }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;

    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CheckBoxState(
            isCheck: widget.isCheck,
            currentCheckState: widget.currentCheckState,
          ),
          Container(
            width: width * (78 / 100),
            child: ElevatedButton(
              child: Text(
                'I acknowledge and confirm that I have read, understand and accept the Terms and Conditions.',
                style: TextStyle(
                    fontSize: 11,
                    color: Colors.blue[600],
                    decoration: TextDecoration.underline),
              ),
              style: ElevatedButton.styleFrom(
                  primary: Colors.transparent, shadowColor: Colors.transparent),
              onPressed: () => launcher.launch(url),
            ),
          )
        ],
      ),
    );
  }
}

String url =
    "https://europa.eu/youreurope/citizens/consumers/internet-telecoms/data-protection-online-privacy/index_en.htm";
