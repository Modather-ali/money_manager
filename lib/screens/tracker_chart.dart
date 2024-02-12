import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class TrackerChart extends StatefulWidget {
  final List scoreOfMonth;
  final num target;
  const TrackerChart({
    super.key,
    required this.scoreOfMonth,
    required this.target,
  });

  @override
  State<TrackerChart> createState() => _TrackerChartState();
}

class _TrackerChartState extends State<TrackerChart> {
  List<FlSpot> spots = [];
  List<FlSpot> targetSpots = [];
  final ScrollController _controller = ScrollController();
  _getSpots() {
    for (int dayNumber = 1;
        dayNumber <= widget.scoreOfMonth.length;
        dayNumber++) {
      spots.add(
        FlSpot(
          dayNumber.toDouble(),
          widget.scoreOfMonth[dayNumber - 1].toDouble(),
        ),
      );
      targetSpots.add(
        FlSpot(
          dayNumber.toDouble(),
          widget.target.toDouble(),
        ),
      );
    }
    setState(() {});
  }

  @override
  void initState() {
    _getSpots();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      controller: _controller,
      reverse: true,
      child: Container(
        width: 1000,
        height: double.maxFinite,
        padding: const EdgeInsets.only(top: 50),
        child: LineChart(
          _chartData,
        ),
      ),
    );
  }

  LineChartData get _chartData => LineChartData(
        lineBarsData: [
          habitChartData,
          targetChart,
        ],
        minY: 0,
        lineTouchData: const LineTouchData(),
      );

  LineChartBarData get habitChartData => LineChartBarData(
        barWidth: 2,
        isStrokeCapRound: true,
        spots: spots,
        belowBarData: BarAreaData(show: true),
      );

  LineChartBarData get targetChart => LineChartBarData(
        barWidth: 1,
        isStrokeCapRound: true,
        spots: targetSpots,
        color: Colors.orange,
        show: widget.target > 0,
      );
}
