import 'package:flutter/material.dart';

// ignore: must_be_immutable
class CalendarPicker extends StatefulWidget {
  CalendarPicker({Key key, this.title, this.color, this.onPickDate})
      : super(key: key);

  String title;
  final Color color;
  Function onPickDate;

  @override
  _CalendarPickerState createState() => _CalendarPickerState();
}

class _CalendarPickerState extends State<CalendarPicker> {
  DateTime selectedDate = DateTime.now();

  Future<void> _selectDate(BuildContext context) async {
    final DateTime picked = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime(1000, 8),
      lastDate: DateTime(2101),
    );
    if (picked != null || picked != selectedDate)
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
      height: height * (5 / 100),
      width: width * (37.5 / 100),
      child: ElevatedButton(
        onPressed: () {
          _selectDate(context);
          widget.title = selectedDate.toLocal().toString().split(' ')[0];
        },
        child: Text(widget.title),
        style: ElevatedButton.styleFrom(
          primary: widget.color,
          shape: new RoundedRectangleBorder(
            borderRadius: new BorderRadius.circular(10.0),
          ),
        ),
      ),
    );
  }
}