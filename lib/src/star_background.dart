import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';

// Star Model
class Star {
  Offset position; // Position of the star on the canvas
  double size; // Radius of the star
  Color color; // Color of the star
  double opacity; // Current opacity of the star
  double pulseRate; // Rate at which the star's opacity changes
  bool isIncreasing; // Direction of opacity change
  final double minOpacity; // Minimum opacity value
  final double maxOpacity; // Maximum opacity value
  bool shouldFadeOut; // Indicates if the star should start fading out

  Star({
    required this.position,
    required this.size,
    required this.color,
    this.opacity = 1.0,
    required this.pulseRate,
    this.isIncreasing = true,
    this.minOpacity = 0.5,
    this.maxOpacity = 1.0,
    this.shouldFadeOut = false, // Initialize as false
  });
}

// ShootingStar Model
class ShootingStar {
  Offset startPosition; // Starting point of the shooting star
  Offset endPosition; // Ending point of the shooting star
  Offset currentPosition; // Current position as it moves
  double speed; // Speed at which the shooting star moves
  double opacity; // Current opacity for fading effect
  bool isFadingIn; // Indicates if the shooting star is fading in
  bool isFadingOut; // Indicates if the shooting star is fading out

  ShootingStar({
    required this.startPosition,
    required this.endPosition,
    required this.speed,
    this.opacity = 0.0, // Start fully transparent
    this.isFadingIn = true,
    this.isFadingOut = false,
  }) : currentPosition = startPosition;
}

// Custom Painter for Pulsing Stars and Shooting Stars
class PulsingStarsPainter extends CustomPainter {
  final List<Star> stars;
  final List<ShootingStar> shootingStars; // Added shootingStars list

  PulsingStarsPainter(this.stars, this.shootingStars); // Modified constructor

  @override
  void paint(Canvas canvas, Size size) {
    final Paint paint = Paint();

    // Draw pulsing stars
    for (var star in stars) {
      paint.color = star.color.withOpacity(star.opacity);
      canvas.drawCircle(star.position, star.size, paint);
    }

    // Draw shooting stars
    final Paint shootingStarPaint = Paint()
      ..color = Colors.white.withOpacity(0.8) // Customize color as needed
      ..strokeWidth = 2.0
      ..strokeCap = StrokeCap.round;

    for (var shootingStar in shootingStars) {
      shootingStarPaint.color =
          shootingStarPaint.color.withOpacity(shootingStar.opacity);
      canvas.drawLine(shootingStar.startPosition, shootingStar.currentPosition,
          shootingStarPaint);
    }
  }

  @override
  bool shouldRepaint(covariant PulsingStarsPainter oldDelegate) {
    // Repaint whenever the stars or shootingStars list changes
    return true;
  }
}

/// A widget that displays a background with pulsing stars and shooting stars.
///
/// The `PulsingStarsBackground` creates a dynamic starry background with pulsing
/// stars and occasional shooting stars. Stars are animated to pulse in brightness,
/// while shooting stars move across the screen with fading effects.
class PulsingStarsBackground extends StatefulWidget {
  /// Maximum number of stars that can be displayed on the screen.
  final int maxStars;

  /// The interval at which new stars are spawned.
  final Duration spawnDuration;

  /// The interval at which new shooting stars are spawned.
  final Duration spawnShootingStarDuration;

  /// The interval at which stars and shooting stars are updated.
  final Duration updateDuration;

  /// Constructs a `PulsingStarsBackground` with the specified parameters.
  ///
  /// The widget automatically manages the animation and spawning of stars.
  const PulsingStarsBackground({
    Key? key,
    this.maxStars = 100,
    this.spawnDuration = const Duration(milliseconds: 500),
    this.updateDuration = const Duration(milliseconds: 50),
    this.spawnShootingStarDuration = const Duration(seconds: 10),
  }) : super(key: key);

  @override
  _PulsingStarsBackgroundState createState() => _PulsingStarsBackgroundState();
}

class _PulsingStarsBackgroundState extends State<PulsingStarsBackground> {
  /// List of pulsing stars currently on the screen.
  final List<Star> _stars = [];

  /// List of shooting stars currently on the screen.
  final List<ShootingStar> _shootingStars = [];

  /// Timer for spawning new stars.
  late Timer _spawnTimer;

  /// Timer for updating the animation of stars and shooting stars.
  late Timer _updateTimer;

  /// Timer for spawning new shooting stars.
  late Timer _shootingStarTimer;

  /// Random number generator for star positioning and attributes.
  final Random _random = Random();

  @override
  void initState() {
    super.initState();

    // Start spawning stars at regular intervals.
    _spawnTimer = Timer.periodic(widget.spawnDuration, (timer) {
      if (_stars.length < widget.maxStars) {
        _addStar();
      }
    });

    // Start spawning shooting stars at regular intervals.
    _shootingStarTimer =
        Timer.periodic(widget.spawnShootingStarDuration, (timer) {
          _spawnShootingStar();
        });

    // Start updating stars and shooting stars at regular intervals.
    _updateTimer = Timer.periodic(widget.updateDuration, (timer) {
      _updateStars();
      _updateShootingStars();
    });
  }

