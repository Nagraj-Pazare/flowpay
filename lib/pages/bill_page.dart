import 'package:flutter/material.dart';

class BillPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("AquaBill")),
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
                const Text("₹1,520", style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold)),
                ElevatedButton(onPressed: () {}, child: const Text("Pay")),
              ],
            ),
            const SizedBox(height: 30),
            const Text("Billing History", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 10),
            const ListTile(title: Text("July 2022"), trailing: Text("₹1,480")),
            const ListTile(title: Text("June 2022"), trailing: Text("₹1,560")),
            const ListTile(title: Text("May 2022"), trailing: Text("₹1,630")),
            const ListTile(title: Text("April 2022"), trailing: Text("₹1,500")),
          ],
        ),
      ),
    );
  }
}
