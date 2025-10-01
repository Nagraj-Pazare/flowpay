import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';

class UsagePage extends StatelessWidget {
  const UsagePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Water Usage"),
        backgroundColor: Colors.blue,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            const Text(
              "Daily / Weekly / Monthly Usage",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),

            // Bar Chart
            Expanded(
              child: BarChart(
                BarChartData(
                  alignment: BarChartAlignment.spaceAround,
                  maxY: 100,
                  barTouchData: BarTouchData(enabled: true),
                  titlesData: FlTitlesData(
                    leftTitles: AxisTitles(
                      sideTitles: SideTitles(showTitles: true),
                    ),
                    bottomTitles: AxisTitles(
                      sideTitles: SideTitles(
                        showTitles: true,
                        getTitlesWidget: (double value, TitleMeta meta) {
                          switch (value.toInt()) {
                            case 0:
                              return const Text("Mon");
                            case 1:
                              return const Text("Tue");
                            case 2:
                              return const Text("Wed");
                            case 3:
                              return const Text("Thu");
                            case 4:
                              return const Text("Fri");
                            case 5:
                              return const Text("Sat");
                            case 6:
                              return const Text("Sun");
                          }
                          return const Text("");
                        },
                      ),
                    ),
                  ),
                  gridData: FlGridData(show: false),
                  borderData: FlBorderData(show: false),
                  barGroups: [
                    BarChartGroupData(x: 0, barRods: [BarChartRodData(toY: 40, color: Colors.blue)]),
                    BarChartGroupData(x: 1, barRods: [BarChartRodData(toY: 55, color: Colors.blue)]),
                    BarChartGroupData(x: 2, barRods: [BarChartRodData(toY: 70, color: Colors.blue)]),
                    BarChartGroupData(x: 3, barRods: [BarChartRodData(toY: 30, color: Colors.blue)]),
                    BarChartGroupData(x: 4, barRods: [BarChartRodData(toY: 90, color: Colors.blue)]),
                    BarChartGroupData(x: 5, barRods: [BarChartRodData(toY: 65, color: Colors.blue)]),
                    BarChartGroupData(x: 6, barRods: [BarChartRodData(toY: 50, color: Colors.blue)]),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
