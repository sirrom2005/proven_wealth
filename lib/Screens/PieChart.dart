import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import '../Models/ChartData.dart';

int touchedIndex = -1;

class MyPieChartData extends StatefulWidget {
  final List<ChartData> pieChartData;

  const MyPieChartData({
    super.key,
    required this.pieChartData
  });

  @override
  State<StatefulWidget> createState() => PieChart2State();
}

class PieChart2State extends State<MyPieChartData> {
  List<ChartData> chartData = [];

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    chartData = widget.pieChartData;

    return AspectRatio(
      aspectRatio: 1,
      child: Row(
        children: <Widget>[
          Expanded(
            child: PieChart(
              PieChartData(
                pieTouchData: PieTouchData(
                  touchCallback: (FlTouchEvent event, pieTouchResponse) {
                    setState(() {
                      if (!event.isInterestedForInteractions ||
                          pieTouchResponse == null ||
                          pieTouchResponse.touchedSection == null) {
                        touchedIndex = -1;
                        return;
                      }
                      touchedIndex = pieTouchResponse.touchedSection!.touchedSectionIndex;
                    });
                  },
                ),
                borderData: FlBorderData( show: false ),
                sectionsSpace: 5,
                centerSpaceRadius: 30,
                sections: showingSections(),
              ),
            ),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: chartData.map((ele) =>
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 0, 0, 4),
                child: Indicator(
                  color: ele.color,
                  text: ele.title,
                  isSquare: false,
                ),
              )
            ).toList()
          ),
          const SizedBox(
            width: 28,
          ),
        ],
      ),
    );
  }

  List<PieChartSectionData> showingSections() {
    return List.generate(chartData.length, (i) {
      final isTouched = i == touchedIndex;
      final fontSize = isTouched ? 25.0 : 16.0;
      final radius = isTouched ? 60.0 : 50.0;
      const shadows = [Shadow(color: Colors.black, blurRadius: 2)];
      if (i==chartData[i].index) {
          return
          PieChartSectionData(
            color: chartData[i].color,
            value: chartData[i].chartValue,
            title: chartData[i].chartTitle,
            radius: radius,
            titleStyle: TextStyle(
              fontSize: fontSize,
              fontWeight: FontWeight.bold,
              color: Colors.white,
              shadows: shadows,
            ),
          );
      }else{
        throw Error();
      }
    });
  }
}

class Indicator extends StatelessWidget {
  const Indicator({
    super.key,
    required this.color,
    required this.text,
    required this.isSquare,
    this.size = 16,
    this.textColor,
  });
  final Color color;
  final String text;
  final bool isSquare;
  final double size;
  final Color? textColor;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        OutlinedButton(
          onPressed: () {  },
          style: ButtonStyle(
            alignment: Alignment.centerLeft,
            visualDensity: VisualDensity.comfortable
          ),
          child: Row(
            children: [
              Container(
                width: size,
                height: size,
                decoration: BoxDecoration(
                  shape: isSquare ? BoxShape.rectangle : BoxShape.circle,
                  color: color,
                ),
              ),
              const SizedBox(width: 4),
              SizedBox(
                width: 100,
                child: Text(
                  text,
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: textColor,
                  ),
                ),
              ),
            ],
          ),
        )
      ],
    );
  }
}