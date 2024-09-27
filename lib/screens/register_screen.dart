import 'package:flutter/material.dart';
import 'login_screen.dart';  // Import the login screen

class RegisterScreen extends StatelessWidget {
  final bool isDarkMode;
  final VoidCallback toggleTheme;

  // Add isDarkMode and toggleTheme to allow dark/light mode toggle
  RegisterScreen({required this.isDarkMode, required this.toggleTheme});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Register'),
        actions: [
          IconButton(
            icon: Icon(isDarkMode ? Icons.dark_mode : Icons.light_mode),
            onPressed: toggleTheme,  // Toggle dark/light mode
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            TextField(
              decoration: InputDecoration(
                labelText: 'Name',
              ),
            ),
            SizedBox(height: 16),
            TextField(
              decoration: InputDecoration(
                labelText: 'Email',
                hintText: 'example@gmail.com',
              ),
              keyboardType: TextInputType.emailAddress,
            ),
            SizedBox(height: 16),
            TextField(
              decoration: InputDecoration(
                labelText: 'Password',
              ),
              obscureText: true,
            ),
            SizedBox(height: 24),
            ElevatedButton(
              onPressed: () {
                // Handle registration logic here
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => LoginScreen(
                      isDarkMode: isDarkMode,      // Pass dark mode state to LoginScreen
                      toggleTheme: toggleTheme,    // Pass toggle function to LoginScreen
                    ),
                  ),
                );
              },
              child: Text('Register'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red,  // Use backgroundColor instead of primary
                padding: EdgeInsets.symmetric(horizontal: 100, vertical: 15),
                textStyle: TextStyle(fontSize: 18),
              ),
            ),
            SizedBox(height: 16),
            TextButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => LoginScreen(
                      isDarkMode: isDarkMode,      // Pass dark mode state to LoginScreen
                      toggleTheme: toggleTheme,    // Pass toggle function to LoginScreen
                    ),
                  ),
                );
              },
              child: Text(
                'Login Here',
                style: TextStyle(color: Colors.red),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
