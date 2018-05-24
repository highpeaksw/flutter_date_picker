import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

const List<String> monthNames = const <String>[
  'January',
  'February',
  'March',
  'April',
  'May',
  'June',
  'July',
  'August',
  'September',
  'October',
  'November',
  'December',
];

class DatePickerComponent extends StatelessWidget {
  const DatePickerComponent({
    Key key,
    @required this.setMonth,
    @required this.setDate,
    @required this.setYear,
    @required this.themeData,
    @required this.scrollController,
  }) : super(key: key);
  final Function setMonth;
  final Function setDate;
  final Function setYear;
  final ThemeData themeData;
  final FixedExtentScrollController scrollController;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Expanded(
          flex: 1,
          child: Container(
              padding: EdgeInsets.all(8.0),
              height: 150.0,
              // width: 150.0,
              decoration: BoxDecoration(
                  border:
                      Border(top: BorderSide(color: themeData.disabledColor)),
                  color: Colors.white),
              child: CupertinoPicker(
                backgroundColor: Colors.white,
                scrollController: scrollController,
                itemExtent: 28.0,
                onSelectedItemChanged: (int index) {
                  setMonth(index);
                },
                children: List<Widget>.generate(monthNames.length, (int index) {
                  return Text(
                    monthNames[index],
                    style: TextStyle(color: Color(0xFF000046), fontSize: 20.0),
                    textAlign: TextAlign.start,
                  );
                }),
              )),
        ),
        Expanded(
          flex: 1,
          child: Container(
              padding: EdgeInsets.all(8.0),
              height: 150.0,
              // width: 150.0,
              decoration: BoxDecoration(
                  border:
                      Border(top: BorderSide(color: themeData.disabledColor)),
                  color: Colors.white),
              child: CupertinoPicker(
                backgroundColor: Colors.white,
                scrollController: scrollController,
                itemExtent: 28.0,
                onSelectedItemChanged: (int index) {
                  setDate(index);
                },
                children: List<Widget>.generate(31, (int index) {
                  return Text(
                    "${index + 1}",
                    style: TextStyle(color: Color(0xFF000046), fontSize: 20.0),
                    textAlign: TextAlign.start,
                  );
                }),
              )),
        ),
        Expanded(
          flex: 1,
          child: Container(
              padding: EdgeInsets.all(8.0),
              height: 150.0,
              // width: 150.0,
              decoration: BoxDecoration(
                  border:
                      Border(top: BorderSide(color: themeData.disabledColor)),
                  color: Colors.white),
              child: CupertinoPicker(
                backgroundColor: Colors.white,
                scrollController: scrollController,
                itemExtent: 28.0,
                onSelectedItemChanged: (int index) {
                  setYear(index);
                },
                children: List<Widget>.generate(69, (int index) {
                  return Text(
                    '${1950 + index}',
                    style: TextStyle(color: Color(0xFF000046), fontSize: 20.0),
                    textAlign: TextAlign.start,
                  );
                }),
              )),
        ),
      ],
    );
  }
}
