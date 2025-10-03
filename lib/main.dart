import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'pages/main_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  try {
    await Firebase.initializeApp(
      options: const FirebaseOptions(
        apiKey: "AIzaSyDY9AwEd9WTKWnRhC5dWPFH_bk0e0DnmnM",
        appId: "1:228895343294:web:d8695fa1d8df577d417d56",
        messagingSenderId: "228895343294",
        projectId: "flowpay-prod",
        databaseURL: "https://flowpay-prod-default-rtdb.asia-southeast1.firebasedatabase.app/"
      ),
    );
    print('Firebase initialized successfully');
  } catch (e) {
    print('Error initializing Firebase: $e');
  }
  runApp(const App());
}

class App extends StatefulWidget {
  const App({super.key});

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: '',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MainScreen(),
    );
  }
}
