import 'package:flutter/material.dart';
// import 'package:project_aphasia/Pages/home_page.dart';
import 'package:project_aphasia/Pages/welcome_page.dart';



void main() {
  runApp( MyApp());
}

// void main() {
//   runApp(MaterialApp(   
//     home: HomePage(),
//   ));
// }
class MyApp extends StatelessWidget {



  @override
  const MyApp({super.key});


  @override


  Widget build(BuildContext context) 
  {
    return  MaterialApp
    (
      home:  WelcomePage(),
      theme: ThemeData.dark(),

    );
  
  
  }
}
// import 'package:flutter/material.dart';
// import 'package:project_aphasia/Pages/home_page.dart';
// import 'package:project_aphasia/Pages/welcome_page.dart'; // Ensure this path is correct

// void main() {
//   runApp(MyApp());
// }

// class MyApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       home:  WelcomePage(),
//        theme: ThemeData.dark(),
//     );
//   }
// }




