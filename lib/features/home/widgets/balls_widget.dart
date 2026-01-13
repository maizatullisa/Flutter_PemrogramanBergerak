import 'dart:math';

import 'package:flutter/material.dart';
import 'package:meditation_app/features/home/model/recommendation_model.dart';
import 'package:meditation_app/features/player/screens/player.dart';

class Balls extends StatefulWidget {
  const Balls({
    super.key,
    required this.model,
  });

  @override
  State<Balls> createState() => _BallsState();

  final RecommendationModel model;
}

class _BallsState extends State<Balls> {
  List<double> positions = [0, 0, 0, 0];

  void randomize() {
    positions[0] = Random().nextInt(100) + 80;
    positions[1] = Random().nextInt(150) - 50;
    positions[2] = Random().nextInt(100) + 80;
    positions[3] = Random().nextInt(150) - 50;
  }

  initMoment() async {
    if (mounted && context.mounted) {
      randomize();
      setState(() {});
    }
    await Future.delayed(const Duration(seconds: 3));
    if (mounted && context.mounted) {
      initMoment();
    }
  }

  @override
  void initState() {
    super.initState();
    randomize();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      randomize();
      setState(() {});
      initMoment();
    });
  }

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(30),
      child: Container(
        width: 170,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              widget.model.color.shade200,
              widget.model.color.shade400,
            ],
          ),
          boxShadow: [
            BoxShadow(
              color: widget.model.color.withOpacity(0.3),
              blurRadius: 15,
              offset: const Offset(0, 8),
            ),
          ],
        ),
        child: Stack(
          children: [
            // Animated ball 1
            AnimatedPositioned(
              duration: const Duration(seconds: 3),
              top: positions[0],
              right: positions[1],
              child: Container(
                height: 80,
                width: 80,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: widget.model.color.withOpacity(0.6),
                  boxShadow: [
                    BoxShadow(
                      color: widget.model.color.withOpacity(0.4),
                      blurRadius: 10,
                      spreadRadius: 2,
                    ),
                  ],
                ),
              ),
            ),
            // Animated ball 2
            AnimatedPositioned(
              duration: const Duration(seconds: 3),
              bottom: positions[2],
              left: positions[3],
              child: Container(
                height: 80,
                width: 80,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: widget.model.color.withOpacity(0.5),
                  boxShadow: [
                    BoxShadow(
                      color: widget.model.color.withOpacity(0.3),
                      blurRadius: 10,
                      spreadRadius: 2,
                    ),
                  ],
                ),
              ),
            ),
            // Content section
            Positioned(
              bottom: 16,
              left: 12,
              right: 12,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.model.title,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.w800,
                      letterSpacing: -0.3,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'Course',
                    style: TextStyle(
                      color: Colors.white.withOpacity(0.85),
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      Icon(
                        Icons.access_time,
                        color: Colors.white.withOpacity(0.8),
                        size: 14,
                      ),
                      const SizedBox(width: 4),
                      Text(
                        widget.model.duration,
                        style: TextStyle(
                          color: Colors.white.withOpacity(0.8),
                          fontSize: 12,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      const Spacer(),
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => PlayerScreen(model: widget.model),
                            ),
                          );
                        },
                        child: Container(
                          height: 38,
                          width: 38,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.white.withOpacity(0.95),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.15),
                                blurRadius: 8,
                                offset: const Offset(0, 4),
                              ),
                            ],
                          ),
                          child: Center(
                            child: Icon(
                              Icons.play_arrow,
                              color: widget.model.color,
                              size: 20,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}