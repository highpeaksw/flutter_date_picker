# date_picker

## Cupertino styled date picker component which works on both ios and android.

---

> Use this date_picker component inside a bottom modal view.

# Example

For example on how to use the component [repo](https://github.com/rajeshzmoke/Flutter_cupertino_date_picker).

# Issues

For issues, file directly in the [date_picker repo](https://github.com/rajeshzmoke/Flutter_cupertino_date_picker/issues).

![Cupertino_date_picker](https://github.com/rajeshzmoke/Flutter_cupertino_date_picker/blob/master/Screenshot_1527169019.png)

# Usage

Let's demo the basic usage

```dart
import 'package:flutter/material.dart';
import 'package:date_picker/date_picker.dart';

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
  int _selectedMonthIndex = 0;
  int _selectedDateIndex = 0;
  int _selectedYearIndex = 0;
  bool _extendedButtons = false;
  VoidCallback _showBottomSheetCallback;

  @override
  void initState() {
    super.initState();
    _showBottomSheetCallback = _showBottomSheet;
  }

  setMonth(int index) {
    setState(() {
      _selectedMonthIndex = index;
    });
  }

  setDate(int index) {
    setState(() {
      _selectedDateIndex = index;
    });
  }

  setYear(int index) {
    setState(() {
      _selectedYearIndex = index;
    });
  }

  void _snackBar(String text) {
    _scaffoldKey.currentState.showSnackBar(SnackBar(content: Text(text)));
  }

  _showBottomSheet() {
    final FixedExtentScrollController scrollController =
        FixedExtentScrollController(initialItem: _selectedMonthIndex);

    setState(() {
      _showBottomSheetCallback = null;
    });
    _scaffoldKey.currentState
        .showBottomSheet<Null>((BuildContext context) {
          final ThemeData themeData = Theme.of(context);
          return DatePickerComponent(
              setMonth: setMonth,
              setDate: setDate,
              setYear: setYear,
              themeData: themeData,
              scrollController: scrollController);
        })
        .closed
        .whenComplete(() {
          if (mounted) {
            setState(() {
              _showBottomSheetCallback = _showBottomSheet;
            });
          }
        });
  }

  buildFloatingActionButton() {
    if (_extendedButtons == true)
      return Container(
        width: 78.0,
        height: 32.0,
        child: FloatingActionButton(
          isExtended: true,
          onPressed: () {
            setState(() {
              _extendedButtons = false;
            });
            Navigator.of(context).pop();

            _snackBar(monthNames[_selectedMonthIndex] +
                ' ${_selectedDateIndex + 1}' +
                ' ${1950 + _selectedYearIndex}');
          },
          child: Text('Submit'),
          backgroundColor: Color.fromRGBO(0, 0, 70, 1.0),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(5.0)),
        ),
      );
  }

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
            setState(() {
              _extendedButtons = true;
            });
          },
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: buildFloatingActionButton(),
    );
  }
}
```
