import 'package:flutter/material.dart';
import 'package:flutter_date_picker/dob_cupertino_picker.dart';

const LinearGradient zGradient =
    const LinearGradient(begin: Alignment(-0.5, 1.0), colors: [
  Color(0xFFF98495),
  Color(0xFF595DC2),
]);

/// Color of the item background
const Color zItemColor = const Color(0xFFF98495);

/// Shape of the item
const ShapeBorder zShape = const BeveledRectangleBorder(
  borderRadius: BorderRadius.only(
    topLeft: Radius.circular(15.0),
    bottomRight: Radius.circular(15.0),
  ),
);

///Global key to access the getters

final tobKey = GlobalKey<TimeOfBirthState>();

class TimePicker extends StatefulWidget {
  const TimePicker({
    Key key,
    @required this.setTime,
    this.customItemColor = zItemColor,
    this.customShape = zShape,
    this.customGradient = zGradient,
  }) : super(key: key);

  /// Function to get the data

  final Function setTime;

  /// Custom LinerGradient for the submit button
  final LinearGradient customGradient;

  /// BackgroundColor for the selected item (Month/date/year)
  final Color customItemColor;

  /// Custom shape for the selected item
  final ShapeBorder customShape;

  @override
  TimeOfBirthState createState() => TimeOfBirthState();
}

class TimeOfBirthState extends State<TimePicker> {
  DateTime date = DateTime.now();

  bool ampm = false;

  int _selectedHour;
  int _selectedMinute;
  int _selectedSec;
  int _selectedTime;
  String _selectedAMPM;

  String get hour =>
      _selectedHour < 10 ? '0$_selectedHour' : _selectedHour.toString();
  String get minute =>
      _selectedMinute < 10 ? '0$_selectedMinute' : _selectedMinute.toString();
  String get seconds =>
      _selectedSec < 10 ? '0$_selectedSec' : _selectedSec.toString();
  String get sunOrMoon => _selectedAMPM;
  @override
  void initState() {
    super.initState();

    formatAMPM(date);
  }

  formatAMPM(date) {
    int hours = date.hour;
    int minutes = date.minute;
    int seconds = date.second;
    hours = hours % 12;
    hours = hours != null ? hours : 12;
    _selectedHour = hours;
    _selectedMinute = minutes;
    _selectedSec = seconds;
    _selectedTime = date.hour < 12 ? 0 : 1;
    _selectedAMPM = date.hour < 12 ? 'AM' : 'PM';
    print('selected hour $_selectedHour');
  }

  _setSelectedHour(int index) {
    setState(() {
      _selectedHour = index;
    });
  }

  _setSelectedMinute(int index) {
    setState(() {
      _selectedMinute = index;
    });
  }

