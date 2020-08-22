import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:hexcolor/hexcolor.dart';

void main() {
  runApp(MyDockerApp());
}

class MyDockerApp extends StatefulWidget {
  @override
  _MyDockerAppState createState() => _MyDockerAppState();
}

class _MyDockerAppState extends State<MyDockerApp> {
  String cmd;

  String imageName;

  bool waiting = false;

  List history = ["docker run -it centos:7"];

  int count;

  String output = "";

  List commands = [
    "docker ps",
    "docker images",
    "docker network ls",
    "docker volume ls",
    "docker inspect <enter_name>",
    "docker run -dit --name <enter_name> centos:7",
    "docker stop <enter_name>",
    "docker rm -f \$(docker ps -a -q)"
  ];

  List cmdnames = [
    "List all docker containers",
    "List all docker images",
    "List all docker networks",
    "List all docker volumes",
    "Inspect",
    "Launch new docker",
    "Stop a docker",
    "Delete all dockers"
  ];

  final myController = TextEditingController();

  var ip = "192.168.43.228";
  // var colour = '#2AA298';
  var colour = '#301E5D';

  var clickColor = '#ffffff';

  @override
  initState() {
    count = 0;
  }

  web() async {
    String newcmd = cmd?.replaceAll(" ", "_"); //if cmd is null,? checks it

    var url = "http://$ip/cgi-bin/script.py?x=$newcmd";
    setState(() {
      waiting = true;
      myController.text = "";
    });
    var response = await http.get(url);
    setState(() {
      waiting = false;
    });
    print(response.body);
    var temp = jsonDecode(response.body.toString());
    output = temp['output'];
    print(cmd);
  }

  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        resizeToAvoidBottomInset: false,
        // appBar: AppBar(
        //   title: Text(" "),
        //   backgroundColor: Hexcolor('#0a0613'),
        //   shadowColor: Colors.grey,
        // ),
        body: Center(
          child: Stack(children: <Widget>[
            Container(
              width: double.infinity,
              height: double.infinity,
              child: Column(
                children: <Widget>[
                  //SizedBox(
                  //height: 20,
                  //),
                  Container(
                    padding: EdgeInsets.all(15),
                    height: 310,
                    decoration: BoxDecoration(
                        color: Hexcolor('#0a0613'),
                        boxShadow: [
                          new BoxShadow(color: Colors.black, blurRadius: 20.0)
                        ]),
                    child: Flexible(
                      child: new ListView.builder(
                          itemCount: history.length,
                          itemBuilder: (BuildContext context, int index) {
                            return new Row(
                              children: <Widget>[
                                SizedBox(
                                  width: 20,
                                ),
                                Text(
                                  "Bash \$: ",
                                  style: TextStyle(
                                    color: Colors.red,
                                    fontSize: 20.0,
                                  ),
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                                if (history.length - index == 1)
                                  Flexible(
                                      child: TextField(
                                    controller: myController,
                                    maxLines: null,
                                    onChanged: (value) {
                                      cmd = value;
                                    },
                                    style:
                                        TextStyle(color: Hexcolor('#f1e7fe')),
                                    decoration: InputDecoration(
                                      border: InputBorder.none,
                                    ),
                                  ))
                                else
                                  Flexible(
                                      child: Text(
                                    history[index + 1],
                                    style:
                                        TextStyle(color: Hexcolor('#f1e7fe')),
                                  )),
                                SizedBox(
                                  height: 25,
                                )
                              ],
                            );
                          }),
                    ),
                  ),
                  Center(
                      child: Container(
                          margin: EdgeInsets.all(60),
                          //padding: EdgeInsets.only(top: 40),
                          //color: Colors.grey[200],
                          height: 180,
                          width: 280,
                          decoration: BoxDecoration(
                            color: Hexcolor('##f1e7fe'),
                            borderRadius: BorderRadius.circular(30),
                            border: Border.all(
                              //color: Hexcolor('#68FFC2'),
                              color: Hexcolor('#301E5D'),
                              width: 2,
                            ),
                            boxShadow: [
                              new BoxShadow(
                                  color: Colors.black, blurRadius: 15.0)
                            ],
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: <Widget>[
                              // Text("output",
                              //     style: TextStyle(
                              //       fontSize: 18.0,
                              //     )),
                              Container(
                                padding: EdgeInsets.all(20),
                                height: 140,
                                width: 250,
                                //color: Hexcolor('#44444'),
                                child: Flex(

                                    //expanded comes under Flex only
                                    direction: Axis
                                        .vertical, //a column, Axis.horizontal is a row
                                    children: <Widget>[
                                      Expanded(
                                          //takes space of parent widget
                                          child: SingleChildScrollView(
                                              child: waiting
                                                  ? Center(
                                                      child:
                                                          CircularProgressIndicator())
                                                  : Text(
                                                      output == ""
                                                          ? " output "
                                                          : output,
                                                      style: TextStyle(
                                                        fontSize: 18.0,
                                                      )))),
                                    ]),
                              ),
                            ],
                          )))
                ],
              ),
            ),
            // Positioned(
            //   //to positioned anything in the stack
            //   top: 344,
            //   left: 0,
            //   child: Builder(
            //     // very rare. Used for showBottomSheet which is need for list of commands. And it a widget like Scaffold or Builder just above it.
            //     builder: (context) => FlatButton(
            //       child: Container(
            //         height: 35,
            //         width: 175,
            //         alignment: Alignment.center,
            //         decoration: BoxDecoration(
            //           color: Colors.blue[300],
            //           borderRadius: BorderRadius.circular(15),
            //           boxShadow: [
            //             new BoxShadow(color: Colors.black, blurRadius: 20.0)
            //           ],
            //         ),

            //         child: Text(
            //           "List of Commands",
            //           style: TextStyle(color: Colors.black),
            //         ),
            //         //alignment: Alignment(1, 1),
            //       ),
            //       onPressed: () {
            //         showBottomSheet(
            //             backgroundColor: Colors.black,
            //             context: context,
            //             builder: (context) {
            //               return Container(
            //                   alignment: Alignment(1, -1),
            //                   height: 300,
            //                   width: double.infinity,
            //                   decoration: BoxDecoration(
            //                     borderRadius: BorderRadius.circular(20),
            //                     color: Colors.blue[300],
            //                   ),
            //                   //padding: EdgeInsets.only(top: 100, left: 100),
            //                   child: new ListView.builder(
            //                       itemCount: commands.length,
            //                       itemBuilder:
            //                           (BuildContext context, int index) {
            //                         return Container(
            //                           margin: EdgeInsets.only(top: 15),
            //                           decoration: BoxDecoration(
            //                             color: Colors.lightBlue[700],
            //                             borderRadius: BorderRadius.circular(13),
            //                             boxShadow: [
            //                               new BoxShadow(
            //                                   color: Colors.lightBlue[900],
            //                                   blurRadius: 20.0)
            //                             ],
            //                           ),
            //                           child: new FlatButton(
            //                             child: Text(cmdnames[index]),
            //                             onPressed: () {
            //                               myController.text = commands[index];
            //                               cmd = myController.text;
            //                             },
            //                           ),
            //                         );
            //                       }));
            //             });
            //       },
            //     ),
            //   ),
            // ),
            Positioned(
              top: 270,
              left: 315,
              child: GestureDetector(
                onTap: () {
                  web();
                  if (cmd != null) {
                    history.add(cmd);
                    setState() {
                      count++;
                    }

                    cmd = null;
                    print(history);
                  }
                },
                // child: Container(
                //   // margin: EdgeInsets.only(top: 352, left: 20),
                //   width: 175,
                //   alignment: Alignment.center,
                //   height: 35,
                //   child: Text("Run"),
                //   decoration: BoxDecoration(
                //     color: Colors.blue[300],
                //     borderRadius: BorderRadius.circular(15),
                //     boxShadow: [
                //       new BoxShadow(color: Colors.black, blurRadius: 20.0)
                //     ],
                //   ),
                // ),

                child: Container(
                  height: 80,
                  width: 80,
                  child: FloatingActionButton(
                    onPressed: () {
                      colour = clickColor;
                    },
                    child: Icon(
                      Icons.play_arrow,
                      size: 40,
                    ),
                    backgroundColor: Hexcolor(colour),
                  ),
                ),
              ),
            ),

            DraggableScrollableSheet(
                initialChildSize: 0.1,
                minChildSize: 0.1,
                maxChildSize: 0.8,
                builder: (BuildContext context, myscrollController) {
                  return Container(
                    color: Hexcolor('#301E5D'),
                    child: ListView.builder(
                        controller: myscrollController,
                        itemCount: commands.length,
                        itemBuilder: (BuildContext context, int index) {
                          return Container(
                            width: MediaQuery.of(context).size.width * 0.8,
                            margin: EdgeInsets.all(2),
                            padding: EdgeInsets.all(0.0),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: new RaisedButton(
                              color: Hexcolor('#301E5D'),
                              child: Text(
                                cmdnames[index],
                                style: TextStyle(
                                    fontSize: 18.0, color: Hexcolor('#f1e7fe')),
                              ),
                              onPressed: () {
                                myController.text = commands[index];
                                cmd = myController.text;
                              },
                            ),
                          );
                        }),
                  );
                }),
          ]),
        ),
        // floatingActionButton: Builder(builder: (context)=> FloatingActionButton(onPressed: (){
        //   showBottomSheet(
        //               context: context,
        //               builder: (context) {
        //                 return Container(
        //                   alignment: Alignment.center,
        //                   height: 300,
        //                   width: 375,
        //                   padding: EdgeInsets.only(top: 100, left: 100),
        //                   child: Text("BottomSheet"),
        //                 );
        //               });
        // },),
      ),
    );
  }
}
