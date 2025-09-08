import 'package:flutter/material.dart';
import 'package:speech_teach/Tools/AudioProcessor.dart';

class RefreshButton extends StatelessWidget{
  final double size;
  final VoidCallback? onPress;
  final AudioProcessor processor;

  const RefreshButton({
    super.key,
    required this.size,
    required this.processor,
    this.onPress
  });

  @override
  Widget build(BuildContext context){
    return ListenableBuilder(
        listenable: processor,
        builder: (BuildContext context, Widget? child){
          String iconPath;

          var result = processor.getResult();
          if(result['Assessment Result'] == 1){
            iconPath = "assets/UI/Buttons/NextButton.png";
          }
          else{
            iconPath = "assets/UI/Buttons/RefreshButton.png";
          }

          return SizedBox(
              height: size,
              width: size,
              child: IconButton(
                onPressed: onPress,
                icon: Image(image: AssetImage(iconPath)),
              )
          );
        }
    );
  }
}