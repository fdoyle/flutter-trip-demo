import 'dart:math';

import 'package:flight_app/DetailPageRoute.dart';
import 'package:flight_app/data.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class PageWidget extends StatelessWidget {
  double distanceFromCenter = 0;
  Flight flight;

  PageWidget(Flight flight, double distanceFromCenter) {
    this.distanceFromCenter = distanceFromCenter;
    this.flight = flight;
  }

  @override
  Widget build(BuildContext context) {
    Color toFromTextColor = Color(0xFF6E6896);
    TextStyle little = TextStyle(color: toFromTextColor, fontSize: 12);
    TextStyle big = TextStyle(
        color: toFromTextColor, fontWeight: FontWeight.bold, fontSize: 50);

    TextStyle smallGrey = TextStyle(
        color: Colors.black26, fontWeight: FontWeight.bold, fontSize: 12);

    TextStyle bigRed = TextStyle(
        color: Color(0xFFB0548B), fontWeight: FontWeight.bold, fontSize: 42);

    return Stack(
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
                          Padding(
                            padding: const EdgeInsets.all(12.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Text("FROM", style: little),
                                    Text("${flight.sourceCode}", style: big),
                                    Text(
                                        "${flight.source}, ${flight.sourceCountry}",
                                        style: little)
                                  ],
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: <Widget>[
                                    Text("TO", style: little),
                                    Text("${flight.destinationCode}",
                                        style: big),
                                    Text(
                                        "${flight.destination}, ${flight.destinationCountry}",
                                        style: little)
                                  ],
                                )
                              ],
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
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8),
          child: Opacity(
            opacity: pow(2, -40 * pow(distanceFromCenter, 2)),
            child: Transform.translate(
              offset: Offset(distanceFromCenter * 40, 0),
              child: Hero(
                tag: "title${flight.id}",
                child: Text(
                  "${flight.destination}",
                  maxLines: 1,
                  style: TextStyle(
                      fontSize: 64,
                      shadows: [
                        Shadow(color: Color(0x88000000), blurRadius: 12)
                      ],
                      fontWeight: FontWeight.bold,
                      color: Colors.white),
                ),
              ),
            ),
          ),
        )
      ],
    );
  }
}
