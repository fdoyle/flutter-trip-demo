import 'dart:math';

import 'package:flight_app/BackgroundGradientWidget.dart';
import 'package:flight_app/Page.dart';
import 'package:flight_app/data.dart';
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
        primarySwatch: Colors.red,
      ),
      debugShowCheckedModeBanner: false,

      home: MyHomePage(title: 'Flutter Demo Home Page'),
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

    List<Flight> flights = getFlights();

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
                        Flight flight = flights[i];
                        return Stack(children: <Widget>[
                          Positioned(
                            child: Opacity(
                              opacity: 0.2* pow(2, -40*pow(currentPosition - i, 2)),
                              child: Text(
                                flight.destination,
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
                      itemCount: flights.length,
                      pageSnapping: false,
                      reverse: true,
                      controller: secondaryController,
                    ),
                    PageView.builder(
                        itemBuilder: (BuildContext c, int i) {
                          Flight flight = flights[i];
                          return Center(
                            child: Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: Opacity(
                                  opacity: 0.5* pow(2, -3*pow(currentPosition - i, 2))+.5,
                                  child: PageWidget(flight, currentPosition - i)),
                            ),
                          );
                        },
                        itemCount: flights.length,
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
