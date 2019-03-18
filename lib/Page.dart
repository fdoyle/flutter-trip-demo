import 'dart:math';

import 'package:flight_app/DetailPageRoute.dart';
import 'package:flight_app/data.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

Color toFromTextColor = Color(0xFF6E6896);

TextStyle little = TextStyle(
  color: toFromTextColor,
  fontSize: 12,
  fontWeight: FontWeight.normal,
  fontFamily: "Roboto",
  decoration: TextDecoration.none,
);
TextStyle big = TextStyle(
  color: toFromTextColor,
  fontWeight: FontWeight.bold,
  fontSize: 50,
  fontFamily: "Roboto",
  decoration: TextDecoration.none,
);

class PageWidget extends StatelessWidget {
  double distanceFromCenter = 0;
  Flight flight;

  PageWidget(Flight flight, double distanceFromCenter) {
    this.distanceFromCenter = distanceFromCenter;
    this.flight = flight;
  }

  @override
  Widget build(BuildContext context) {
    TextStyle smallGrey = TextStyle(
        color: Colors.black26, fontWeight: FontWeight.bold, fontSize: 12);

    TextStyle bigRed = TextStyle(
        color: Color(0xFFB0548B), fontWeight: FontWeight.bold, fontSize: 42);

    return Stack(
      overflow: Overflow.visible,
      children: <Widget>[
        Padding(
          child: Container(
            decoration: BoxDecoration(boxShadow: [
              BoxShadow(color: Color(0xFF572F72), blurRadius: 20),
            ]),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(4),
              child: GestureDetector(
                onTap: () {
                  Navigator.of(context).push(
                    DetailPageRoute(flight),
                  );
                },
                child: Container(
                  child: Stack(
                    children: <Widget>[
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
                              )),
                        ),
                      ),
                      Column(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          AspectRatio(
                            aspectRatio: 16.0 / 11.0,
                            child: Hero(
                              tag: "image${flight.id}",
                              child: Image.network(
                                flight.url,
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          Hero(
                            tag: "info${flight.id}",
                            flightShuttleBuilder: (
                              BuildContext flightContext,
                              Animation<double> animation,
                              HeroFlightDirection flightDirection,
                              BuildContext fromHeroContext,
                              BuildContext toHeroContext,
                            ) {
                              return Padding(
                                padding: const EdgeInsets.all(12.0),
                                child: FlightInfo(flight),
                              );
                            },
                            child: Padding(
                              padding: const EdgeInsets.all(12.0),
                              child: FlightInfo(flight),
                            ),
                          ),
                          Divider(
                            color: Colors.grey,
                          ),
                          Padding(
                            padding: const EdgeInsets.all(12.0),
                            child: Row(
                              children: <Widget>[
                                Expanded(
                                    child: Text(
                                  "non-Stop",
                                  style: smallGrey,
                                )),
                                Text(
                                  "\$",
                                  style: smallGrey,
                                ),
                                Text(
                                  "${flight.price}",
                                  style: bigRed,
                                )
                              ],
                            ),
                          )
                        ],
                      )
                    ],
                  ),
                ),
              ),
            ),
          ),
          padding: EdgeInsets.only(top: 40),
        ),
        //this Positioned.directional binds the below text to the top-left corner of the stack
        //but does not bind it on the "end" side, allowing the title to overflow outside the stack
        //it looks bad on long titles like "new york", but that's what the design calls for
        Positioned.directional(
          textDirection: TextDirection.ltr,
          top: 0,
          start: 0,
          child: Padding(
            padding: const EdgeInsets.only(left: 8),
            child: Opacity(
              opacity: pow(2, -40 * pow(distanceFromCenter, 2)),
              child: Transform.translate(
                offset: Offset(distanceFromCenter * 40, 0),
                child: Hero(
                  tag: "title${flight.id}",
                  child: Text(
                    "${flight.destination}",
                    maxLines: 1,
                    overflow: TextOverflow.fade,
                    style: TextStyle(
                        fontSize: 64,
                        shadows: [
                          Shadow(color: Color(0x88000000), blurRadius: 12)
                        ],
                        fontWeight: FontWeight.bold,
                        fontFamily: "Roboto",
                        decoration: TextDecoration.none,
                        decorationColor: Colors.transparent,
                        color: Colors.white),
                  ),
                ),
              ),
            ),
          ),
        )
      ],
    );
  }
}

class FlightInfo extends StatelessWidget {
  Flight flight;

  FlightInfo(this.flight);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text("FROM", style: little),
            Text("${flight.sourceCode}", style: big),
            Text("${flight.source}, ${flight.sourceCountry}", style: little)
          ],
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: <Widget>[
            Text(
              "TO",
              style: little,
              maxLines: 1,
            ),
            Text("${flight.destinationCode}", style: big),
            Text(
              "${flight.destination}, ${flight.destinationCountry}",
              style: little,
              maxLines: 1,
            )
          ],
        )
      ],
    );
  }
}
