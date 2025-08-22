import 'package:flutter/material.dart';
import '/Tools/WordFetcher.dart';
import '/Scaffold/AppScaffold.dart';
import '/UI/Words/WordDisplay.dart';
import '/UI/Words/DefinitionDisplay.dart';
import '/UI/Buttons/RecordButton.dart';
import '/UI/Buttons/BoxedIconButton.dart';
import '/Tools/Recorder.dart';

class PracticePage extends StatefulWidget{
  final Recorder recorder = Recorder();
  PracticePage({super.key});

  @override
  State<PracticePage> createState() => _PracticePageState();
}

class _PracticePageState extends State<PracticePage>{
  late String word = '';
  late String def = '';

  @override
  void initState(){
    super.initState();
    fetchWords();
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
                future: fetchWords(), //Function to fetch data
                builder: (context, snapshot){
                  if(snapshot.hasData){
                    word = snapshot.data!['Word'];
                    def = snapshot.data!['Definition'];

                    widget.recorder.setFileName(word);
                    
                    return Column(
                      children:[
                        WordDisplay(word: word),
                        DefinitionDisplay(sentence: def)
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
                  RecordButton(recorder: widget.recorder),
                  BoxedIconButton(
                    imagePath: "assets/UI/Icons/RefreshButton.png",
                    size: 120,
                    onPress: (){
                      setState((){});
                    },
                  )
                ],
              )
            )
          ],
        )
    );
  }
}