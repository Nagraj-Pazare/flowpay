import 'package:firebase_database/firebase_database.dart';

class FirebaseService {
  final DatabaseReference _database = FirebaseDatabase.instance.ref();

  // Stream for getting all water flow data
  Stream<Map<String, dynamic>> getWaterData() {
    return _database.child('data').limitToLast(1).onValue.map((event) {
      final data = event.snapshot.value as Map<dynamic, dynamic>?;
      if (data == null) return {};

      final lastEntry = data.values.last as Map<dynamic, dynamic>;
      return {
        'flowRate': lastEntry['flowRate']?.toDouble() ?? 0.0,
        'totalVolume': lastEntry['totalVolume']?.toDouble() ?? 0.0,
        'progressPercentage': lastEntry['progressPercentage']?.toDouble() ?? 0.0,
        'dailyConsumption': lastEntry['dailyConsumption']?.toDouble() ?? 0.0,
        'weeklyConsumption': lastEntry['weeklyConsumption']?.toDouble() ?? 0.0,
        'monthlyConsumption': lastEntry['monthlyConsumption']?.toDouble() ?? 0.0,
        'mBill': lastEntry['mBill']?.toDouble() ?? 0.0,
        'relayStatus': lastEntry['relayStatus'] ?? false,
        'alarmStatus': lastEntry['alarmStatus'] ?? false,
      };
    });
  }

  // Stream for getting historical data - FIXED VERSION
  Stream<List<Map<String, dynamic>>> getHistoryData() {
    return _database.child('data').orderByKey().limitToLast(20).onValue.map((event) {
      final data = event.snapshot.value as Map<dynamic, dynamic>?;
      if (data == null) return [];

      List<Map<String, dynamic>> historyList = [];
      
      data.forEach((key, value) {
        if (value != null) {
          final entry = value as Map<dynamic, dynamic>;
          historyList.add({
            'timestamp': entry['timestamp'] ?? 0,
            'totalVolume': entry['totalVolume']?.toDouble() ?? 0.0,
            'dailyConsumption': entry['dailyConsumption']?.toDouble() ?? 0.0,
            'weeklyConsumption': entry['weeklyConsumption']?.toDouble() ?? 0.0,
            'monthlyConsumption': entry['monthlyConsumption']?.toDouble() ?? 0.0,
            'mBill': entry['mBill']?.toDouble() ?? 0.0,
            'flowRate': entry['flowRate']?.toDouble() ?? 0.0,
          });
        }
      });

      // Sort by timestamp
      historyList.sort((a, b) => (a['timestamp'] ?? 0).compareTo(b['timestamp'] ?? 0));
      
      return historyList;
    });
  }
}