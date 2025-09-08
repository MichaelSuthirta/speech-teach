import 'package:flutter/material.dart';
import 'package:speech_teach/UI/Displays/ResultDisplayer.dart';
import '/Tools/BackendConnector.dart';
import '/Scaffold/AppScaffold.dart';
import '/UI/Texts/LargeText.dart';
import '/UI/Texts/SmallText.dart';
import '/UI/Buttons/RecordButton.dart';
import '/UI/Buttons/BoxedIconButton.dart';
import '/Tools/Recorder.dart';
import '/Tools/AudioProcessor.dart';

class PracticePage extends StatefulWidget{
  PracticePage({super.key});

  @override
  State<PracticePage> createState() => _PracticePageState();
}

class _PracticePageState extends State<PracticePage>{
  late String word = '';
  late String def = '';

  AudioProcessor processor = AudioProcessor();

  @override
  void initState(){
    super.initState();
    BackendConnector.fetchWords();
  }

  @override
  Widget build(BuildContext context){
    return AppScaffold(
        body: Column(
          children: [
            Container(
              alignment: Alignment.center,
              child: const SizedBox(
                width: 100,
                height: 100,
                child: Image(
                    image: AssetImage("assets/UI/Icons/BookIcon.png")
                ),
              )
            ),
            FutureBuilder<Map<String, dynamic>>(
                future: BackendConnector.fetchWords(), //Function to fetch data
                builder: (context, snapshot){
                  if(snapshot.hasData){
                    word = snapshot.data!['Word'];
                    def = snapshot.data!['Definition'];

                    Recorder.setFileName(word);
                    processor.setActualWord(word);
                    
                    return Column(
                      children:[
                        LargeText(word: word, size: 42),
                        SmallText(sentence: def, size: 20)
                      ]
                    );
                  }
                  else if(snapshot.hasError){
                    return Text("Error encountered in fetching data: ${snapshot.error}");
                  }
                  else{
                    return CircularProgressIndicator();
                  }
                }
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(15, 20, 15, 0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  RecordButton(processor: processor),
                  BoxedIconButton(
                    imagePath: "assets/UI/Buttons/RefreshButton.png",
                    size: 80,
                    onPress: (){
                      setState((){});
                      processor.resetResultContent();
                    },
                  )
                ],
              )
            ),
            ResultDisplayer(processor: processor)
          ],
        )
    );
  }
}