import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_date_picker/dob_cupertino_picker.dart';

const List<String> monthNames = const <String>[
  'Jan',
  'Feb',
  'Mar',
  'Apr',
  'May',
  'Jun',
  'Jul',
  'Aug',
  'Sep',
  'Oct',
  'Nov',
  'Dec',
];
final dobKey = GlobalKey<DateOfBirthState>();

class DateOfBirth extends StatefulWidget {
  const DateOfBirth({
    Key key,
    @required this.setDateOfBirth,
  }) : super(key: key);

  final Function setDateOfBirth;

  @override
  DateOfBirthState createState() => DateOfBirthState();
}

class DateOfBirthState extends State<DateOfBirth> {
  DateTime _date = DateTime.now();

  int _selectedMonth;
  int _selectedDate;
  int _selectedYear;
  String _dobMonth;

  int get dobMonth => _selectedMonth;
  int get dobDate => _selectedDate + 1;
  int get dobYear => (_date.year - 100) + _selectedYear;
  String get dobStrMonth => _dobMonth;

  @override
  void initState() {
    super.initState();
    _selectedMonth = _date.month - 1;
    _selectedDate = _date.day - 1;
    _selectedYear = _date.year;
    _dobMonth = monthNames[_date.month - 1];
    print('mnth $_dobMonth');
    print('date $_selectedDate');
    print('year $_selectedYear');
  }

  @override
  Widget build(BuildContext context) {
    final ThemeData themeData = Theme.of(context);
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Expanded(
          flex: 1,
          child: Container(
            padding: EdgeInsets.only(left: 18.0),
            height: 150.0,
            decoration: BoxDecoration(
                border: Border(
                    top: BorderSide(
                  color: themeData.disabledColor,
                )),
                color: Colors.white),
            child: Container(
              margin: EdgeInsets.symmetric(horizontal: 8.0),
              child: CustomCupertinoPicker(
                backgroundColor: Colors.white,
                scrollController:
                    FixedExtentScrollController(initialItem: _selectedMonth),
                itemExtent: 35.0,
                diameterRatio: 1.2,
                onSelectedItemChanged: (int index) {
                  setState(() {
                    _selectedMonth = index;
                    _dobMonth = monthNames[index];
                    // widget.setMonth(index);
                  });
                },
                children: List<Widget>.generate(monthNames.length, (int index) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 5.0),
                    child: Text(
                      monthNames[index],
                      style: TextStyle(
                        color: _selectedMonth == index
                            ? Colors.white
                            : Color(0xFFF991A0).withOpacity(0.6),
                        fontSize: 18.0,
                        fontWeight: FontWeight.w600,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  );
                }),
              ),
            ),
          ),
        ),
        Expanded(
          flex: 1,
          child: Container(
              padding: EdgeInsets.only(left: 18.0),
              height: 150.0,
              decoration: BoxDecoration(
                  border:
                      Border(top: BorderSide(color: themeData.disabledColor)),
                  color: Colors.white),
              child: Container(
                margin: EdgeInsets.symmetric(horizontal: 8.0),
                child: CustomCupertinoPicker(
                  backgroundColor: Colors.white,
                  scrollController:
                      FixedExtentScrollController(initialItem: _selectedDate),
                  itemExtent: 35.0,
                  diameterRatio: 1.2,
                  onSelectedItemChanged: (int index) {
                    setState(() {
                      _selectedDate = index;
                    });
                  },
                  children: List<Widget>.generate(31, (int index) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(vertical: 6.0),
                      child: Text(
                        "${index + 1}",
                        style: TextStyle(
                          color: _selectedDate == index
                              ? Colors.white
                              : Color(0xFFF991A0).withOpacity(0.6),
                          fontSize: 18.0,
                          fontWeight: FontWeight.w600,
                        ),
                        textAlign: TextAlign.start,
                      ),
                    );
                  }),
                ),
              )),
        ),
        Expanded(
          flex: 1,
          child: Container(
              padding: EdgeInsets.only(left: 18.0),
              height: 150.0,
              decoration: BoxDecoration(
                border: Border(top: BorderSide(color: themeData.disabledColor)),
                color: Colors.white,
              ),
              child: Container(
                margin: EdgeInsets.symmetric(horizontal: 10.0),
                child: CustomCupertinoPicker(
                  backgroundColor: Colors.white,
                  scrollController:
                      FixedExtentScrollController(initialItem: _selectedYear),
                  itemExtent: 35.0,
                  diameterRatio: 1.2,
                  onSelectedItemChanged: (int index) {
                    print('year index $index');
                    setState(() {
                      _selectedYear = index;
                    });
                  },
                  children: List<Widget>.generate(100, (int index) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(vertical: 6.0),
                      child: Text(
                        '${(_date.year - 100) + index}',
                        style: TextStyle(
                          color: _selectedYear == index
                              ? Colors.white
                              : Color(0xFFF991A0).withOpacity(0.6),
                          fontSize: 18.0,
                          fontFamily: 'Nunito',
                          fontWeight: FontWeight.w600,
                        ),
                        textAlign: TextAlign.start,
                      ),
                    );
                  }),
                ),
              )),
        ),
        Expanded(
          flex: 1,
          child: Container(
            height: 150.0,
            decoration: BoxDecoration(
                border: Border(top: BorderSide(color: themeData.disabledColor)),
                color: Colors.white),
            child: Center(
              child: ClipOval(
                child: Container(
                  width: 50.0,
                  height: 50.0,
                  decoration: BoxDecoration(
                      border: Border(
                          top: BorderSide(
                        color: themeData.disabledColor,
                      )),
                      gradient: LinearGradient(
                        begin: Alignment(-0.5, 1.0),
                        colors: [
                          Color(0xFF595DC2),
                          Color(0xFFF98495),
                        ],
                      )),
                  child: IconButton(
                    color: Colors.white,
                    icon: Icon(
                      Icons.send,
                      size: 20.0,
                    ),
                    onPressed: () {
                      widget.setDateOfBirth();
                    },
                  ),
                ),
              ),
            ),
          ),
        )
      ],
    );
  }
}
