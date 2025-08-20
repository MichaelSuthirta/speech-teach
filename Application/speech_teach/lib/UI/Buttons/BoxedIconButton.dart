import 'package:flutter/material.dart';

class BoxedIconButton extends StatelessWidget{
  final String imagePath;
  final double size;
  final VoidCallback? onPress;

  const BoxedIconButton({
    super.key,
    required this.imagePath,
    required this.size,
    this.onPress
  });

  @override
  Widget build(BuildContext context){
    return SizedBox(
      height: size,
      width: size,
      child: IconButton(
        onPressed: onPress,
        icon: Image(image: AssetImage(imagePath)),
      )
    );
  }
}