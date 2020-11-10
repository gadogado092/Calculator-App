import 'package:calculator_app/widgets/item_button.dart';
import 'package:calculator_app/widgets/item_text_field.dart';
import 'package:flushbar/flushbar.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Calculator',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      home: MyHomePage(title: 'Calculator'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _length = 3;
  List<bool> _listValueCheckBox = new List();
  List<TextEditingController> _controllersValue = new List();
  double _result = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              ListView.builder(
                  shrinkWrap: true,
                  itemCount: _length,
                  itemBuilder: (BuildContext ctxt, int index) {
                    _controllersValue.add(new TextEditingController());
                    _listValueCheckBox.add(false);
                    return ItemTextField(
                      controller: _controllersValue[index],
                      onChanged: (bool value) {
                        setState(() {
                          _listValueCheckBox[index] = value;
                        });
                      },
                      value: _listValueCheckBox[index],
                    );
                  }),
              SizedBox(
                height: 16,
              ),
              Padding(
                padding: const EdgeInsets.only(right: 64),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    ItemButton(
                      text: "+",
                      onTap: () {
                        setState(() {
                          _result = _addition(context);
                        });
                      },
                    ),
                    ItemButton(
                      text: "-",
                      onTap: () {
                        setState(() {
                          _result = _subtraction(context);
                        });
                      },
                    ),
                    ItemButton(
                      text: "X",
                      onTap: () {
                        setState(() {
                          _result = _multiple(context);
                        });
                      },
                    ),
                    ItemButton(
                      text: "/",
                      onTap: () {
                        setState(() {
                          _result = _divide(context);
                        });
                      },
                    )
                  ],
                ),
              ),
              SizedBox(
                height: 16,
              ),
              Divider(
                color: Colors.black,
                endIndent: 64,
                indent: 16,
                thickness: 4,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 16.0, right: 64,),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Hasil:",
                      style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                    ),
                    Text(
                      "${_result.toString()}",
                      style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  double _addition(BuildContext context) {
    var result = 0.0;
    if (_checkBoxList()) {
      for (var i = 0; i < _length; i++) {
        if (_listValueCheckBox[i]) {
          result = result + double.parse(_controllersValue[i].text.toString());
        }
      }
    } else {
      _showError(context);
    }
    return result;
  }

  double _subtraction(BuildContext context) {
    var result = 0.0;
    if (_checkBoxList()) {
      for (var i = 0; i < _length; i++) {
        if (_listValueCheckBox[i]) {
          if (result == 0.0) {
            result = double.parse(_controllersValue[i].text.toString());
          } else {
            result =
                result - double.parse(_controllersValue[i].text.toString());
          }
        }
      }
    } else {
      _showError(context);
    }
    return result;
  }

  double _multiple(BuildContext context) {
    var result = 0.0;
    if (_checkBoxList()) {
      for (var i = 0; i < _length; i++) {
        if (_listValueCheckBox[i]) {
          if (result == 0.0) {
            result = double.parse(_controllersValue[i].text.toString());
          } else {
            result =
                result * double.parse(_controllersValue[i].text.toString());
          }
        }
      }
    } else {
      _showError(context);
    }
    return result;
  }

  double _divide(BuildContext context) {
    var result = 0.0;
    if (_checkBoxList()) {
      for (var i = 0; i < _length; i++) {
        if (_listValueCheckBox[i]) {
          if (result == 0.0) {
            result = double.parse(_controllersValue[i].text.toString());
          } else {
            result =
                result / double.parse(_controllersValue[i].text.toString());
          }
        }
      }
    } else {
      _showError(context);
    }
    return result;
  }

  bool _checkBoxList() {
    var sumCheckBox = 0;
    for (var i = 0; i < _length; i++) {
      if (_listValueCheckBox[i]) {
        sumCheckBox = sumCheckBox + 1;
        if (sumCheckBox == 2) {
          return true;
        }
      }
    }
    return false;
  }

  _showError(BuildContext context) {
    Flushbar(
      message: "Checklist Harus Lebih Dari 1",
      duration: Duration(seconds: 3),
    )..show(context);
  }
}
