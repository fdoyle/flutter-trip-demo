import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class PageWidget extends StatelessWidget {
  double distanceFromCenter = 0;

  PageWidget(double distanceFromCenter){
    this.distanceFromCenter = distanceFromCenter;
  }


  @override
  Widget build(BuildContext context) {
    Color toFromTextColor = Color(0xFF6E6896);
    TextStyle little = TextStyle(
      color: toFromTextColor,
      fontSize: 12
    );
    TextStyle big = TextStyle(
        color: toFromTextColor,
        fontWeight: FontWeight.bold,
        fontSize: 50
    );

    TextStyle smallGrey = TextStyle(
        color: Colors.black26,
        fontWeight: FontWeight.bold,
        fontSize: 12
    );

    TextStyle bigRed = TextStyle(
        color: Color(0xFFB0548B),
        fontWeight: FontWeight.bold,
        fontSize: 42
    );

    return Stack(
      children: <Widget>[
        Padding(
          child: Container(
            decoration:
            BoxDecoration(
              boxShadow: [BoxShadow(
                color: Color(0xFF572F72),
                blurRadius: 20
              ),]
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(4),
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    AspectRatio(
                      aspectRatio: 16.0/11.0,
                      child: Image.network(
                          "http://all4desktop.com/data_images/original/4203287-eiffel-tower-at-night-paris-france-normal.jpg",
                        fit: BoxFit.cover,
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
                              Text("TZX", style: big),
                              Text("Trabzon, Turkey", style: little)
                            ],
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: <Widget>[
                              Text("TO", style: little),
                              Text("CDG", style: big),
                              Text("Paris, France", style: little)
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
                          Expanded(child: Text("non-Stop", style: smallGrey,)),
                          Text("\$", style: smallGrey,),
                          Text("879", style: bigRed,)
                        ],
                      ),
                    )

                  ],
                ),
              ),
            ),
          ),
          padding: EdgeInsets.only(top: 40),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8),
          child: Opacity(
            opacity: pow(2, -40*pow(distanceFromCenter, 2)),
            child: Transform.translate(
              offset: Offset(distanceFromCenter * 40, 0),
              child: Text("Paris",
                style: TextStyle(
                fontSize: 64,
                  shadows: [
                    Shadow(color: Color(0x88000000), blurRadius: 12)
                  ],
                  fontWeight: FontWeight.bold,
                  color: Colors.white
              ),),
            ),
          ),
        )
      ],
    );
  }

}