  _setSelectedSeconds(int index) {
    setState(() {
      _selectedSec = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 150.0,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          Container(
            padding: EdgeInsets.only(left: 16.0),
            height: 150.0,
            decoration: BoxDecoration(
              border: Border(
                  top: BorderSide(
                color: Colors.grey,
              )),
              color: Colors.white,
            ),
          ),

          PickerDesign(
            listLength: 13,
            scrollController:
                FixedExtentScrollController(initialItem: _selectedHour),
            selectedTime: _selectedHour,
            setSelectedTime: _setSelectedHour,
            customShape: widget.customShape,
            customItemColor: widget.customItemColor,
          ),
          Container(
            height: 150.0,
            decoration: BoxDecoration(
                border: Border(top: BorderSide(color: Colors.grey)),
                color: Colors.white),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                SizedBox(
                  width: 3.0,
                  height: 3.0,
                  child: Container(
                    color: widget.customItemColor,
                  ),
                ),
                SizedBox(
                  height: 10.0,
                ),
                SizedBox(
                  width: 3.0,
                  height: 3.0,
                  child: Container(
                    color: widget.customItemColor,
                  ),
                )
              ],
            ),
          ),
          PickerDesign(
            listLength: 60,
            scrollController:
                FixedExtentScrollController(initialItem: _selectedMinute),
            selectedTime: _selectedMinute,
            setSelectedTime: _setSelectedMinute,
            customShape: widget.customShape,
            customItemColor: widget.customItemColor,
          ),
          Container(
            height: 150.0,
            decoration: BoxDecoration(
                border: Border(top: BorderSide(color: Colors.grey)),
                color: Colors.white),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                SizedBox(
                  width: 3.0,
                  height: 3.0,
                  child: Container(
                    color: widget.customItemColor,
                  ),
                ),
                SizedBox(
                  height: 10.0,
                ),
                SizedBox(
                  width: 3.0,
                  height: 3.0,
                  child: Container(
                    color: widget.customItemColor,
                  ),
                )
              ],
            ),
          ),
          PickerDesign(
            listLength: 60,
            scrollController:
                FixedExtentScrollController(initialItem: _selectedSec),
            selectedTime: _selectedSec,
            setSelectedTime: _setSelectedSeconds,
            customShape: widget.customShape,
            customItemColor: widget.customItemColor,
          ),
          Expanded(
            flex: 1,
            child: Container(
              height: 150.0,
              decoration: BoxDecoration(
                border: Border(top: BorderSide(color: Colors.grey)),
                color: Colors.white,
              ),
              child: Container(
                margin: EdgeInsets.symmetric(horizontal: 8.0),
                child: CustomCupertinoPicker(
                  customColor: widget.customItemColor,
                  customShape: widget.customShape,
                  backgroundColor: Colors.white,
                  scrollController:
                      FixedExtentScrollController(initialItem: _selectedTime),
                  itemExtent: 35.0,
                  diameterRatio: 1.2,
                  onSelectedItemChanged: (int index) {
                    setState(() {
                      _selectedTime = index;
                      if (index == 0) {
                        _selectedAMPM = 'AM';
                      } else {
                        _selectedAMPM = "PM";
                      }
                    });
                  },
                  children: List<Widget>.generate(2, (int index) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(vertical: 5.0),
                      child: Text(
                        index == 0 ? 'AM' : 'PM',
                        style: TextStyle(
                          color: _selectedTime == index
                              ? Colors.white
                              : widget.customItemColor.withOpacity(0.6),
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

          /// Submit button
          Expanded(
            flex: 1,
            child: Container(
              height: 150.0,
              decoration: BoxDecoration(
                  border: Border(top: BorderSide(color: Colors.grey)),
                  color: Colors.white),
              child: Center(
                child: ClipOval(
                  child: Container(
                    width: 50.0,
                    height: 50.0,
                    decoration: BoxDecoration(
                      border: Border(top: BorderSide(color: Colors.grey)),
                      gradient: widget.customGradient ?? zGradient,
                    ),
                    child: IconButton(
                      color: Colors.white,
                      icon: Icon(
                        Icons.send,
                        size: 20.0,
                      ),
                      onPressed: () {
                        widget.setTime();
                      },
                    ),
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}

class PickerDesign extends StatelessWidget {
  const PickerDesign({
    Key key,
    @required this.scrollController,
    @required int selectedTime,
    @required this.setSelectedTime,
    @required this.listLength,
    this.customItemColor,
    this.customShape,
  })  : _selectedTime = selectedTime,
        super(key: key);

  final FixedExtentScrollController scrollController;
  final int _selectedTime;
  final Function setSelectedTime;
  final int listLength;

  /// BackgroundColor for the selected item (Month/date/year)
  final Color customItemColor;

  /// Custom shape for the selected item
  final ShapeBorder customShape;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: 1,
      child: Container(
        height: 150.0,
        decoration: BoxDecoration(
            border: Border(top: BorderSide(color: Colors.grey)),
            color: Colors.white),
        child: Container(
          margin: EdgeInsets.symmetric(horizontal: 8.0),
          child: CustomCupertinoPicker(
            customShape: customShape,
            customColor: customItemColor,
            backgroundColor: Colors.white,
            scrollController: scrollController,
            itemExtent: 35.0,
            diameterRatio: 1.2,
            onSelectedItemChanged: (int index) {
              setSelectedTime(index);
            },
            children: List<Widget>.generate(listLength, (int index) {
              return Padding(
                padding: const EdgeInsets.symmetric(vertical: 5.0),
                child: Text(
                  index < 10 ? '0$index' : '$index',
                  style: TextStyle(
                    color: _selectedTime == index
                        ? Colors.white
                        : customItemColor.withOpacity(0.6),
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
    );
  }
}
