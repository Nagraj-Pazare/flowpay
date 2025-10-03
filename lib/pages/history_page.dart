import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import '../services/firebase_service.dart';

class HistoryPage extends StatefulWidget {
  @override
  _HistoryPageState createState() => _HistoryPageState();
}

class _HistoryPageState extends State<HistoryPage> {
  final FirebaseService _firebaseService = FirebaseService();
  List<Map<String, dynamic>> _historyData = [];

  @override
  void initState() {
    super.initState();
    _loadHistoryData();
  }

  void _loadHistoryData() {
    _firebaseService.getHistoryData().listen((data) {
      if (mounted) {
        setState(() {
          _historyData = data;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("FlowPay")),
      body: _historyData.isEmpty
          ? const Center(child: CircularProgressIndicator())
          : DefaultTabController(
              length: 3,
              child: Column(
                children: [
                  const TabBar(
                    tabs: [
                      Tab(text: 'Daily'),
                      Tab(text: 'Weekly'),
                      Tab(text: 'Monthly'),
                    ],
                  ),
                  Expanded(
                    child: TabBarView(
                      children: [
                        _buildChart(_historyData, 'dailyConsumption', Colors.blue),
                        _buildChart(_historyData, 'weeklyConsumption', Colors.green),
                        _buildChart(_historyData, 'monthlyConsumption', Colors.orange),
                      ],
                    ),
                  ),
                ],
              ),
            ),
    );
  }

  Widget _buildChart(List<Map<String, dynamic>> data, String type, Color color) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          Text(
            "${type.replaceFirst(type[0], type[0].toUpperCase())} Consumption",
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 20),
          Expanded(
            child: LineChart(
              LineChartData(
                lineBarsData: [
                  LineChartBarData(
                    spots: data.asMap().entries.map((entry) {
                      return FlSpot(
                        entry.key.toDouble(),
                        entry.value[type]?.toDouble() ?? 0.0,
                      );
                    }).toList(),
                    isCurved: true,
                    color: color,
                    dotData: FlDotData(show: false),
                  ),
                ],
                titlesData: FlTitlesData(show: false),
                gridData: FlGridData(show: true),
                borderData: FlBorderData(show: false),
              ),
            ),
          ),
          const SizedBox(height: 20),
          _buildStats(data, type),
        ],
      ),
    );
  }

  Widget _buildStats(List<Map<String, dynamic>> data, String type) {
    if (data.isEmpty) return const SizedBox();
    
    final currentValue = data.last[type]?.toDouble() ?? 0.0;
    final maxValue = data.map((e) => e[type]?.toDouble() ?? 0.0).reduce((a, b) => a > b ? a : b);
    
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Column(
              children: [
                const Text('Current', style: TextStyle(color: Colors.grey)),
                Text('${currentValue.toStringAsFixed(1)} L', style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
              ],
            ),
            Column(
              children: [
                const Text('Max', style: TextStyle(color: Colors.grey)),
                Text('${maxValue.toStringAsFixed(1)} L', style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
              ],
            ),
            Column(
              children: [
                const Text('Bill', style: TextStyle(color: Colors.grey)),
                Text('₹${(currentValue * 0.7).toStringAsFixed(0)}', style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.green)),
              ],
            ),
          ],
        ),
      ),
    );
  }
}