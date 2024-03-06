import 'package:dvmapp/home.dart';
import 'package:flutter/material.dart';
import 'package:dvmapp/content/pokeapi.dart';

class Splash extends StatefulWidget {
  const Splash({super.key});

  @override
  State<Splash> createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  @override
  void initState() {
    super.initState();
    _preFetchDataAndNavigate();
  }

  Future<void> _preFetchDataAndNavigate() async {
    try {
      PokeAPI.preFetchData();
      await Future.delayed(Duration(milliseconds: 2200), () {});
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => HomePage()),
      );
    } catch (error) {
      // Handle error if needed
      print('Error during data pre-fetching: $error');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: Container(
          child: Image.asset('assets/images/splash.gif'),
        ),
      ),
    );
  }
}
