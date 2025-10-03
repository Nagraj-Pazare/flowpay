import 'package:flutter/material.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import '../services/firebase_service.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final FirebaseService _firebaseService = FirebaseService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<Map<String, dynamic>>(
        stream: _firebaseService.getWaterData(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            print('Stream error: ${snapshot.error}');
            return Center(child: Text('Error: ${snapshot.error}'));
          }

          if (!snapshot.hasData) {
            return const Center(child: CircularProgressIndicator());
          }

          final data = snapshot.data!;
          print('Rendering data: $data');

          // Use a default target volume if not provided
          final targetVolume = 1000.0; // Default target in liters
          final currentVolume = data['totalVolume']?.toDouble() ?? 0.0;
          final progress = (currentVolume / targetVolume).clamp(0.0, 1.0);
          final isFlowing = (data['flowRate']?.toDouble() ?? 0.0) > 0.1;
          final currentBill = data['mBill']?.toDouble() ?? 0.0;

          return SafeArea(
            child: Scaffold(
              backgroundColor: Colors.white,
              body: SingleChildScrollView(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Logo + Title
                    Row(
                      children: [
                        const Icon(Icons.water_drop, color: Colors.blue, size: 36),
                        const SizedBox(width: 8),
                        Text(
                          "",
                          style: TextStyle(
                            fontSize: 26,
                            fontWeight: FontWeight.bold,
                            color: Colors.blue.shade900,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 6),
                    const Text(
                      "Smart Water Flow & Billing System",
                      style: TextStyle(color: Colors.black54, fontSize: 14),
                    ),
                    const SizedBox(height: 20),

                    // Current Water Usage
                    Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                      elevation: 2,
                      child: Padding(
                        padding: const EdgeInsets.all(20),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            CircularPercentIndicator(
                              radius: 50.0,
                              lineWidth: 10.0,
                              percent: progress,
                              center: Text(
                                "${currentVolume.toStringAsFixed(1)} L",
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18,
                                ),
                                textAlign: TextAlign.center,
                              ),
                              progressColor: Colors.blue,
                              backgroundColor: Colors.grey.shade200,
                            ),
                            Column(
                              children: [
                                const Text(
                                  "Current Water\nUsage",
                                  style: TextStyle(
                                    fontSize: 16, 
                                    fontWeight: FontWeight.w500
                                  ),
                                ),
                                Text(
                                  "Target: ${targetVolume.toInt()} L",
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: Colors.grey[600],
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),

                    // Current Bill
                    Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                      elevation: 2,
                      child: ListTile(
                        title: const Text(
                          "Current Bill",
                          style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                        ),
                        trailing: Text(
                          "₹${currentBill.toStringAsFixed(2)}",
                          style: const TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Colors.black87),
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),

                    // Daily / Flow Row
                    Row(
                      children: [
                        Expanded(
                          child: Card(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(16),
                            ),
                            elevation: 2,
                            child: Padding(
                              padding: const EdgeInsets.all(20),
                              child: Column(
                                children: [
                                  const Icon(Icons.bar_chart, color: Colors.blue, size: 40),
                                  const SizedBox(height: 8),
                                  Text(
                                    "Daily: ${data['dailyConsumption']?.toStringAsFixed(1) ?? '0.0'} L",
                                    textAlign: TextAlign.center,
                                    style: const TextStyle(fontSize: 12),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        Expanded(
                          child: Card(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(16),
                            ),
                            elevation: 2,
                            child: Padding(
                              padding: const EdgeInsets.all(20),
                              child: Column(
                                children: [
                                  Icon(
                                    Icons.water, 
                                    color: isFlowing ? Colors.blue : Colors.grey, 
                                    size: 40
                                  ),
                                  const SizedBox(height: 8),
                                  Text(
                                    isFlowing ? "Live Flow\nON" : "No Flow\nOFF",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: isFlowing ? Colors.blue : Colors.grey,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),

                    // Flow Rate Display
                    Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                      elevation: 2,
                      child: ListTile(
                        leading: Icon(
                          Icons.speed,
                          color: isFlowing ? Colors.blue : Colors.grey,
                        ),
                        title: Text("Flow Rate"),
                        trailing: Text(
                          "${data['flowRate']?.toStringAsFixed(2) ?? '0.00'} L/min",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: isFlowing ? Colors.blue : Colors.grey,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        }
      ),
    );
  }
}