import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'models/variables.dart';
import 'dart:io' show Platform;
import 'models/methods.dart';

class SetupPicker extends StatefulWidget {
  SetupPicker({this.title});

  final String title;

  @override
  _SetupPickerState createState() => _SetupPickerState();
}

class _SetupPickerState extends State<SetupPicker> {
  CupertinoPicker iOSPicker(String title) {
    return CupertinoPicker(
      scrollController: new FixedExtentScrollController(
        initialItem: getData()[title],
      ),
      itemExtent: 32.0,
      //backgroundColor: Colors.white,
      onSelectedItemChanged: (int index) {
        addData(title, index);
        valueUpdated(title, index);
      },
      children: new List<Widget>.generate(
        60,
        (int index) {
          return new Center(
            child: new Text(
              '${index + 1}',
              style: Theme.of(context)
                  .textTheme
                  .bodyText1
                  .copyWith(fontSize: 20.0),
            ),
          );
        },
      ),
    );
  }

  DropdownButton androidDropdown(String title) {
    return DropdownButton(
      value: getData()[title],
      items: new List<DropdownMenuItem<dynamic>>.generate(
        60,
        (int index) {
          return new DropdownMenuItem(
            child: Text(
              '${index + 1}',
              style: Theme.of(context)
                  .textTheme
                  .bodyText1
                  .copyWith(fontSize: 20.0),
            ),
            value: index,
          );
        },
      ),
      onChanged: (index) {
        addData(widget.title, index);
        valueUpdated(title, index);
        setState(() {
          getData()[title] = index;
        });
      },
    );
  }

//  List<Widget> pickerFiller() {
//    List<Widget> numbers = [];
//
//    for (int i = 1; i < 61; i++) {
//      numbers.add(
//        Text('$i'),
//      );
//    }
//
//    return numbers;
//  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Text(
            widget.title,
            style: TextStyle(fontWeight: FontWeight.w600),
          ),
          Container(
            height: Platform.isIOS ? 80.0 : 50.0,
            child: Platform.isIOS
                ? iOSPicker(widget.title)
                : androidDropdown(widget.title),
          ),
        ],
      ),
    );
  }
}
