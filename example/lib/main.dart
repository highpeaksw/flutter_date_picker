import 'package:flutter/material.dart';
import 'package:flutter_date_picker/flutter_date_picker.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  VoidCallback _showBottomSheetCallback;
  bool showDatePicker = false;

  @override
  void initState() {
    super.initState();

    _showBottomSheetCallback = _showBottomSheet;
  }

  void _snackBar(String text) {
    _scaffoldKey.currentState.showSnackBar(SnackBar(content: Text(text)));
  }

  _showBottomSheet() {
    setState(() {
      // disable the button
      _showBottomSheetCallback = null;
    });
    _scaffoldKey.currentState
        .showBottomSheet<Null>(
          (BuildContext context) {
            return DateOfBirth(
              key: dobKey,
              setDate: _setDateOfBirth,
              customItemColor: Color(0xFF3949AB),
              customShape: StadiumBorder(
                side: BorderSide(
                  color: Color(0xFF3949AB),
                ),
              ),
              customGradient: LinearGradient(colors: [
                Color(0xFF000000),
                Color(0xFF3949AB),
              ]),
            );
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

  void _setDateOfBirth() {
    Navigator.of(context).pop();

    _snackBar(dobKey.currentState.dobStrMonth +
        ' ${dobKey.currentState.dobDate}' +
        ' ${dobKey.currentState.dobYear}');
  }

  // Widget dobComponent() {
  //   return DateOfBirth(
  //     key: dobKey,
  //     customItemColor: Color(0xFF000000),
  //     setDate: _setDateOfBirth,
  //   );
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: Text('Date Picker'),
      ),
      body: Container(
        padding: EdgeInsets.all(10.0),
        alignment: Alignment.topCenter,
        child: RaisedButton(
          color: Colors.blue,
          child: Text('Date Picker'),
          onPressed: () {
            _showBottomSheet();
          },
        ),
      ),
    );
  }
}
