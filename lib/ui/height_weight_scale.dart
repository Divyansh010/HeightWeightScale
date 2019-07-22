import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:height_weight_scale/model/measurement_line.dart';

class HeightWeightScalePage extends StatefulWidget {
  @override
  _HeightWeightScalePageState createState() => _HeightWeightScalePageState();
}

class _HeightWeightScalePageState extends State<HeightWeightScalePage> {
  ScrollController _controller;
  List<MeasurementLine> measurementLineList = List<MeasurementLine>();

  _scrollListener() {
    debugPrint('${_controller.offset}');
  }

  @override
  void initState() {
    super.initState();
    _controller = ScrollController(initialScrollOffset: -100);
    _controller.addListener(_scrollListener);

    _fillData();
  }

  @override
  void dispose() {
    _controller.removeListener(_scrollListener);
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Row(
          children: <Widget>[
            Expanded(
              child: Center(
                child: Text(
                  'Height is 13',
                  style: TextStyle(fontSize: 30),
                ),
              ),
            ),
            Container(
              width: 90,
              decoration: BoxDecoration(color: Colors.tealAccent[200]),
              child: Row(
                children: <Widget>[
                  RotatedBox(
                    quarterTurns: 1,
                    child: Image.asset(
                      'assets/images/tooltip.png',
                      scale: 1,
                    ),
                  ),
                  Expanded(
                      child: ListView.builder(
                    physics: BouncingScrollPhysics(),
                    controller: _controller,
                    itemCount: measurementLineList.length,
                    padding: EdgeInsets.only(
                        left: 5,
                        top: MediaQuery.of(context).size.height * 0.46),
                    itemBuilder: (context, index) {
                      final mLine = measurementLineList[index];

                      if (mLine.type == Line.big) {
                        return Stack(
                          alignment: AlignmentDirectional.bottomEnd,
                          overflow: Overflow.visible,
                          children: <Widget>[
                            Positioned(
                              top: 4,
                              left: 0,
                              child: Text(
                                '${mLine.value}',
                                style: TextStyle(fontSize: 25),
                              ),
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: <Widget>[
                                SizedBox(
                                  height: 17,
                                ),
                                Container(
                                  height: 3,
                                  width: 30,
                                  decoration:
                                      BoxDecoration(color: Colors.black54),
                                ),
                              ],
                            )
                          ],
                        );
                      } else if (measurementLineList[index].type ==
                          Line.small) {
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: <Widget>[
                            SizedBox(
                              height: 19,
                            ),
                            Container(
                              height: 1,
                              width: 20,
                              decoration: BoxDecoration(color: Colors.blueGrey),
                            ),
                          ],
                        );
                      } else {
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: <Widget>[
                            SizedBox(
                              height: 18,
                            ),
                            Container(
                              height: 2,
                              width: 30,
                              decoration: BoxDecoration(color: Colors.black54),
                            ),
                          ],
                        );
                      }
                    },
                  ))
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  void _fillData() {
    for (int i = 0; i <= 13; i++) {
      measurementLineList.add(MeasurementLine(type: Line.big, value: i));
      for (int j = 0; j <= 10; j++) {
        measurementLineList.add(j != 5
            ? MeasurementLine(type: Line.small, value: i)
            : MeasurementLine(type: Line.medium, value: i));
      }
    }
  }
}
