import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

void main() {
  runApp(MyDockerApp());
}

web() async {
  //var url =
  //" http://192.168.225.205/home.html/cgi-bin/web.py?x=${os}&y=${image}";
  var url = "http://192.168.225.205/cgi-bin/date.py";
  //var url = " http://192.168.0.106/home.html/cgi-bin/web.py?x=${cmd}";
  var response = await http.get(url);
  print(response.body);
}

class MyDockerApp extends StatelessWidget {
  String osName;
  String imageName;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Scaffold(
          appBar: AppBar(),
          body: Center(
            child: Container(
              width: 300,
              height: 300,
              color: Colors.grey,
              child: Column(
                children: <Widget>[
                  TextField(
                    autocorrect: false,
                    onChanged: (value) {
                      osName = value;
                    },
                    textAlign: TextAlign.center,
                    decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        hintText: "Enter your docker OS name",
                        prefixIcon: Icon(Icons.tablet_android)),
                  ),
                  TextField(
                    onChanged: (value) {
                      imageName = value;
                    },
                    autocorrect: false,
                    textAlign: TextAlign.center,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: "Enter docker image name",
                      prefixIcon: Icon(Icons.tablet_android),
                    ),
                  ),
                  FlatButton(
                      onPressed: () {
                        web();
                        //print(osName);
                      },
                      child: Text('click here')),
                ],
              ),
            ),
          ),
        ));
  }
}
