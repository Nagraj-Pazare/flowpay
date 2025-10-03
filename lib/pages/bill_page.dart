import 'package:flutter/material.dart';
import '../services/firebase_service.dart';

class BillPage extends StatefulWidget {
  @override
  _BillPageState createState() => _BillPageState();
}

class _BillPageState extends State<BillPage> {
  final FirebaseService _firebaseService = FirebaseService();

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<Map<String, dynamic>>(
      stream: _firebaseService.getWaterData(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Scaffold(
            appBar: AppBar(title: const Text("FlowPay")),
            body: const Center(child: CircularProgressIndicator()),
          );
        }

        if (snapshot.hasError) {
          return Scaffold(
            appBar: AppBar(title: const Text("FlowPay")),
            body: Center(child: Text('Error: ${snapshot.error}')),
          );
        }

        if (!snapshot.hasData) {
          return Scaffold(
            appBar: AppBar(title: const Text("FlowPay")),
            body: const Center(child: Text('No data available')),
          );
        }

        final data = snapshot.data!;
        final currentBill = data['mBill']?.toDouble() ?? 0.0;
        final monthlyConsumption = data['monthlyConsumption']?.toDouble() ?? 0.0;

        return Scaffold(
          appBar: AppBar(title: const Text("")),
          body: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text("Current Bill", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                const SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("₹${currentBill.toStringAsFixed(0)}", style: const TextStyle(fontSize: 28, fontWeight: FontWeight.bold)),
                    ElevatedButton(onPressed: () {}, child: const Text("Pay")),
                  ],
                ),
                const SizedBox(height: 10),
                Text("Monthly Usage: ${monthlyConsumption.toStringAsFixed(1)} L", style: TextStyle(color: Colors.grey[600])),
                const SizedBox(height: 5),
                Text("Rate: ₹0.70 per liter", style: TextStyle(color: Colors.green[700], fontWeight: FontWeight.bold)),
                const SizedBox(height: 30),
                const Text("Billing History", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                const SizedBox(height: 10),
                const ListTile(title: Text("June 2025"), trailing: Text("₹155")),
              ],
            ),
          ),
        );
      }
    );
  }
}