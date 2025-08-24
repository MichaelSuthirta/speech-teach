import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MainMenuButton extends StatelessWidget{
  final String bgPath = "assets/UI/Buttons/MainMenuBtn.png";
  final String iconPath;
  final String text;
  final VoidCallback? onPress;

  const MainMenuButton({
    super.key,
    this.onPress,
    required this.iconPath,
    required this.text,
  });

  @override
  Widget build(BuildContext context){
    return Expanded(
      child: Flex(
        direction: Axis.vertical,
        children: [
          Ink.image(
            image: AssetImage(bgPath),
            fit: BoxFit.fitWidth,
            height: 152,
            child:
              InkWell(
                onTap: onPress,
                borderRadius: BorderRadius.circular(25),
                splashColor: const Color.fromRGBO(243, 91, 4, 1.0).withOpacity(0.3),
                child: Padding(
                padding: EdgeInsets.fromLTRB(20, 0, 0, 60),
                child: Row(
                  children: [
                    Container(
                      padding: EdgeInsets.fromLTRB(0, 0, 3, 0),
                      child: Image(
                        image: AssetImage(iconPath),
                        width: 50,
                        height: 50
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.fromLTRB(11, 0, 0, 10),
                      child: Text(
                        text,
                        style: const TextStyle(
                          fontFamily: "Concert One",
                          fontSize: 25,
                          color: Color.fromRGBO(255, 251, 241, 1.0),
                        ),
                      ),
                    ),
                  ],
                  )
                )
                )
          )
        ],
      )
    );
  }
}