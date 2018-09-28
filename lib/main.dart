import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:async';

void main() {
  runApp(new MaterialApp(
    title: 'Reverse Names',
    theme: ThemeData(
      primaryColor: Colors.deepOrange,
      accentColor: Colors.deepOrange
    ),
    home: Home(),
  ));
}

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {

  String _textOutput = "Text Output Here";
  final TextEditingController _textController = new TextEditingController();

  @override
  Widget build(BuildContext context) {                          
    return new Scaffold(
      body: Container(
        decoration: new BoxDecoration(
          color: Colors.deepOrange[400],
        ),
        child: new Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            new AppBar(
              title: new Text('Name Reverser'),
              backgroundColor: Colors.deepOrange[600],
              actions: <Widget>[
                new IconButton(
                  icon: new Icon(Icons.content_cut),
                  tooltip: 'Cut the text',
                  iconSize: 33.0,
                  color: Colors.red[900],
                  onPressed: () {
                    if(_textOutput != "Text Output Here") {
                      Clipboard.setData(new ClipboardData(text: _textOutput));
                      _dialogShow("Copied!", "Your text was copied successfully", "Thank you", fontSizeTitle: 25.0, fontSizeContent: 20.0);
                    }else {
                      _dialogShow("Nothing to copy", "Write something!", "Ops", fontSizeTitle: 25.0, fontSizeContent: 20.0);
                    }
                  },
                ),
              ],
            ),
            new Padding(
              padding: EdgeInsets.symmetric(vertical: 80.0),
              child:  new Text('Enter your words', 
                style: new TextStyle(fontWeight: FontWeight.bold, fontSize: 25.0, color: Colors.white,), 
                textAlign: TextAlign.center,
                ),
            ),
            new Row(
              children: <Widget>[
                new Flexible(
                  child: new Stack(
                    alignment: const Alignment(1.2, 0.5),
                    children: <Widget>[
                      new TextField(
                        autofocus: true,
                        maxLines: 1,
                        autocorrect: true,
                        controller: _textController,
                        onChanged: (text) {
                          printText(text);
                        },
                        textAlign: TextAlign.center,
                        style: new TextStyle(fontWeight: FontWeight.normal, fontSize: 25.5, color: Colors.white),
                        decoration: new InputDecoration(
                          border: InputBorder.none,
                          fillColor: Colors.deepOrange[600],
                          filled: true,
                          hintText: 'here',
                        ),
                      ),
                      new FlatButton(
                        onPressed: () {
                          _textController.clear();
                          setState(() { _textOutput = "Text Output Here"; });
                        },
                        child: new Icon(Icons.clear, color: Colors.red[900],),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            new Padding(
              padding: EdgeInsets.symmetric(vertical: 62.0),
              child:  new Text(
                _textOutput, 
                softWrap: true,
                style: new TextStyle(fontWeight: FontWeight.bold, fontSize: 25.0, color: Colors.white,), 
                textAlign: TextAlign.center,
                ),
            ),
          ],
        ),
      ),
    );
  }

  void printText(String text) {
    setState(() {
      if(text.length == 0) {
        _textOutput = "Text output here";
      }else if(text.length == 1) {
        _textOutput = "Your text is too small";
      }else {
        _textOutput = text.split('').reversed.join('');
      }
    });
  }

  Future<Null> _dialogShow(
      String title, 
      String contentText, 
      String buttonText, 
      {double fontSizeTitle, 
      double fontSizeContent
    }) async {
    return showDialog<Null>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return new AlertDialog(
          title: new Text(title, style: new TextStyle(fontSize: fontSizeTitle ?? 27.0),),
          content: new SingleChildScrollView(
            child: new ListBody(
              children: <Widget>[
                new Text(contentText, style: new TextStyle(fontSize: fontSizeContent ?? 40.0),),
              ],
            ),
          ),
          actions: <Widget>[
            new FlatButton(
              child: new Text(buttonText, style: new TextStyle(color: Colors.deepOrange[400]),),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}