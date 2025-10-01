import 'package:flutter/material.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
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
                    "AquaBill",
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
                        percent: 0.65,
                        center: const Text(
                          "650\nL",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        progressColor: Colors.blue,
                        backgroundColor: Colors.grey.shade200,
                      ),
                      const Text(
                        "Current Water\nUsage",
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.w500),
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
                child: const ListTile(
                  title: Text(
                    "Current Bill",
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                  ),
                  trailing: Text(
                    "₹580",
                    style: TextStyle(
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
                          children: const [
                            Icon(Icons.bar_chart, color: Colors.blue, size: 40),
                            SizedBox(height: 8),
                            Text("Daily/Weekly/\nMonthly",
                                textAlign: TextAlign.center),
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
                          children: const [
                            Icon(Icons.water, color: Colors.blue, size: 40),
                            SizedBox(height: 8),
                            Text("Live Flow\nON",
                                textAlign: TextAlign.center,
                                style: TextStyle(fontWeight: FontWeight.bold)),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),

              // Notifications
              Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
                elevation: 2,
                child: const ListTile(
                  leading: Icon(Icons.notifications, color: Colors.blue),
                  title: Text("Notifications"),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
