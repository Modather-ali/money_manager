import 'package:firebase_auth/firebase_auth.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import '../service/authentication.dart';
import '../service/cloud_firestore.dart';

class ChartScreen extends StatefulWidget {
  const ChartScreen({Key? key}) : super(key: key);

  @override
  _ChartScreenState createState() => _ChartScreenState();
}

class _ChartScreenState extends State<ChartScreen> {
  final CloudFirestore _cloudFirestore = CloudFirestore();
  final _outCome = <double, double>{};
  final _inCome = <double, double>{};
  Map<String, dynamic> statisticsData = {};
  bool _showIncome = true;
  bool _showOutcome = true;

  bool _showBelowArea = false;
  bool _showDot = true;
  Future getStatisticsData() async {
    List currantDateAsList = DateTime.now().toString().split(" ")[0].split("-");
    int todayNum = int.parse(currantDateAsList[2]);
    statisticsData = await _cloudFirestore.getStatisticsData();
    for (int i = 1; i <= todayNum; i++) {
      Map<String, dynamic> data = statisticsData[currantDateAsList[0] +
              "-" +
              currantDateAsList[1] +
              currantDateAsList[2]] ??
          {};
      double key = i.toDouble();
      // print(data);
      // if (data.isNotEmpty) {
      _outCome[1] = data["outcome"];
      _inCome[1] = data["income"];
      // } else {
      //   _outCome[key] = 0;
      //   _inCome[key] = 0;
      // }
    }

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final spots1 = <FlSpot>[
      for (final entry in _inCome.entries) FlSpot(entry.key, entry.value)
    ];
    final spots2 = <FlSpot>[
      for (final entry in _outCome.entries) FlSpot(entry.key, entry.value)
    ];

    final lineChartData = LineChartData(
      maxX: 31,
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
      child: FirebaseAuth.instance.currentUser == null
          ? _registrationUI()
          : Scaffold(
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
              floatingActionButton: FloatingActionButton(
                onPressed: () {
                  // Get.to(() => const AddScreen());
                  getStatisticsData();
                },
              ),
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

  Widget _registrationUI() {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: InkWell(
          onTap: () async {
            await Authentication().signInWithGoogle();
            // await Authentication().logOut();
            setState(() {});
          },
          child: Container(
            width: 150,
            height: 50,
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.shade300,
                  offset: const Offset(4, 4),
                  spreadRadius: 1,
                  blurRadius: 15,
                ),
                BoxShadow(
                  color: Colors.grey.shade200,
                  offset: const Offset(-4, -4),
                  spreadRadius: 1,
                  blurRadius: 15,
                ),
              ],
              image: const DecorationImage(
                image: AssetImage("assets/images/google_icon.png"),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
