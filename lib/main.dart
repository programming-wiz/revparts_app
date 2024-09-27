import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:untitled/providers/cart_provider.dart';  // Import the CartProvider
import 'screens/login_screen.dart';  // Import the LoginScreen
import 'screens/home_screen.dart';   // Import the HomePage class

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => CartProvider()),  // Provide cart state
      ],
      child: RevPartsApp(),
    ),
  );
}

class RevPartsApp extends StatefulWidget {
  @override
  _RevPartsAppState createState() => _RevPartsAppState();
}

class _RevPartsAppState extends State<RevPartsApp> {
  bool isDarkMode = false;  // Track dark mode state

  // Toggle between dark and light mode
  void toggleTheme() {
    setState(() {
      isDarkMode = !isDarkMode;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'RevParts',
      debugShowCheckedModeBanner: false,
      theme: ThemeData.light(),
      darkTheme: ThemeData.dark(),
      themeMode: isDarkMode ? ThemeMode.dark : ThemeMode.light,  // Set theme based on state
      home: LoginScreen(  // Start with the LoginScreen
        isDarkMode: isDarkMode,
        toggleTheme: toggleTheme,
      ),
    );
  }
}
