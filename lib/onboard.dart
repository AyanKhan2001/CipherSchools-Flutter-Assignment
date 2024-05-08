import 'package:cipherxexpense/signupscreen.dart';
import 'package:flutter/material.dart';

class OnboardingScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      extendBodyBehindAppBar: true,
      body: Stack(
        children: [
          Image.asset(
            'assets/images/bg.png',
            fit: BoxFit.cover,
            width: double.infinity,
            height: double.infinity,
          ),
          // Top-left image
          Positioned(
            top: 20,
            left: 20,
            child: Image.asset(
              'assets/images/logo.png',
              width: 60,
              height: 60,
            ),
          ),
          const Positioned(
            bottom: 170,
            left: 20,
            child: Text(
              'Welcome To',
              style: TextStyle(
                color: Colors.white,
                fontSize: 40,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          Positioned(
            bottom: 70,
            left: 10,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Image.asset(
                  'assets/images/CipherX.png',
                  width: 170,
                  height: 60,
                ),
                const Text(
                  'The best way to track your expenses.',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                const SizedBox(height: 15),
              ],
            ),
          ),
          Positioned(
            bottom: 110,
            right: 40,
            child: FloatingActionButton.large(
              backgroundColor: Color(0xBFECE1E1),
              onPressed: () {
                Navigator.of(context).pushReplacement(
                  MaterialPageRoute(builder: (_) => SignupScreen()),
                );
              },
              child: Icon(
                Icons.arrow_forward_ios_rounded,
                size: 65,
                color: Colors.black,
              ),
              shape: CircleBorder(
                side: BorderSide.none,
              ),
              elevation: 0,
            ),
          ),
        ],
      ),
    );
  }
}
