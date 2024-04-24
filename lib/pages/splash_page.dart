import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:umdb/pages/dashboard_page.dart';
import 'package:umdb/pages/login_page.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  // This method checks if the app is authenticated or not.
  // Based on the result page will be routed to
  // [LoginPage] or [DashboardPage] using the [Navigator].
  // The method is `async` since the `await` keyword is used inside.
  void _checkIfAuthenticated() async {
    // Loads the shared preferences.
    final prefs = await SharedPreferences.getInstance();

    // Get the value of the provided key from the storage.
    final isAuthenticated = prefs.getBool('isAuth');

    // Needs to check if the widget is still present
    // in the widget tree after an async gap.
    // It is done to ensure that the widget is still visible.
    if (mounted) {
      // Null value is checked and defaults to false if null.
      if (isAuthenticated ?? false) {
        // If authenticated, navigate to dashboard page.
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const DashboardPage()),
        );
      } else {
        // If not authenticated, navigate to login page.
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const LoginPage()),
        );
      }
    }
  }

  @override
  void initState() {
    super.initState();

    // The splash page waits for 2 seconds and the [_checkIfAuthenticated]
    // method is executed to check if the app is in authenticated state.
    Future.delayed(const Duration(seconds: 2), () => _checkIfAuthenticated());
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      // During the check for authentication, the [Splash Page]
      // with show a [CircularProgressIndicator] at the center.
      body: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}
