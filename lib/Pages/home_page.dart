import 'package:flutter/material.dart';
import 'end_page.dart';
import 'package:video_player/video_player.dart';
import 'package:chewie/chewie.dart';


class HomePage extends StatefulWidget {
   const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}



class _HomePageState extends State<HomePage> with WidgetsBindingObserver{


  late VideoPlayerController videoPlayerController;
  ChewieController? chewieController;

void initializeVideoPlayer() {
  videoPlayerController = VideoPlayerController.asset("assets/aphasia_video.mp4");

  videoPlayerController.initialize().then((_) {
    setState(() {
      chewieController = ChewieController(
        videoPlayerController: videoPlayerController,
        // aspectRatio:19/19,
        aspectRatio: videoPlayerController.value.aspectRatio,
        autoPlay: true,
        looping: true,
        autoInitialize: true,
        showControls: false,
      );
    });
  });
}

  @override
  void dispose() {
    videoPlayerController.dispose();
    chewieController?.dispose();
    super.dispose();
  }


  
  int count = 0;
  int questionIndex = 0;
  late List<String> questions;
  List<String> answers = [];

  @override
  void initState() {
    super.initState();
    initializeVideoPlayer();
    WidgetsBinding.instance.addObserver(this);

    videoPlayerController.initialize().then((_) {
      setState(() {});
    });

    chewieController = ChewieController(
      videoPlayerController: videoPlayerController,
      aspectRatio: 16 / 9,
      autoPlay: true,
      looping: true,
      autoInitialize: true,
      showControls: false,
    );

    questions = [
      "Can the patient eat on their own?",
      "Can the patient groom themselves (Brushing, combing hair etc)?",
      "Can the patient bathe by themselves?",
      "Can the patient dress their upper body themselves?",
      "Can the patient dress their lower body themselves?",
      "Can the patient use the toilet on their own?",
      "Can the patient control their bladder?",
      "Can the patient control their bowels?",
      "Can the patient transfer from bed to chair and vice versa?",
      "Can the patient transfer to and from a wheelchair?",
      "Can the patient walk with or without assistance?",
      "Can the patient climb stairs?",
      "Can the patient perform wheelchair mobility tasks (if applicable)?",
      "Can the patient move to the toilet/shower on their own?",
      "Can the patient express their needs verbally?",
      "Can the patient understand verbal instructions?",
      "Can the patient use alternative communication methods if necessary?",
      "Can the patient understand social signals?",
      "Can the patient interact appropriately with others?",
      "Can the patient make decisions independently?",
    ];
    answers = List.filled(questions.length, "");
  }

  void userAction(String answer) {
    setState(() {
      // Update the answer for the current question
      answers[questionIndex] = answer;
      // Update the score
      if (answer == "YES") {
        count += 7;
      } else if (answer == "ASSISTANCE REQUIRED") {
        count += 4;
      } else if (answer == "NO") {
        count += 1;
      }
      // Move to the next question or navigate to the end page if all questions answered
      if (questionIndex < questions.length - 1) {
        questionIndex++;
      } else {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => EndPage(count: count),
          ),
        );
      }
    });
  }

  void goBack() {
    setState(() {
      if (questionIndex > 0) {
        // Going back to the previous question
        questionIndex--;

        // Deducting score based on the previous answer
        String previousAnswer = answers[questionIndex];
        if (previousAnswer == "YES") {
          count -= 7;
        } else if (previousAnswer == "ASSISTANCE REQUIRED") {
          count -= 4;
        } else if (previousAnswer == "NO") {
          count -= 1;
        }
      }
    });
  }

  // @override
  // Widget build(BuildContext context) {
  //   return Scaffold(
  //     appBar: AppBar(
  //       title: Text('Home Page'),
  //     ),
  //     body: Center(
  //       child: videoPlayerController.value.isInitialized
  //           ? AspectRatio(
  //               aspectRatio: videoPlayerController.value.aspectRatio,
  //               child: Chewie(controller: chewieController!),
  //             )
  //           : CircularProgressIndicator(), // Show loading indicator while video is initializing
  //     ),
  //   );
  // }


  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: Colors.grey[900],
appBar: AppBar(
  title: Text(
    'Functional Independence Measure',
    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white),
  ),
  elevation: 0,
  centerTitle: true,
  backgroundColor: Color.fromARGB(255, 77, 0, 91), // Change the background color to purple
  actions: [
    IconButton(
      onPressed: () {},
      icon: Icon(Icons.logout, color: Colors.white),
    )
  ],
),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Color.fromARGB(255, 63, 0, 74),
        selectedItemColor: Colors.white,
        unselectedItemColor: Colors.grey,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: 'Settings',
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: Icon(Icons.navigate_next),
      ),
body: Stack(
  fit: StackFit.expand, // Ensure the stack covers the entire screen
  children: [
    // Video Player
    Center(
      child: videoPlayerController.value.isInitialized
          ? AspectRatio(
              // aspectRatio: videoPlayerController.value.aspectRatio,
              aspectRatio: screenWidth / screenHeight,
              child: Chewie(controller: chewieController!),
            )
          : CircularProgressIndicator(),
    ),

    // Text Content
    Positioned(
      left: 0,
      top: 0,
      right: 0,
      bottom: 0,
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            SizedBox(height: 20),
            AnimatedContainer(
              duration: Duration(milliseconds: 500),
              curve: Curves.easeInOut,
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Card(
                elevation: 3,
  
                color: Color.fromARGB(255, 131, 118, 59),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Text(
                    questions.isNotEmpty ? questions[questionIndex] : "",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
            ),
            SizedBox(height: 30),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton(
                    onPressed: () => userAction("YES"),
                    child: Text("YES"),
                  ),
                  ElevatedButton(
                    onPressed: () => userAction("ASSISTANCE REQUIRED"),
                    child: Text("ASSISTANCE"),
                  ),
                  ElevatedButton(
                    onPressed: () => userAction("NO"),
                    child: Text("NO"),
                  ),
                ],
              ),
            ),
            SizedBox(height: 425),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      IconButton(
                        onPressed: goBack,
                        icon: Icon(Icons.arrow_back, color: Color.fromARGB(255, 255, 255, 255)),
                      ),

                      // ),
                    ],
                  ),
                ],
              ),
            ),
            // SizedBox(height: 380),
            Container(  child: Center(
              child: Text(
                          "YOUR CURRENT SCORE IS $count",
                          style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                            color:Color.fromARGB(255, 179, 161, 83),
                          )),
            ))
          ],
        ),
      ),
    ),
  ],
),


    );
  }
}