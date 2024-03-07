import 'package:flutter/material.dart';
import 'package:fluttersupabase240303/services/auth_service.dart';
import 'package:provider/provider.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    final authService = Provider.of<AuthService>(context);
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Center(
            child: Text("profile"),
          ),
          TextButton(
              onPressed: () {
                authService.signOut();
              },
              child: const Text("out"))
        ],
      ),
    );
  }
}
