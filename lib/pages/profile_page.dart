import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:umdb/pages/login_page.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  // Method used to delete the [isAuth] key from the shared prefs.
  Future<bool> _deleteAuthKey() async {
    final prefs = await SharedPreferences.getInstance();

    // The key-value is deleted using the remove method.
    final isKeyDeleted = prefs.remove('isAuth');

    // The result of the delete operation is returned.
    return isKeyDeleted;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile'),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(32),
          child: Row(
            children: [
              Expanded(
                child: ElevatedButton(
                  // On pressing the button the Auth key is deleted
                  // and is routed to the [LoginPage].
                  onPressed: () async {
                    final isDeleted = await _deleteAuthKey();

                    // Routing is done only after checking the result of
                    // delete operation and mounted property.
                    if (isDeleted && context.mounted) {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const LoginPage(),
                        ),
                      );
                    }
                  },
                  child: const Text('Logout'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
