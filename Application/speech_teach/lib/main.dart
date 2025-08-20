import 'package:flutter/material.dart';
import 'package:speech_teach/Pages/PracticePage.dart';
import 'Scaffold/AppScaffold.dart';
import 'UI/Buttons/MainMenuButton.dart';

void main() {
  runApp(const Application());
}

class Application extends StatelessWidget {
  const Application({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'SpeechTeach',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const HomePage(title: 'Home Page'),
      debugShowCheckedModeBanner: false,
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key, required this.title});
  final String title;

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      body: Column(
        children: [
          Container(
            child: MainMenuButton(
              iconPath: "assets/UI/Icons/SpeechIcon.png",
              text: "Start practicing",
              onPress: (){
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const PracticePage()
                  )
                );
              },
            ),
          )
        ],
      ),
    );
  }
}