  @override
  void dispose() {
    // Cancel all timers to prevent memory leaks.
    _spawnTimer.cancel();
    _updateTimer.cancel();
    _shootingStarTimer.cancel();
    super.dispose();
  }

  /// Adds a new pulsing star to the screen at a random position.
  ///
  /// The star's size, position, and pulsing rate are randomized.
  void _addStar() {
    final Size size = MediaQuery.of(context).size;
    final double x = _random.nextDouble() * size.width;
    final double y = _random.nextDouble() * size.height;
    final double starSize = _random.nextDouble() * 2 + 1; // Size between 1 and 3
    final Color starColor = Colors.white.withOpacity(0.8); // Slight transparency
    final double pulseRate =
        _random.nextDouble() * 0.02 + 0.005; // Pulse rate between 0.005 and 0.025
    final double minOpacity = 0.5;
    final double maxOpacity = 1.0;

    setState(() {
      _stars.add(Star(
        position: Offset(x, y),
        size: starSize,
        color: starColor,
        opacity:
        minOpacity + _random.nextDouble() * (maxOpacity - minOpacity),
        pulseRate: pulseRate,
        isIncreasing: _random.nextBool(),
        minOpacity: minOpacity,
        maxOpacity: maxOpacity,
        shouldFadeOut: false,
      ));
    });
  }

  /// Spawns a new shooting star from one edge of the screen to another.
  ///
  /// The shooting star is assigned random start and end positions on opposite edges
  /// and a randomized speed.
  void _spawnShootingStar() {
    final Size size = MediaQuery.of(context).size;

    // Generate a position slightly outside the specified edge.
    Offset getPosition(String edge) {
      switch (edge) {
        case 'top':
          return Offset(_random.nextDouble() * size.width, -10);
        case 'bottom':
          return Offset(_random.nextDouble() * size.width, size.height + 10);
        case 'left':
          return Offset(-10, _random.nextDouble() * size.height);
        case 'right':
          return Offset(size.width + 10, _random.nextDouble() * size.height);
        default:
          return Offset(0, 0);
      }
    }

    // Select random edges for the start and end positions.
    List<String> edges = ['top', 'bottom', 'left', 'right'];
    String startEdge = edges[_random.nextInt(edges.length)];
    String endEdge = (List.from(edges)..remove(startEdge))
    [_random.nextInt(edges.length - 1)];

    setState(() {
      _shootingStars.add(ShootingStar(
        startPosition: getPosition(startEdge),
        endPosition: getPosition(endEdge),
        speed: _random.nextDouble() * 5 + 5,
        opacity: 0.0,
        isFadingIn: true,
        isFadingOut: false,
      ));
    });
  }

  /// Updates the opacity and pulsing behavior of all stars.
  ///
  /// Stars pulse between their minimum and maximum opacity, and some stars
  /// begin fading out at random intervals.
  void _updateStars() {
    setState(() {
      for (var star in _stars) {
        if (!star.shouldFadeOut && _random.nextDouble() < 0.001) {
          star.shouldFadeOut = true;
        }

        if (star.shouldFadeOut) {
          star.opacity -= 0.01;
        } else if (star.isIncreasing) {
          star.opacity += star.pulseRate;
          if (star.opacity >= star.maxOpacity) {
            star.isIncreasing = false;
          }
        } else {
          star.opacity -= star.pulseRate;
          if (star.opacity <= star.minOpacity) {
            star.isIncreasing = true;
          }
        }
      }

      _stars.removeWhere((star) => star.opacity <= 0.0);
    });
  }

  /// Updates the position and fading behavior of all shooting stars.
  ///
  /// Shooting stars fade in, move across the screen, and fade out as they near
  /// their destination.
  void _updateShootingStars() {
    setState(() {
      for (int i = _shootingStars.length - 1; i >= 0; i--) {
        ShootingStar shootingStar = _shootingStars[i];

        // Calculate direction vector.
        double dx = shootingStar.endPosition.dx -
            shootingStar.startPosition.dx;
        double dy = shootingStar.endPosition.dy -
            shootingStar.startPosition.dy;
        double distance = sqrt(dx * dx + dy * dy);
        double directionX = dx / distance;
        double directionY = dy / distance;

        // Update current position.
        Offset newPosition = shootingStar.currentPosition +
            Offset(directionX * shootingStar.speed,
                directionY * shootingStar.speed);
        shootingStar.currentPosition = newPosition;

        // Update opacity based on distance traveled.
        double traveledDistance =
            (shootingStar.currentPosition - shootingStar.startPosition)
                .distance;
        if (!shootingStar.isFadingOut && traveledDistance >= distance / 2) {
          shootingStar.isFadingOut = true;
        }

        if (shootingStar.isFadingIn) {
          shootingStar.opacity += 0.02;
          if (shootingStar.opacity >= 1.0) {
            shootingStar.isFadingIn = false;
          }
        } else if (shootingStar.isFadingOut) {
          shootingStar.opacity -= 0.02;
          if (shootingStar.opacity <= 0.0) {
            _shootingStars.removeAt(i);
          }
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: PulsingStarsPainter(_stars, _shootingStars),
      size: Size.infinite,
    );
  }
}
