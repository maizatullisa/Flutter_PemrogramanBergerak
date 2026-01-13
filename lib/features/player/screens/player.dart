import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';
import 'package:lottie/lottie.dart';
import 'package:meditation_app/features/home/model/recommendation_model.dart';

class PlayerScreen extends StatefulWidget {
  const PlayerScreen({super.key, required this.model});

  @override
  State<PlayerScreen> createState() => _PlayerScreenState();

  final RecommendationModel model;
}

class _PlayerScreenState extends State<PlayerScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _progress;
  late AudioPlayer _audioPlayer;

  final ValueNotifier<double> _player = ValueNotifier<double>(0);
  bool _isDark = false;
  bool _isPlaying = false;

  @override
  void initState() {
    super.initState();
    _audioPlayer = AudioPlayer();
    
    _controller = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );

    _progress = Tween<double>(begin: 0, end: 1).animate(_controller)
      ..addListener(() {
        setState(() {});
      });

    _controller.addListener(() {
      controllerListener();
    });

    _initializeAudio();
  }

  Future<void> _initializeAudio() async {
    try {
      await _audioPlayer.setAsset(widget.model.season);
      _audioPlayer.positionStream.listen((duration) {
        if (_audioPlayer.duration != null) {
          _player.value = duration.inMilliseconds / 
              _audioPlayer.duration!.inMilliseconds;
        }
      });
    } catch (e) {
      print('Error loading audio: $e');
    }
  }

  void controllerListener() {
    if (_controller.status == AnimationStatus.forward ||
        _controller.status == AnimationStatus.completed) {
      increasePlayer();
    }
  }

  increasePlayer() async {
    if (_controller.status == AnimationStatus.forward ||
        _controller.status == AnimationStatus.completed) {
      if ((_player.value + .0005) > 1) {
        _player.value = 1;
        _controller.reverse();
      } else {
        _player.value += .00005;
      }

      await Future.delayed(
        const Duration(milliseconds: 100),
      );
      if (_player.value < 1) {
        increasePlayer();
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      color: _isDark ? const Color(0xFF1A1A2E) : Colors.white,
      child: Scaffold(
        backgroundColor: _isDark
            ? const Color(0xFF1A1A2E)
            : widget.model.color.withOpacity(0.08),
        body: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            children: [
              const SizedBox(height: 60),
              // Header with back and theme toggle
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    decoration: BoxDecoration(
                      color: _isDark
                          ? Colors.white.withOpacity(0.1)
                          : widget.model.color.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: IconButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      icon: Icon(
                        Icons.arrow_back_ios_rounded,
                        color: _isDark
                            ? Colors.white
                            : widget.model.color.shade300,
                        size: 20,
                      ),
                    ),
                  ),
                  Container(
                    decoration: BoxDecoration(
                      color: _isDark
                          ? Colors.white.withOpacity(0.1)
                          : widget.model.color.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: IconButton(
                      onPressed: () {
                        setState(() {
                          _isDark = !_isDark;
                        });
                      },
                      icon: Icon(
                        _isDark
                            ? CupertinoIcons.sun_max_fill
                            : CupertinoIcons.moon_stars_fill,
                        color: _isDark
                            ? Colors.white
                            : widget.model.color.shade300,
                        size: 20,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 40),
              // Progress circle with animation
              SizedBox.square(
                dimension: MediaQuery.sizeOf(context).width - 80,
                child: Stack(
                  children: [
                    // Progress circle background
                    Positioned.fill(
                      child: Container(
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          gradient: LinearGradient(
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                            colors: [
                              widget.model.color.withOpacity(0.15),
                              widget.model.color.withOpacity(0.05),
                            ],
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: widget.model.color.withOpacity(0.2),
                              blurRadius: 30,
                              spreadRadius: 5,
                            ),
                          ],
                        ),
                      ),
                    ),
                    // Actual progress indicator
                    Positioned.fill(
                      left: 20,
                      top: 20,
                      bottom: 20,
                      right: 20,
                      child: ValueListenableBuilder(
                        valueListenable: _player,
                        builder: (context, value, _) {
                          return CircularProgressIndicator(
                            color: widget.model.color.shade300,
                            value: value,
                            strokeCap: StrokeCap.round,
                            strokeWidth: 12,
                            backgroundColor: _isDark
                                ? Colors.white.withOpacity(0.1)
                                : widget.model.color.withOpacity(0.15),
                          );
                        },
                      ),
                    ),
                    // Center animation
                    Center(
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(1000),
                        child: Container(
                          padding: const EdgeInsets.only(top: 100, left: 15),
                          height: 160,
                          width: 160,
                          decoration: BoxDecoration(
                            color: widget.model.color.shade300,
                            boxShadow: [
                              BoxShadow(
                                color: widget.model.color.withOpacity(0.4),
                                blurRadius: 20,
                                spreadRadius: 2,
                              ),
                            ],
                          ),
                          child: Transform.scale(
                            scale: 2.5,
                            child: Lottie.asset('assets/lottie/yoga.json',
                                errorBuilder: (context, error, stackTrace) {
                              return const SizedBox.shrink();
                            }),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 40),
              // Title and author
              Text(
                widget.model.title,
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.w800,
                  color: _isDark ? Colors.white : widget.model.color.shade300,
                  letterSpacing: -0.5,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 8),
              Text(
                widget.model.author,
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w500,
                  color: _isDark
                      ? Colors.white.withOpacity(0.7)
                      : widget.model.color.shade300.withOpacity(0.7),
                ),
              ),
              const SizedBox(height: 50),
              // Control buttons
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: _isDark
                          ? Colors.white.withOpacity(0.08)
                          : widget.model.color.withOpacity(0.1),
                    ),
                    child: IconButton(
                      onPressed: () async {
                        await _audioPlayer.seek(Duration(
                          milliseconds: (_audioPlayer.position.inMilliseconds - 5000)
                              .clamp(0, _audioPlayer.duration?.inMilliseconds ?? 0)
                              .toInt(),
                        ));
                      },
                      icon: Icon(
                        Icons.skip_previous_rounded,
                        size: 32,
                        color: _isDark
                            ? Colors.white.withOpacity(0.5)
                            : widget.model.color.withOpacity(0.4),
                      ),
                    ),
                  ),
                  const SizedBox(width: 30),
                  // Play/Pause button
                  Container(
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      gradient: LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        colors: [
                          widget.model.color.shade300,
                          widget.model.color.shade400,
                        ],
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: widget.model.color.withOpacity(0.3),
                          blurRadius: 20,
                          offset: const Offset(0, 8),
                        ),
                      ],
                    ),
                    child: IconButton(
                      onPressed: () async {
                        if (_isPlaying) {
                          await _audioPlayer.pause();
                          _controller.reverse();
                        } else {
                          await _audioPlayer.play();
                          _controller.forward();
                        }
                        setState(() {
                          _isPlaying = !_isPlaying;
                        });
                      },
                      icon: AnimatedIcon(
                        icon: AnimatedIcons.play_pause,
                        progress: _progress,
                        size: 36,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  const SizedBox(width: 30),
                  Container(
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: _isDark
                          ? Colors.white.withOpacity(0.08)
                          : widget.model.color.withOpacity(0.1),
                    ),
                    child: IconButton(
                      onPressed: () async {
                        await _audioPlayer.seek(Duration(
                          milliseconds: (_audioPlayer.position.inMilliseconds + 5000)
                              .clamp(0, _audioPlayer.duration?.inMilliseconds ?? 0)
                              .toInt(),
                        ));
                      },
                      icon: Icon(
                        Icons.skip_next_rounded,
                        size: 32,
                        color: _isDark
                            ? Colors.white.withOpacity(0.5)
                            : widget.model.color.withOpacity(0.4),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 40),
              // Progress slider
              ValueListenableBuilder(
                valueListenable: _player,
                builder: (context, value, _) {
                  return Column(
                    children: [
                      SliderTheme(
                        data: SliderThemeData(
                          trackHeight: 6,
                          thumbShape: const RoundSliderThumbShape(
                            elevation: 8,
                            enabledThumbRadius: 8,
                            pressedElevation: 12,
                          ),
                          overlayShape: const RoundSliderOverlayShape(
                            overlayRadius: 14,
                          ),
                        ),
                        child: Slider(
                          thumbColor: widget.model.color.shade300,
                          activeColor: widget.model.color.shade300,
                          inactiveColor: _isDark
                              ? Colors.white.withOpacity(0.1)
                              : widget.model.color.withOpacity(0.2),
                          value: value,
                          onChanged: (newValue) async {
                            _controller.reverse();
                            _player.value = newValue;
                            await _audioPlayer.seek(Duration(
                              milliseconds: (newValue * 
                                  (_audioPlayer.duration?.inMilliseconds ?? 0))
                                  .toInt(),
                            ));
                          },
                        ),
                      ),
                      const SizedBox(height: 8),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "${(value * 10).toStringAsFixed(1)} min",
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w500,
                              color: _isDark
                                  ? Colors.white.withOpacity(0.6)
                                  : widget.model.color
                                      .shade300
                                      .withOpacity(0.6),
                            ),
                          ),
                          Text(
                            "10 min",
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w500,
                              color: _isDark
                                  ? Colors.white.withOpacity(0.6)
                                  : widget.model.color
                                      .shade300
                                      .withOpacity(0.6),
                            ),
                          ),
                        ],
                      ),
                    ],
                  );
                },
              ),
              const SizedBox(height: 40),
              // Slogan section
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Text(
                  widget.model.slogan,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 16,
                    height: 1.6,
                    fontWeight: FontWeight.w500,
                    color: _isDark
                        ? Colors.white.withOpacity(0.7)
                        : widget.model.color.shade300.withOpacity(0.7),
                    fontStyle: FontStyle.italic,
                  ),
                ),
              ),
              const SizedBox(height: 40),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    _audioPlayer.dispose();
    super.dispose();
  }
}