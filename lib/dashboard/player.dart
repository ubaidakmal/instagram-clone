import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:just_audio/just_audio.dart';
import 'package:marquee/marquee.dart';

class AudioPlayerScreen extends StatefulWidget {
  // ignore: prefer_typing_uninitialized_variables
  final audioData;
  final index;
   const AudioPlayerScreen({super.key, required this.audioData, required this.index});

  @override
  State<AudioPlayerScreen> createState() => _AudioPlayerScreenState();
}

class _AudioPlayerScreenState extends State<AudioPlayerScreen> {
  late AudioPlayer advanceAudioPlayer;
  @override
  void initState() {    
    advanceAudioPlayer =  AudioPlayer();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        automaticallyImplyLeading: false,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            IconButton(
                onPressed: () {
                  Get.back();
                },
                icon: const Icon(
                  Icons.arrow_drop_down_sharp,
                )),
            IconButton(onPressed: () {}, icon: const Icon(Icons.more_vert)),
          ],
        ),
      ),
      body: Padding(
        padding:
            const EdgeInsets.only(top: 15.0, left: 20, right: 20, bottom: 15),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                  height: 200,
                  width: 200,
                  decoration: BoxDecoration(
                      image:  DecorationImage(
                          image: AssetImage(widget.audioData[widget.index]['image'],),
                          fit: BoxFit.cover),
                      borderRadius: BorderRadius.circular(5))),
              const SizedBox(
                height: 15,
              ),
              SizedBox(
                height: 30,
                width: 250,
                child: Marquee(
                  text: widget.audioData[widget.index]['title'],
                  style:
                      const TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                  scrollAxis: Axis.horizontal,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  blankSpace: 20,
                  velocity: 100,
                  pauseAfterRound: const Duration(seconds: 1),
                  showFadingOnlyWhenScrolling: true,
                  fadingEdgeStartFraction: 0.1,
                  fadingEdgeEndFraction: 0.1,
                  numberOfRounds: null,
                  startPadding: 10,
                  accelerationDuration: const Duration(milliseconds: 100),
                  accelerationCurve: Curves.linear,
                  decelerationDuration: const Duration(milliseconds: 1000),
                  decelerationCurve: Curves.easeOut,
                ),
              ),
              const SizedBox(height: 5,),
               Text(widget.audioData[widget.index]['artist'],),
              const SizedBox(height: 15,),
              AudioPlayerFile(advanceAudioPlayer: advanceAudioPlayer, audioPath:widget.audioData[widget.index]['audio']),
            ],
          ),
        ),
      ),
    );
  }
}
// ignore: must_be_immutable
class AudioPlayerFile extends StatefulWidget {
  final AudioPlayer advanceAudioPlayer;
  final String audioPath;
   AudioPlayerFile({super.key, required this.advanceAudioPlayer, required this.audioPath});

  @override
  State<AudioPlayerFile> createState() => _AudioPlayerFileState();
}

class _AudioPlayerFileState extends State<AudioPlayerFile> {
  Duration _duration = Duration();
  Duration _position = Duration();
  final String path="https://s3.amazonaws.com/scifri-episodes/scifri20181123-episode.mp3";
  bool isPlaying = false;
  bool isPasued = false;
  bool isLoop = false;
  bool isRepeat= false;
  Color color=Colors.white;
  final List<IconData>_icons =[
    Icons.play_circle_fill,
    Icons.pause_circle_filled,
  ];
  // @override
  // void initState() {
  //   // ignore: unnecessary_this
  //   this.widget.advanceAudioPlayer.onDurationChanged.listen((d){setState(() {
  //     _duration = d;
  //   });});
  //   // ignore: unnecessary_this
  //   this.widget.advanceAudioPlayer.onPositionChanged.listen((p){setState(() {
  //     _position = p;
  //   });});
  //   // ignore: unnecessary_this
  //   widget.advanceAudioPlayer.setSourceUrl(widget.audioPath);
  //   widget.advanceAudioPlayer.onPlayerComplete.listen((event) { 
  //     setState(() {
  //       _position = const Duration(seconds: 0);
  //       if(isRepeat==true)
  //       {
  //         isPlaying=true;
  //       }else {
  //       isPlaying=false;
  //       isRepeat=false;}
  //     });
  //    });
  //   super.initState();
  // }
  Widget buttonFast(){
    return IconButton(onPressed: (){
      // widget.advanceAudioPlayer.setPlaybackRate(5);
    }, icon: const Icon(FontAwesomeIcons.forwardStep,size: 20,));
  }
  Widget buttonSlow(){
    return IconButton(onPressed: (){
      // widget.advanceAudioPlayer.setPlaybackRate(5);
    
    }, icon: const Icon(FontAwesomeIcons.backwardStep,size:20));
  }
  Widget buttonRepeat(){
    return IconButton(onPressed: (){
      if(isRepeat==false)
      {
        // /// });
      }
      else if(isRepeat==true)
      {
      //  widget.advanceAudioPlayer.setReleaseMode(ReleaseMode.release);
       color=Colors.white;
       isRepeat=false;
      }
    }, icon: Icon(Icons.repeat,size: 20,color: color,));
  }
  Widget buttonLoop(){
    return IconButton(onPressed: (){}, icon: const Icon(Icons.loop, size: 20,));
  }
  Widget buttonStart(){
    return IconButton(
      padding: const EdgeInsets.only(bottom: 10),
      onPressed: ()async{
        if(isPlaying == false)
        {
       await widget.advanceAudioPlayer.setAudioSource(AudioSource.uri(Uri.parse(
          "https://s3.amazonaws.com/scifri-episodes/scifri20181123-episode.mp3")));
          widget.advanceAudioPlayer.play();
          
        setState(() {
          isPlaying=true;
        });
        }
        else if(isPlaying==true)
        {
          widget.advanceAudioPlayer.pause();
          setState(() {
            isPlaying = false;
          });
        }
      }, icon:isPlaying==false?Icon(_icons[0],size: 40,):Icon(_icons[1],size: 40));
  }
  Widget loadAsset(){
    return SizedBox(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          buttonRepeat(),
          buttonSlow(),
          buttonStart(),
          buttonFast(),
          buttonLoop(),
        ],
      ),
    );
  }

  Widget slider(){
    return Slider(
      activeColor: Colors.white,
      inactiveColor: Colors.grey,
      value:_position.inSeconds.toDouble(),
      min: 0.0,
      max: _duration.inSeconds.toDouble(),
      onChanged: (double value){
        setState(() {
          changeToSecond(value.toInt());
          value = value;
        });
      },
    );
  }
  void changeToSecond(int second){
    Duration newDuration = Duration(seconds: second);
    this.widget.advanceAudioPlayer.seek(newDuration);
  }
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Column(
        children: [
          Padding(padding: const EdgeInsets.only(left:12,right:12),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(_position.toString().split(".")[0]),
              Text(_duration.toString().split(".")[0]),
            ],
          ),
          ),
          loadAsset(),
          slider(),
        ],
      ),
    );
  }
}