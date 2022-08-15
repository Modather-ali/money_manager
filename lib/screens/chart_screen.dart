import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

// final _data1 = <double, double>{1: 10, 2: 15, 3: 20, 4: 28, 5: 34, 6: 50};
final _outCome = <double, double>{
  1: 8,
  2: 12,
  3: 27,
  4: 31,
  5: 36,
  6: 45,
  7: 10,
  8: 50,
  9: 30,
  10: 5,
  11: 25,
  12: 35,
  13: 55,
  14: 10,
  15: 8,
  16: 12,
  17: 27,
  18: 31,
  19: 36,
  21: 33,
  22: 50,
  23: 30,
  24: 5,
  25: 25,
  26: 35,
  27: 55,
  29: 10,
  30: 42,
};
final _inCome = <double, double>{
  1: 8,
  2: 50,
  3: 0,
  4: 22,
  5: 0,
  6: 0,
  7: 40,
  8: 60,
  9: 0,
  10: 5,
  11: 0,
  12: 10,
  13: 55,
  14: 20,
  15: 0,
  16: 40,
  17: 10,
  18: 75,
  19: 50,
  21: 0,
  22: 0,
  23: 0,
  24: 5,
  25: 15,
  26: 0,
  27: 0,
  29: 0,
  30: 0,
};

class ChartScreen extends StatefulWidget {
  const ChartScreen({Key? key}) : super(key: key);

  @override
  _ChartScreenState createState() => _ChartScreenState();
}

class _ChartScreenState extends State<ChartScreen> {
  bool _showIncome = true;
  bool _showOutcome = true;

  bool _showBelowArea = false;
  bool _showDot = true;

  @override
  Widget build(BuildContext context) {
    final spots1 = <FlSpot>[
      for (final entry in _inCome.entries) FlSpot(entry.key, entry.value)
    ];
    final spots2 = <FlSpot>[
      for (final entry in _outCome.entries) FlSpot(entry.key, entry.value)
    ];

    final lineChartData = LineChartData(
      maxX: 30,
      maxY: 80,
      lineBarsData: [
        LineChartBarData(
          spots: spots1,
          color: Colors.blue,
          show: _showIncome,
          dotData: FlDotData(show: _showDot),
          belowBarData:
              BarAreaData(show: _showBelowArea, color: Colors.blue[200]),
        ),
        LineChartBarData(
          show: _showOutcome,
          aboveBarData: BarAreaData(color: Colors.green),
          showingIndicators: [1, 2, 3],
          spots: spots2,
          color: Colors.red,
          isCurved: true,
          dotData: FlDotData(show: _showDot),
          belowBarData: BarAreaData(
              show: _showBelowArea, color: Colors.red.withOpacity(0.3)),
        ),
      ],
      // ! Behavior when touching the chart:
      lineTouchData: LineTouchData(
        touchTooltipData: LineTouchTooltipData(
          tooltipBgColor: Colors.blueGrey.withOpacity(0.8),
        ),
        touchCallback: (_, __) {},
        handleBuiltInTouches: true,
      ),
      // ! Borders:
      borderData: FlBorderData(
        show: true,
        border: const Border(
          bottom: BorderSide(color: Colors.greenAccent, width: 4),
          left: BorderSide(color: Colors.transparent),
          right: BorderSide(color: Colors.transparent),
          top: BorderSide(color: Colors.transparent),
        ),
      ),
      // ! Grid behavior:
      gridData: FlGridData(),
      // ! Title and ticks in the axis
      titlesData: FlTitlesData(
        show: true,
        bottomTitles: AxisTitles(
          axisNameWidget: const Text('Day'),
          sideTitles: SideTitles(
            showTitles: true, // this is false by-default.
          ),
        ),
        leftTitles: AxisTitles(
          axisNameWidget: const Text('Value'),
          sideTitles: SideTitles(
            showTitles: true,
            getTitlesWidget: (double val, _) {
              if (val.toInt() % 5 != 0) return const Text('');
              return Text('${val.toInt()}');
            },
          ),
        ),
      ),
    );
    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.all(10),
          child: ListView(
            scrollDirection: Axis.horizontal,
            children: [
              SizedBox(
                height: MediaQuery.of(context).size.height,
                width: 1000,
                child: LineChart(lineChartData),
              ),
            ],
          ),
        ),
        bottomNavigationBar: _buildControlWidgets(),
      ),
    );
  }

  Widget _buildControlWidgets() {
    return Container(
      height: 60,
      color: Colors.grey[200],
      child: ListView(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.only(bottom: 10, right: 10, left: 10),
        children: [
          _switchRow(
            title: "Show Income",
            switchValue: _showIncome,
            onChanged: (bool val) => setState(() => _showIncome = val),
          ),
          _switchRow(
            title: "Show Outcome",
            switchValue: _showOutcome,
            onChanged: (bool val) => setState(() => _showOutcome = val),
          ),
          _switchRow(
            title: "Show Below Area",
            switchValue: _showBelowArea,
            onChanged: (bool val) => setState(() => _showBelowArea = val),
          ),
          _switchRow(
            title: "Show Dot",
            switchValue: _showDot,
            onChanged: (bool val) => setState(() => _showDot = val),
          ),
        ],
      ),
    );
  }

  Widget _switchRow({
    required String title,
    required bool switchValue,
    required void Function(bool)? onChanged,
  }) {
    return Row(
      children: [
        Text(
          title,
          style: const TextStyle(fontWeight: FontWeight.w600),
        ),
        Switch(value: switchValue, onChanged: onChanged),
        const SizedBox(width: 10),
      ],
    );
  }
}
