import 'package:flutter/material.dart';
import '../UI/Buttons/BoxedIconButton.dart';

class AppScaffold extends StatelessWidget{
  final Widget body;

  const AppScaffold({super.key, required this.body});

  @override
  Scaffold build(BuildContext context){
    return Scaffold(
      backgroundColor: const Color.fromRGBO(255, 251, 241, 1.0),
      appBar: AppBar(
        backgroundColor: const Color.fromRGBO(255, 251, 241, 1.0),
        toolbarHeight: 100,
        title:  Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              children: [
                Container(
                  padding: EdgeInsets.symmetric(vertical: 2),
                  child: const Text(
                    " SpeechTeach",
                    textAlign: TextAlign.left,
                    style: TextStyle(
                        fontSize: 40,
                        fontFamily: "Concert One",
                        color: Color.fromRGBO(61, 52, 139, 1.0)
                    ),
                  ),
                ),
                Container (
                  padding: const EdgeInsets.symmetric(vertical: 2),
                  child: const Text(
                      "Practice your speech",
                      textAlign: TextAlign.left,
                      style: TextStyle(
                          fontSize: 18,
                          fontFamily: "Consolas",
                          color: Color.fromRGBO(118, 120, 237, 1.0)
                      )
                  ),
                )
              ],
            ),
            BoxedIconButton(
              imagePath: "assets/UI/Icons/profileIconBtn.png",
              size: 80,
              onPress: (){},
            )
          ],
        )
      ),
      body: Container(
        padding: EdgeInsets.symmetric(vertical: 15, horizontal: 35),
        child: body
      )
    );
  }
}