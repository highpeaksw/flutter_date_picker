# flutter_date_picker

## Cupertino styled date picker component which works on both ios and android.

[![Pub](https://img.shields.io/pub/v/flutter_date_picker.svg)](https://pub.dartlang.org/packages/flutter_date_picker)

# Example

For example on how to use the component [repo](https://github.com/rajeshzmoke/flutter_date_picker/tree/master/example).

## Features

- CustomShape for Selected Item.
- CustomGradient for Submit Button.
- CustomItemColor for Selected Item.

![Cupertino_date_picker](https://github.com/rajeshzmoke/flutter_date_picker/blob/master/screenshot/date_picker_blue.gif)
![Screenshot](https://github.com/rajeshzmoke/flutter_date_picker/blob/master/screenshot/date_picker_green.gif)
![Screenshot](https://github.com/rajeshzmoke/flutter_date_picker/blob/master/screenshot/date_picker_pink.gif)

## Getting started

In the `pubspec.yaml` of your flutter project, add the following dependency:

```yaml
dependencies:
  ...
  flutter_date_picker: "^0.1.2"
```

In your library add the following import:

```dart
import 'package:flutter_date_picker/flutter_date_picker.dart';
```

For help getting started with Flutter, view the online [documentation](https://flutter.io/).

# Usage

Let's demo the basic usage with CustomItemColor, CustomShape and CustomGradient

```dart
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
      _showBottomSheetCallback = null;
    });
    _scaffoldKey.currentState
        .showBottomSheet<Null>(
          (BuildContext context) {
            return DateOfBirth(
              key: dobKey,
              setDate: _setDateOfBirth,
              customItemColor: Color(0xFF3949AB), //Change it as you wish
               customShape: BeveledRectangleBorder(
                 borderRadius: BorderRadius.only(
                   topLeft: Radius.circular(15.0),
                   topRight: Radius.circular(15.0),
                   bottomLeft: Radius.circular(15.0),
                   bottomRight: Radius.circular(15.0),
                 ),
               ), //Give your own shape
              customGradient: LinearGradient(colors: [
                Color(0xFF000000),
                Color(0xFF3949AB),
              ]),//your own colors for gradient
            );
          },
        )
        .closed
        .whenComplete(() {
          if (mounted) {
            setState(() {
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
