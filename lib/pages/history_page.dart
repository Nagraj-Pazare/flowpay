import 'package:flutter/material.dart';

class HistoryPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Usage History")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // Tabs (Daily, Weekly, etc.)
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: const [
                Text("Daily"),
                Text("Weekly", style: TextStyle(fontWeight: FontWeight.bold, color: Colors.blue)),
                Text("Monthly"),
                Text("Yearly"),
              ],
            ),
            const SizedBox(height: 20),
            // Dummy graph box
            Container(
              height: 150,
              color: Colors.blue.shade50,
              child: const Center(child: Text("Graph Here")),
            ),
            const SizedBox(height: 20),
            // Table
            Expanded(
              child: ListView(
                children: const [
                  ListTile(title: Text("8 Sep"), trailing: Text("150 L - ₹120")),
                  ListTile(title: Text("7 Sep"), trailing: Text("200 L - ₹160")),
                  ListTile(title: Text("6 Sep"), trailing: Text("180 L - ₹145")),
                  ListTile(title: Text("5 Sep"), trailing: Text("160 L - ₹135")),
                ],
              ),
            ),
            ElevatedButton.icon(
              onPressed: () {},
              icon: const Icon(Icons.download),
              label: const Text("Download"),
            ),
          ],
        ),
      ),
    );
  }
}
