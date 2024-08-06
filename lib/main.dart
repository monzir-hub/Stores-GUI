import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sqlite_flutter_crud/database.dart';
import 'package:sqlite_flutter_crud/login.dart'; // Login page
import 'package:sqlite_flutter_crud/home_screen.dart'; // Home screen

// Main function to initialize and run the app
void main() async {
  WidgetsFlutterBinding.ensureInitialized(); // Ensure Flutter is ready
  Bloc.observer = MyBlocObserver(); // Set global observer for Bloc
  runApp(MyApp()); // Start the Flutter app with MyApp
}

// MyApp class, the main widget of the application
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => cubit_App() // Create Bloc/Cubit instance
        ..create_data() // Initialize data
        ..get_postion(), // Get position (if needed)
      child: MaterialApp(
        debugShowCheckedModeBanner: false, // Hide debug banner
        initialRoute: '/login', // Set initial route to login
        routes: { // Define named routes for navigation
          '/login': (context) => login(), // Login screen
          '/home': (context) => home_screen(), // Home screen
        },
      ),
    );
  }
}
