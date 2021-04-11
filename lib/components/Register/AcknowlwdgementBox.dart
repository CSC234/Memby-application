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
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          CheckBoxState(
            isCheck: widget.isCheck,
            currentCheckState: widget.currentCheckState,
          ),
          Container(
            alignment: Alignment.centerLeft,
            width: width * (74 / 100),
            child: ElevatedButton(
              child: Text(
                'I argee to the Memby Software and Services Agreement',
                style: TextStyle(
                  fontSize: 11.6,
                  color: Colors.grey[600],
                  // decoration: TextDecoration.underline,
                ),
              ),
              style: ElevatedButton.styleFrom(
                  padding: EdgeInsets.only(left: 5),
                  primary: Colors.transparent,
                  shadowColor: Colors.transparent),
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
