import 'package:flight_app/Page.dart';
import 'package:flight_app/data.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class DetailPageRoute extends CupertinoPageRoute {
  DetailPageRoute(Flight f) : super(builder: (context) => DetailWidget(f));

  @override
  Widget buildTransitions(BuildContext context, Animation<double> animation,
      Animation<double> secondaryAnimation, Widget child) {
    return child;
  }
}

class DetailWidget extends StatelessWidget {
  Flight flight;

  DetailWidget(this.flight);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.transparent,
        body: GestureDetector(
            onTap: () {
              Navigator.pop(context);
            },
            child: Stack(children: <Widget>[
              Positioned(
                top: 0,
                bottom: 0,
                left: 0,
                right: 0,
                child: Hero(
                    tag: "background${flight.id}",
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(4),
                      child: Container(
                        decoration: BoxDecoration(color: Colors.white),
                      ),
                    )),
              ),
              Column(
                children: <Widget>[
                  Stack(
                    children: <Widget>[
                      Hero(
                          tag: "image${flight.id}",
                          child: Image.network(
                            flight.url,
                            fit: BoxFit.cover,
                          )),
                      Positioned.fill(
                        child: Center(
                          child: Hero(
                            tag: "title${flight.id}",

                            child: Text(
                              flight.destination,
                              maxLines: 1,
                              style: TextStyle(
                                  fontSize: 64,

                                  shadows: [
                                    Shadow(
                                        color: Color(0x88000000), blurRadius: 12)
                                  ],
                                  fontWeight: FontWeight.bold,
                                  decoration: TextDecoration.none,
                                  fontFamily: "Roboto",
                                  color: Colors.white),
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                  Hero(
                    tag: "info${flight.id}",
                    child: Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: FlightInfo(flight),
                    ),
                  ),
                ],
              ),
            ])));
  }
}
