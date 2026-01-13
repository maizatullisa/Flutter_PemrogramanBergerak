import 'package:flutter/material.dart';
import 'package:meditation_app/features/home/model/recommendation_model.dart';
import 'package:meditation_app/features/player/screens/player.dart';

class AnimatedRecommendationCard extends StatefulWidget {
  const AnimatedRecommendationCard({
    super.key,
    required this.model,
  });

  final RecommendationModel model;

  @override
  State<AnimatedRecommendationCard> createState() => _AnimatedRecommendationCardState();
}

class _AnimatedRecommendationCardState extends State<AnimatedRecommendationCard>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _scaleAnimation;
  late Animation<double> _opacityAnimation;
  bool _isHovered = false;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 1200),
      vsync: this,
    )..repeat(reverse: true);

    _scaleAnimation = Tween<double>(begin: 0.98, end: 1.02).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeInOut),
    );

    _opacityAnimation = Tween<double>(begin: 0.8, end: 1.0).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (_) => PlayerScreen(model: widget.model)),
        );
      },
      onTapDown: (_) {
        setState(() => _isHovered = true);
      },
      onTapUp: (_) {
        setState(() => _isHovered = false);
      },
      onTapCancel: () {
        setState(() => _isHovered = false);
      },
      child: AnimatedBuilder(
        animation: _scaleAnimation,
        builder: (context, child) {
          return Transform.scale(
            scale: _isHovered ? 1.05 : _scaleAnimation.value,
            child: child,
          );
        },
        child: FadeTransition(
          opacity: _opacityAnimation,
          child: Container(
            width: 170,
            margin: const EdgeInsets.symmetric(horizontal: 6),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  widget.model.color.shade200,
                  widget.model.color.shade400,
                ],
              ),
              borderRadius: BorderRadius.circular(20),
              boxShadow: [
                BoxShadow(
                  color: widget.model.color.withOpacity(0.4),
                  blurRadius: 20,
                  offset: const Offset(0, 10),
                  spreadRadius: 2,
                ),
              ],
            ),
            child: Stack(
              children: [
                // Animated background orbs
                Positioned(
                  top: -30,
                  right: -30,
                  child: AnimatedBuilder(
                    animation: _animationController,
                    builder: (context, child) {
                      return Transform.translate(
                        offset: Offset(
                          10 * _animationController.value,
                          -10 * _animationController.value,
                        ),
                        child: Container(
                          height: 80,
                          width: 80,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.white.withOpacity(0.1),
                          ),
                        ),
                      );
                    },
                  ),
                ),
                Positioned(
                  bottom: -40,
                  left: -40,
                  child: AnimatedBuilder(
                    animation: _animationController,
                    builder: (context, child) {
                      return Transform.translate(
                        offset: Offset(
                          -10 * _animationController.value,
                          10 * _animationController.value,
                        ),
                        child: Container(
                          height: 100,
                          width: 100,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.white.withOpacity(0.08),
                          ),
                        ),
                      );
                    },
                  ),
                ),
                // Content
                Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            widget.model.title,
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                              fontWeight: FontWeight.w700,
                              letterSpacing: -0.3,
                            ),
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          AnimatedBuilder(
                            animation: _animationController,
                            builder: (context, child) {
                              return Transform.scale(
                                scale: 0.9 + (0.1 * _animationController.value),
                                child: Icon(
                                  Icons.access_time,
                                  color: Colors.white.withOpacity(0.8),
                                  size: 14,
                                ),
                              );
                            },
                          ),
                          const SizedBox(width: 6),
                          Text(
                            widget.model.duration,
                            style: TextStyle(
                              color: Colors.white.withOpacity(0.8),
                              fontSize: 12,
                            ),
                          ),
                          const Spacer(),
                          AnimatedBuilder(
                            animation: _animationController,
                            builder: (context, child) {
                              return Transform.rotate(
                                angle: 0.2 * _animationController.value,
                                child: Container(
                                  height: 36,
                                  width: 36,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: Colors.white,
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.black.withOpacity(0.2),
                                        blurRadius: 8,
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
                              );
                            },
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}