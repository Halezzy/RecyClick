import 'dart:async';
import 'package:flutter/material.dart';
import 'login_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Timer(const Duration(seconds: 3), () {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (_) => const LoginScreen()),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.green[100],
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Logo visual do Recyclick
            Image.asset(
              'assets/logo.png',
              height: 250,
              errorBuilder: (context, error, stackTrace) {
                return const Icon(Icons.recycling, size: 80, color: Colors.green);
              },
            ),
            const SizedBox(height: 20),
            Text(
              'Seu Point Ecológico',
              style: TextStyle(
                fontSize: 32,
                fontWeight: FontWeight.bold,
                color: Colors.green[900],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
