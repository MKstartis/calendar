import 'package:flutter/material.dart';
import 'dart:math';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  static const String _title = 'Widget Example';
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'calcu',
      theme: ThemeData(
        primarySwatch: Colors.yellow,
      ),
      home: WidgetApp(),
    );
  }
}

class WidgetApp extends StatefulWidget {
  @override
  _WidgetExampleState createState() => _WidgetExampleState();
}

class _WidgetExampleState extends State<WidgetApp> {
  String sum = '';
  TextEditingController value1 = TextEditingController();
  TextEditingController value2 = TextEditingController();

  List _buttonList = ['ADD', 'SUB', 'MUL','DIV'];
  List<DropdownMenuItem<String>> _dropDownMenuItem = [];
  String? _buttonText;
  IconData? _selectedIcon;
  AssetImage? _image; // 이미지 변수 추가

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Widget Example'),
      ),
      body: Container(
        child: Center(
          child: Column(
            children: <Widget>[
              Padding(
                padding: EdgeInsets.all(15),
                child: Text('Result: $sum', style: TextStyle(fontSize: 20),),
              ),
              Padding(
                padding: EdgeInsets.only(left: 20, right: 20),
                child: TextField(keyboardType: TextInputType.number, controller: value1,),
              ),
              Padding(
                padding: EdgeInsets.only(left: 20, right: 20),
                child: TextField(keyboardType: TextInputType.number, controller: value2,),
              ),
              Padding(
                padding: EdgeInsets.all(15),
                child: ElevatedButton(
                    child: Row(
                      children: <Widget>[
                        Icon(_selectedIcon),
                        Text(_buttonText!)
                      ],
                    ),
                    style: ButtonStyle(backgroundColor: MaterialStateProperty.all(Colors.amber)),
                    onPressed: (){
                      setState(() {
                        var value1Int = double.parse(value1.value.text);
                        var value2Int = double.parse(value2.value.text);
                        var result;

                        if(_buttonText == 'ADD'){
                          result = value1Int + value2Int;
                        } else if(_buttonText == 'SUB'){
                          result = value1Int - value2Int;
                        } else if(_buttonText == 'MUL'){
                          result = value1Int * value2Int;
                        } else {
                          result = value1Int / value2Int;
                        }
                        sum= '$result';
                      });
                    }
                ),
              ),
              Padding(padding: EdgeInsets.all(15),
                child: DropdownButton(
                  items: _dropDownMenuItem,
                  onChanged: (String? value){
                    setState(() {
                      _buttonText = value;
                      if (_buttonText == 'ADD') {
                        _selectedIcon = Icons.add;
                      } else if (_buttonText == 'SUB') {
                        _selectedIcon = Icons.remove;
                      } else if (_buttonText == 'MUL') {
                        _selectedIcon = Icons.clear;
                      } else if (_buttonText == 'DIV') {
                        _selectedIcon = Icons.settings;
                      }
                    });
                  },
                  value: _buttonText,
                ),
              ),
              ElevatedButton(
                onPressed: () {
                  setState(() {
                    // 랜덤한 숫자 생성
                    Random random = Random();
                    int randomNumber = random.nextInt(100); // 0부터 99까지의 랜덤한 숫자 생성
                    // 결과를 업데이트
                    sum = '$randomNumber';
                  });
                },
                child: Text('Random Number'),
              ),
              SizedBox(height: 20), // 이미지와 버튼 사이 간격 조정
              _image != null ? Image(image: _image!) : Container(), // 이미지 표시
              ElevatedButton(
                onPressed: () {
                  setState(() {
                    // 이미지 업데이트
                    _image = AssetImage('assets/images/flutter_logo.png');
                  });
                },
                child: Text('Show Image'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    for (var item in _buttonList){
      _dropDownMenuItem.add(DropdownMenuItem(value: item, child: Text(item)));
    }
    // 초기 아이콘 설정
    _selectedIcon = Icons.add;
    _buttonText = _dropDownMenuItem[0].value;
  }
}
