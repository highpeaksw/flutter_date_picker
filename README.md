# flutter_date_picker

## Cupertino styled date and time picker component which works on both ios and android.

[![Pub](https://img.shields.io/pub/v/flutter_date_picker.svg)](https://pub.dartlang.org/packages/flutter_date_picker)

# Example

For example on how to use the component [repo](https://github.com/rajeshzmoke/flutter_date_picker/tree/master/example).

## Features

- Seperate Date picker Component.
- Seperate Time picker Component.
- CustomShape for Selected Item.
- CustomGradient for Submit Button.
- CustomItemColor for Selected Item.

<div style="text-align: center">
  <table>
    <tr>
      <td style="text-align: center">
        <img src="https://github.com/rajeshzmoke/flutter_date_picker/blob/master/screenshot/date_time_blue.gif" width="200" />
      </td>
      <td style="text-align: center">
        <img src="https://github.com/rajeshzmoke/flutter_date_picker/blob/master/screenshot/date_time_green.gif" width="200" />
      </td>
      <td style="text-align: center">
        <img src="https://github.com/rajeshzmoke/flutter_date_picker/blob/master/screenshot/date_time_brown.gif" width="200" />
      </td>
    </tr>
  </table>
 </div>

## Getting started

In the `pubspec.yaml` of your flutter project, add the following dependency:

```yaml
dependencies:
  ...
  flutter_date_picker: "^0.1.8"
```

In your library add the following import:

```dart
import 'package:flutter_date_picker/flutter_date_picker.dart';
import 'package:flutter_date_picker/flutter_time_picker.dart';
```

For help getting started with Flutter, view the online [documentation](https://flutter.io/).

# Usage

Let's demo the basic usage with CustomItemColor, CustomShape and CustomGradient

```dart
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
                  customShape: StadiumBorder(
                      side: BorderSide(
                    color: Color(0xFFF991A0),
                  )),
                );
              case 'TimePicker':
                return TimePicker(
                  key: tobKey,
                  setTime: _setTime,
                  customShape: BeveledRectangleBorder(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(15.0),
                      topRight: Radius.circular(15.0),
                      bottomLeft: Radius.circular(15.0),
                      bottomRight: Radius.circular(15.0),
                    ),
                  ),
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
          backgroundColor: Color(0xFFF98495),
          title: Text('Date Picker'),
        ),
        body: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            Container(
              padding: EdgeInsets.all(10.0),
              alignment: Alignment.topCenter,
              child: RaisedButton(
                color: Color(0xFFF98495),
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
                color: Color(0xFFF98495),
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
```

## Changelog

Please see the [Changelog](https://github.com/rajeshzmoke/flutter_date_picker/blob/master/CHANGELOG.md) page to know what's recently changed.

## License

```
Copyright 2018 Rajesh Kumar

Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at

   http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License.
```
