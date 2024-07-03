import 'package:flutter/material.dart';
import 'package:project_aphasia/Pages/home_page.dart';

class WelcomePage extends StatefulWidget {
  const WelcomePage({super.key});

  @override
  _WelcomePageState createState() => _WelcomePageState();
}

class _WelcomePageState extends State<WelcomePage>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: Duration(seconds: 2), // Animation duration
      vsync: this,
    );
    _animation = CurvedAnimation(
      parent: _controller,
      curve: Curves.easeInOut,
    );
    _controller.forward(); // Start the animation
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(35, 0, 47, 1), // Therapy-related background color
      body: Center(
        child: FadeTransition(
          opacity: _animation,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: const [
              Text(
                'FIM',
                style: TextStyle(
                    fontSize: 55,
                    fontWeight: FontWeight.bold,
                     color:Color.fromARGB(255, 179, 161, 83)),
              ),
              Text(
                'EVALUATION',
                style: TextStyle(
                    fontSize: 45,
                    fontWeight: FontWeight.bold,
                    color:Color.fromARGB(255, 179, 161, 83)),
              ),
              Text(
                'FOR',
                style: TextStyle(
                    fontSize: 50,
                    fontWeight: FontWeight.bold,
                    color:Color.fromARGB(255, 179, 161, 83)),
              ),
              Text(
                'APHASIA PATIENTS',
                style: TextStyle(
                    fontSize: 38,
                    fontWeight: FontWeight.bold,
                  color:Color.fromARGB(255, 179, 161, 83)),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => HomePage()),
          );
        },
        backgroundColor: Color.fromARGB(255, 122, 27, 146), // Therapy-related button color
        child: Icon(Icons.arrow_forward),
      ),
      floatingActionButtonLocation:
          FloatingActionButtonLocation.endFloat, // Position
    );
  }
}