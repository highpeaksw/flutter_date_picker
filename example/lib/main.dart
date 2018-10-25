import 'package:flutter/material.dart';
import 'package:flutter_date_picker/flutter_date_picker.dart';
import 'package:flutter_date_picker/flutter_time_picker.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  Function _showBottomSheetCallback;
  bool showDatePicker = false;

  @override
  void initState() {
    super.initState();

    _showBottomSheetCallback = _showBottomSheet;
  }

  void _snackBar(String text) {
    _scaffoldKey.currentState.showSnackBar(SnackBar(content: Text(text)));
  }

  _showBottomSheet(String picker) {
    setState(() {
      // disable the button
      _showBottomSheetCallback = null;
    });
    _scaffoldKey.currentState
        .showBottomSheet<Null>(
          (BuildContext context) {
            switch (picker) {
              case 'DatePicker':
                return DatePicker(
                  key: dobKey,
                  setDate: _setDate,
                  customShape: BeveledRectangleBorder(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(15.0),
                      topRight: Radius.circular(15.0),
                      bottomLeft: Radius.circular(15.0),
                      bottomRight: Radius.circular(15.0),
                    ),
                  ),
                  customItemColor: Color(0xFFba5905),
                  customGradient:
                      LinearGradient(begin: Alignment(-0.5, 1.0), colors: [
                    Color(0xFFba5905),
                    Color(0xFFefcaaa),
                    Color(0xFFba5905),
                  ]),
                );
              case 'TimePicker':
                return TimePicker(
                  key: tobKey,
                  setTime: _setTime,
                  customShape: StadiumBorder(
                      side: BorderSide(
                    color: Color(0xFFba5905),
                  )),
                  customItemColor: Color(0xFFba5905),
                  customGradient:
                      LinearGradient(begin: Alignment(-0.5, 1.0), colors: [
                    Color(0xFFba5905),
                    Color(0xFFefcaaa),
                    Color(0xFFba5905),
                  ]),
                );
            }
          },
        )
        .closed
        .whenComplete(() {
          if (mounted) {
            setState(() {
              // re-enable the button
              _showBottomSheetCallback = _showBottomSheet;
            });
          }
        });
  }

  void _setDate() {
    Navigator.of(context).pop();

    _snackBar(dobKey.currentState.dobStrMonth +
        ' ${dobKey.currentState.dobDate}' +
        ' ${dobKey.currentState.dobYear}');
  }

  void _setTime() {
    Navigator.of(context).pop();
    var hour = tobKey.currentState.hour;

    var min = tobKey.currentState.minute;

    var sec = tobKey.currentState.seconds;

    _snackBar("$hour:$min:$sec ${tobKey.currentState.sunOrMoon}");
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      bottom: false,
      child: Scaffold(
        key: _scaffoldKey,
        appBar: AppBar(
          backgroundColor: Color(0xFFba5905),
          title: Text('Date and Time Picker'),
        ),
        body: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            Container(
              padding: EdgeInsets.all(10.0),
              alignment: Alignment.topCenter,
              child: RaisedButton(
                textColor: Colors.white,
                color: Color(0xFFba5905),
                child: Text('Date Picker'),
                onPressed: () {
                  _showBottomSheet('DatePicker');
                },
              ),
            ),
            Container(
              padding: EdgeInsets.all(10.0),
              alignment: Alignment.topCenter,
              child: RaisedButton(
                textColor: Colors.white,
                color: Color(0xFFba5905),
                child: Text('Time Picker'),
                onPressed: () {
                  _showBottomSheet('TimePicker');
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
