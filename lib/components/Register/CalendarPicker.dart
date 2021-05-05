import 'package:flutter/material.dart';

// ignore: must_be_immutable
class CalendarPicker extends StatefulWidget {
  CalendarPicker(
      {Key key, this.title, this.color, this.onPickDate, this.fontColor})
      : super(key: key);

  String title;
  final Color color;
  final Color fontColor;
  Function onPickDate;

  @override
  _CalendarPickerState createState() => _CalendarPickerState();
}

class _CalendarPickerState extends State<CalendarPicker> {
  static DateTime selectedDate = DateTime.now();

  Future<void> selectDate(BuildContext context) async {
    final DateTime picked = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime(1000, 8),
      lastDate: DateTime.now(),
    );
    if (picked != null && picked != selectedDate)
      setState(() {
        selectedDate = picked;
        widget.onPickDate(selectedDate);
      });
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Container(
      height: height * (4.8 / 100),
      width: width * (37.5 / 100),
      child: ElevatedButton(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Text(
              widget.title,
              style: TextStyle(
                  color: Colors.grey,
                  fontWeight: FontWeight.w400,
                  fontSize: 16),
            ),
            Icon(
              Icons.calendar_today_outlined,
              color: Colors.grey,
            ),
          ],
        ),
        onPressed: () {
          selectDate(context);
        },
        style: ElevatedButton.styleFrom(
            primary: widget.color,
            shape: new RoundedRectangleBorder(
              borderRadius: new BorderRadius.circular(10.0),
            ),
            shadowColor: Colors.transparent),
      ),
    );
  }
}
