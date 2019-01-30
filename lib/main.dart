import 'dart:math';

import 'package:flight_app/BackgroundGradientWidget.dart';
import 'package:flight_app/pageWidget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.red,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  PageController primaryController;
  PageController secondaryController;

  double currentPosition = 0;

  _MyHomePageState() {
    primaryController = PageController(viewportFraction: 0.8);
    secondaryController = PageController(viewportFraction: 0.8);
    primaryController.addListener(() {
      setState(() {
        currentPosition = primaryController.page;
      });
      secondaryController.jumpTo(primaryController.position.pixels);
    });
  }
  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.

    return Scaffold(
      body: Container(
        child: Stack(children: <Widget>[
          Positioned.fill(child: BackgroundGradientWidget()),
          SafeArea(
            child: Column(
              children: <Widget>[
                Text(
                  "CAMPAIGNS",
                  style: TextStyle(
                    fontSize: 20,
                    color: Colors.white70,
                  ),
                ),
                Expanded(
                  child: Stack(children: <Widget>[
                    PageView.builder(
                      itemBuilder: (BuildContext c, int i) {
                        return Stack(children: <Widget>[
                          Positioned(
                            child: Opacity(
                              opacity: 0.2* pow(2, -40*pow(currentPosition - i, 2)),
                              child: Text(
                                "Thisisareallylongstring",
                                overflow: TextOverflow.clip,
                                maxLines: 1,
                                style: TextStyle(
                                  shadows: [Shadow( color: Colors.black45, blurRadius: 16)],
                                    fontSize: 200, color: Colors.white),
                              ),
                            ),
                            left: -100,
                            right: -1000,
                          ),
                          ],
                        overflow: Overflow.visible,);
                      },
                      pageSnapping: false,
                      reverse: true,
                      controller: secondaryController,
                    ),
                    PageView.builder(
                        itemBuilder: (BuildContext c, int i) {
                          return Center(
                            child: Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: PageWidget(currentPosition - i),
                            ),
                          );
                        },
                        controller: primaryController),
                  ]),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: <Widget>[
                    Icon(Icons.audiotrack, size: 48, color: Colors.white70),
                    Icon(Icons.access_time, size: 48, color: Colors.white30),
                    Icon(Icons.mic, size: 48, color: Colors.white30),
                    Icon(Icons.print, size: 48, color: Colors.white30)
                  ],
                )
              ],
            ),
          ),
        ]),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
