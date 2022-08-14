import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

/// !!Step1: prepare the data to plot.
// final _data1 = <double, double>{1: 10, 2: 15, 3: 20, 4: 28, 5: 34, 6: 50};
final _data2 = <double, double>{
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
};

class ChartScreen extends StatefulWidget {
  const ChartScreen({Key? key}) : super(key: key);

  @override
  _ChartScreenState createState() => _ChartScreenState();
}

class _ChartScreenState extends State<ChartScreen> {
  bool _showGrid = true;
  bool _isCurved = false;
  bool _showBelowArea = false;
  bool _showDot = true;
  bool _showBorder = true;

  @override
  Widget build(BuildContext context) {
    /// !!Step2: convert data into a list of [FlSpot].
    // final spots1 = <FlSpot>[
    //   for (final entry in _data1.entries) FlSpot(entry.key, entry.value)
    // ];
    final spots2 = <FlSpot>[
      for (final entry in _data2.entries) FlSpot(entry.key, entry.value)
    ];

    /// !!Step3: prepare LineChartData
    /// !here we can set styles and behavior of the chart.
    final lineChartData = LineChartData(
      maxX: 30,
      maxY: 80,
      lineBarsData: [
        // ! Here we can style each data line.
        // LineChartBarData(
        //   spots: spots1,
        //   color: Colors.blue,
        //   barWidth: 8,
        //   isCurved: _isCurved,
        //   dotData: FlDotData(show: _showDot),
        //   belowBarData:
        //       BarAreaData(show: _showBelowArea, color: Colors.blue[200]),
        // ),
        LineChartBarData(
          aboveBarData: BarAreaData(color: Colors.green),
          showingIndicators: [1, 2, 3],
          spots: spots2,
          color: Colors.red,
          barWidth: 4,
          isCurved: true,
          dotData: FlDotData(show: _showDot),
          // belowBarData:
          //     BarAreaData(show: _showBelowArea, color: Colors.red[200]),
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
            // ! Decides how to show left titles,
            // here we skip some values by returning ''.
            getTitlesWidget: (double val, _) {
              if (val.toInt() % 5 != 0) return const Text('');
              return Text('${val.toInt()}');
            },
          ),
        ),
      ),
    );
    return Scaffold(
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
      // bottomNavigationBar: _buildControlWidgets(),
    );
  }

  Widget _buildControlWidgets() {
    return Container(
      height: 200,
      color: Colors.grey[200],
      child: ListView(
        children: [
          SwitchListTile(
            title: const Text('Curved'),
            onChanged: (bool val) => setState(() => _isCurved = val),
            value: _isCurved,
          ),
          SwitchListTile(
            title: const Text('ShowGrid'),
            onChanged: (bool val) => setState(() => _showGrid = val),
            value: _showGrid,
          ),
          SwitchListTile(
            title: const Text('ShowBorder'),
            onChanged: (bool val) => setState(() => _showBorder = val),
            value: _showBorder,
          ),
          SwitchListTile(
            title: const Text('ShowBelowArea'),
            onChanged: (bool val) => setState(() => _showBelowArea = val),
            value: _showBelowArea,
          ),
          SwitchListTile(
            title: const Text('ShowDot'),
            onChanged: (bool val) => setState(() => _showDot = val),
            value: _showDot,
          ),
        ],
      ),
    );
  }
}
