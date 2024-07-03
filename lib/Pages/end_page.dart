
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
import 'package:chewie/chewie.dart';

class EndPage extends StatefulWidget {
  final int count;

  const EndPage({Key? key, required this.count}) : super(key: key);

  @override
  _EndPageState createState() => _EndPageState();
}

class _EndPageState extends State<EndPage> with WidgetsBindingObserver{

  late VideoPlayerController videoPlayerController;
  ChewieController? chewieController;

  void initializeVideoPlayer() {
    videoPlayerController = VideoPlayerController.asset("assets/aphasia_video.mp4");

    videoPlayerController.initialize().then((_) {
      setState(() {
        chewieController = ChewieController(
          videoPlayerController: videoPlayerController,
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
  late String _patientStatus;

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
    _calculatePatientStatus();
  }


  void _calculatePatientStatus() {
    if (widget.count >= 100) {
      _patientStatus = "The Patient is Fully Independent.";
    } else if (widget.count >= 40 && widget.count < 100) {
      _patientStatus = "The Patient Needs Assistance.";
    } else {
      _patientStatus = "The Patient is Fully Dependent and Requires Full Assistance";
    }
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

return Scaffold(
appBar: AppBar(
  title: Center(
    child: Text(
      'Please Find Your Result Below'.toUpperCase(), // Convert text to all caps
      style: TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.bold, // Make the text bold
      ),
    ),
  ),
  elevation: 0,
),
      body: Stack(
        fit: StackFit.expand,
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
child: Padding(
  padding: const EdgeInsets.all(8.0),
  child: Center(
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            boxShadow: [
              BoxShadow(
                color: Color.fromARGB(255, 14, 119, 154).withOpacity(0.5),
                blurRadius: 5,
                offset: Offset(3, 3),
              ),
            ],
          ),
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Text(
              "The Final Score of the patient is: ${widget.count}",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
        SizedBox(height: 20),
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            boxShadow: [
              BoxShadow(
                color: Color.fromARGB(255, 0, 0, 0).withOpacity(0.3),
                blurRadius: 5,
                offset: Offset(3, 3),
              ),
            ],
          ),
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Text(
              _patientStatus,
              style: TextStyle(
                fontSize: 18,
                color: Color.fromARGB(255, 255, 255, 255),
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
          ),
        ),
      ],
    ),
  ),
),

          ),
        ],
      ),
    );
  }
}
