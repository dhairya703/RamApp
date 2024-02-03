

import 'package:audio_session/audio_session.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:just_audio/just_audio.dart';
import 'package:lottie/lottie.dart';
import 'package:ramram/views/common.dart';
import 'package:rxdart/rxdart.dart';

class Song {
  final String title;
  final String singer;
  final String assetPath;

  Song({required this.title, required this.assetPath,required this.singer});
}

class MediaPage extends StatefulWidget {
  const MediaPage({Key? key}) : super(key: key);

  @override
  MediaPageState createState() => MediaPageState();
}

class MediaPageState extends State<MediaPage>
    with WidgetsBindingObserver {
  final List<Song> songs = [
    Song(
      singer: 'Swati Mishra',
      title: 'Ram aayenge',
      assetPath: 'assets/songs/bhajan1.mp3',
    ),
    Song(
      singer:'Pandit Sudhir Vyas ji',
      title: 'Yeh chammak yeh dhamak',
      assetPath: 'assets/songs/bhajan2.mp3',
    ),
    Song(
      singer:"Shri prembhushan ji",
      title: 'Humara sath shri raghunath',
      assetPath: 'assets/songs/bhajan3.mp3',
    ),
  ];

  late final AudioPlayer _player;

  @override
  void initState() {
    super.initState();
    ambiguate(WidgetsBinding.instance)!.addObserver(this);
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: Colors.black,
    ));
    _player = AudioPlayer();
    _init();
  }

  Future<void> _init() async {
    final session = await AudioSession.instance;
    await session.configure(const AudioSessionConfiguration.speech());

    _player.playbackEventStream.listen((event) {},
        onError: (Object e, StackTrace stackTrace) {
          print('A stream error occurred: $e');
        });

    try {
      await _player.setAudioSource(
        AudioSource.asset(songs[0].assetPath),
      );
    } catch (e) {
      print("Error loading audio source: $e");
    }
  }

  @override
  void dispose() {
    ambiguate(WidgetsBinding.instance)!.removeObserver(this);
    _player.dispose();
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.paused) {
      _player.stop();
    }
  }

  Stream<PositionData> get _positionDataStream =>
      Rx.combineLatest3<Duration, Duration, Duration?, PositionData>(
          _player.positionStream,
          _player.bufferedPositionStream,
          _player.durationStream,
              (position, bufferedPosition, duration) => PositionData(
              position, bufferedPosition, duration ?? Duration.zero));

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(leading: IconButton(
          icon:Icon(Icons.arrow_back_ios_new),
          onPressed: () {
        Navigator.pop(context);
        },
          ),
          title: Text("Bhajan Sarovar"),
        backgroundColor: Colors.orange,),
        body: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(padding: EdgeInsets.all(20),
                decoration: BoxDecoration(
                border: Border.all(
                  color: Colors.black,
                  width: 4.0,
                ),
              ),
                child: Lottie.network('https://lottie.host/2e116016-79dd-4d23-8789-b501aaffa78f/IUiTlwLbmS.json'),
              ),
              ControlButtons(_player),
              // Display seek bar.
              StreamBuilder<PositionData>(
                stream: _positionDataStream,
                builder: (context, snapshot) {
                  final positionData = snapshot.data;
                  return SeekBar(
                    duration: positionData?.duration ?? Duration.zero,
                    position: positionData?.position ?? Duration.zero,
                    bufferedPosition:
                    positionData?.bufferedPosition ?? Duration.zero,
                    onChangeEnd: _player.seek,
                  );
                },
              ),
              // Display song list with controls
              Expanded(
                child: ListView.builder(
                  itemCount: songs.length,
                  itemBuilder: (context, index) {
                    final song = songs[index];
                    return ListTile(
                      title: Text(song?.title ?? 'Unknown Title', style: TextStyle(fontWeight: FontWeight.bold)),
                      trailing: Text(song?.singer ?? 'Unknown Singer', style: TextStyle(fontWeight: FontWeight.bold)),
                      onTap: () async {
                        if (song != null && song.assetPath != null) {
                          await _player.setAudioSource(
                            AudioSource.asset(song.assetPath),
                          );
                          _player.play();
                        }
                      },
                    );

                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class ControlButtons extends StatelessWidget {
  final AudioPlayer player;

  const ControlButtons(this.player, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        IconButton(
          icon: const Icon(Icons.volume_up),
          onPressed: () {
            showSliderDialog(
              context: context,
              title: "Adjust volume",
              divisions: 10,
              min: 0.0,
              max: 1.0,
              value: player.volume,
              stream: player.volumeStream,
              onChanged: player.setVolume,
            );
          },
        ),
        StreamBuilder<PlayerState>(
          stream: player.playerStateStream,
          builder: (context, snapshot) {
            final playerState = snapshot.data;
            final processingState = playerState?.processingState;
            final playing = playerState?.playing;
            if (processingState == ProcessingState.loading ||
                processingState == ProcessingState.buffering) {
              return Container(
                margin: const EdgeInsets.all(8.0),
                width: 64.0,
                height: 64.0,
                child: const CircularProgressIndicator(),
              );
            } else if (playing != true) {
              return IconButton(
                icon: const Icon(Icons.play_arrow),
                iconSize: 64.0,
                onPressed: player.play,
              );
            } else if (processingState != ProcessingState.completed) {
              return IconButton(
                icon: const Icon(Icons.pause),
                iconSize: 64.0,
                onPressed: player.pause,
              );
            } else {
              return IconButton(
                icon: const Icon(Icons.replay),
                iconSize: 64.0,
                onPressed: () => player.seek(Duration.zero),
              );
            }
          },
        ),
        StreamBuilder<double>(
          stream: player.speedStream,
          builder: (context, snapshot) => IconButton(
            icon: Text("${snapshot.data?.toStringAsFixed(1)}x",
                style: const TextStyle(fontWeight: FontWeight.bold)),
            onPressed: () {
              showSliderDialog(
                context: context,
                title: "Adjust speed",
                divisions: 10,
                min: 0.5,
                max: 1.5,
                value: player.speed,
                stream: player.speedStream,
                onChanged: player.setSpeed,
              );
            },
          ),
        ),
      ],
    );
  }
}

class PositionData {
  final Duration position;
  final Duration bufferedPosition;
  final Duration duration;

  PositionData(this.position, this.bufferedPosition, this.duration);
}
