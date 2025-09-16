import 'package:flutter/material.dart';
import 'dart:math';

void main() {
  runApp(const ShapesDemoApp());
}

class ShapesDemoApp extends StatelessWidget {
  const ShapesDemoApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Shapes Drawing Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        useMaterial3: true,
      ),
      home: const ShapesDemoScreen(),
    );
  }
}

class ShapesDemoScreen extends StatefulWidget {
  const ShapesDemoScreen({super.key});

  @override
  State<ShapesDemoScreen> createState() => _ShapesDemoScreenState();
}

class _ShapesDemoScreenState extends State<ShapesDemoScreen> {
  String _selectedEmoji = 'Party Face';
  final List<String> _emojiOptions = [
    'Party Face',
    'Heart',
    'Cool',
    'Surprised',
    'Wink',
    'Sad',
    'Star Eyes',
    'Silly',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: ShaderMask(
          shaderCallback: (Rect bounds) {
            return const LinearGradient(
              colors: [Color(0xFFF9F9F9), Color(0xFFE0E0FF), Color(0xFFB3C6FF)],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ).createShader(bounds);
          },
          child: const Text(
            'Shapes Drawing Demo',
            style: TextStyle(
              color: Colors.white,
              fontSize: 28,
              fontWeight: FontWeight.bold,
              letterSpacing: 1.2,
              shadows: [Shadow(blurRadius: 4, color: Colors.black26, offset: Offset(1,2))],
            ),
            textAlign: TextAlign.center,
          ),
        ),
        centerTitle: true,
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFF6A82FB), Color(0xFFFC5C7D), Color(0xFF36D1C4)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(16, 56, 16, 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: Card(
                  elevation: 4,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                  color: Colors.white.withOpacity(0.95),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Icon(Icons.emoji_emotions, color: Colors.deepPurple, size: 28),
                        const SizedBox(width: 10),
                        const Text('Choose Emoji:', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                        const SizedBox(width: 16),
                        DropdownButtonHideUnderline(
                          child: DropdownButton<String>(
                            value: _selectedEmoji,
                            items: _emojiOptions
                                .map((e) => DropdownMenuItem(
                                      value: e,
                                      child: Row(
                                        children: [
                                          Icon(
                                            e == 'Party Face' ? Icons.celebration :
                                            e == 'Heart' ? Icons.favorite :
                                            e == 'Cool' ? Icons.emoji_people :
                                            e == 'Surprised' ? Icons.sentiment_very_dissatisfied :
                                            e == 'Wink' ? Icons.emoji_emotions :
                                            e == 'Sad' ? Icons.sentiment_dissatisfied :
                                            e == 'Star Eyes' ? Icons.star :
                                            Icons.emoji_emotions,
                                            color: e == 'Party Face' ? Colors.orange :
                                              e == 'Heart' ? Colors.pink :
                                              e == 'Cool' ? Colors.blue :
                                              e == 'Surprised' ? Colors.amber :
                                              e == 'Wink' ? Colors.purple :
                                              e == 'Sad' ? Colors.blueGrey :
                                              e == 'Star Eyes' ? Colors.yellow :
                                              Colors.teal,
                                            size: 22,
                                          ),
                                          const SizedBox(width: 8),
                                          Text(e, style: const TextStyle(fontSize: 15)),
                                        ],
                                      ),
                                    ))
                                .toList(),
                            onChanged: (value) {
                              if (value != null) {
                                setState(() {
                                  _selectedEmoji = value;
                                });
                              }
                            },
                            dropdownColor: Colors.white,
                            borderRadius: BorderRadius.circular(14),
                            style: const TextStyle(color: Colors.black, fontWeight: FontWeight.w500),
                            icon: const Icon(Icons.arrow_drop_down, color: Colors.deepPurple),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 10),
              SizedBox(
                height: 300,
                child: CustomPaint(
                  painter: EmojiPainter(_selectedEmoji),
                  size: const Size(double.infinity, 300),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

/// CustomPainter for Party Face and Heart Emojis
class EmojiPainter extends CustomPainter {
  final String emojiType;
  EmojiPainter(this.emojiType);

  @override
  void paint(Canvas canvas, Size size) {
    switch (emojiType) {
      case 'Party Face':
        _drawPartyFace(canvas, size);
        break;
      case 'Heart':
        _drawHeart(canvas, size);
        break;
      case 'Cool':
        _drawCool(canvas, size);
        break;
      case 'Surprised':
        _drawSurprised(canvas, size);
        break;
      case 'Wink':
        _drawWink(canvas, size);
        break;
      case 'Sad':
        _drawSad(canvas, size);
        break;
      case 'Star Eyes':
        _drawStarEyes(canvas, size);
        break;
      case 'Silly':
        _drawSilly(canvas, size);
        break;
      default:
        _drawPartyFace(canvas, size);
    }
  }

  void _drawCool(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final faceRect = Rect.fromCircle(center: center, radius: 80);
    final facePaint = Paint()
      ..shader = RadialGradient(colors: [Colors.yellow, Colors.orangeAccent]).createShader(faceRect);
    canvas.drawCircle(center, 80, facePaint);
    // Sunglasses
    final glassPaint = Paint()..color = Colors.black;
    canvas.drawRect(Rect.fromCenter(center: center.translate(-25, -20), width: 35, height: 18), glassPaint);
    canvas.drawRect(Rect.fromCenter(center: center.translate(25, -20), width: 35, height: 18), glassPaint);
    canvas.drawRect(Rect.fromCenter(center: center.translate(0, -20), width: 20, height: 8), glassPaint);
    // Smile
    final smilePaint = Paint()
      ..color = Colors.black
      ..style = PaintingStyle.stroke
      ..strokeWidth = 5;
    final smileRect = Rect.fromCenter(center: center.translate(0, 25), width: 50, height: 30);
    canvas.drawArc(smileRect, 0, pi, false, smilePaint);
  }

  void _drawSurprised(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final faceRect = Rect.fromCircle(center: center, radius: 80);
    final facePaint = Paint()
      ..shader = RadialGradient(colors: [Colors.yellow, Colors.orangeAccent]).createShader(faceRect);
    canvas.drawCircle(center, 80, facePaint);
    // Eyes
    final eyePaint = Paint()..color = Colors.black;
    canvas.drawCircle(center.translate(-25, -20), 12, eyePaint);
    canvas.drawCircle(center.translate(25, -20), 12, eyePaint);
    // Open mouth
    final mouthPaint = Paint()..color = Colors.black;
    canvas.drawOval(Rect.fromCenter(center: center.translate(0, 30), width: 24, height: 32), mouthPaint);
  }

  void _drawWink(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final faceRect = Rect.fromCircle(center: center, radius: 80);
    final facePaint = Paint()
      ..shader = RadialGradient(colors: [Colors.yellow, Colors.orangeAccent]).createShader(faceRect);
    canvas.drawCircle(center, 80, facePaint);
    // Left eye open
    final eyePaint = Paint()..color = Colors.black;
    canvas.drawCircle(center.translate(-25, -20), 10, eyePaint);
    // Right eye wink
    final winkPaint = Paint()
      ..color = Colors.black
      ..strokeWidth = 5;
    canvas.drawLine(center.translate(20, -20), center.translate(30, -20), winkPaint);
    // Smile
    final smilePaint = Paint()
      ..color = Colors.black
      ..style = PaintingStyle.stroke
      ..strokeWidth = 5;
    final smileRect = Rect.fromCenter(center: center.translate(0, 20), width: 50, height: 30);
    canvas.drawArc(smileRect, 0, pi, false, smilePaint);
  }

  void _drawSad(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final faceRect = Rect.fromCircle(center: center, radius: 80);
    final facePaint = Paint()
      ..shader = RadialGradient(colors: [Colors.yellow, Colors.orangeAccent]).createShader(faceRect);
    canvas.drawCircle(center, 80, facePaint);
    // Eyes
    final eyePaint = Paint()..color = Colors.black;
    canvas.drawCircle(center.translate(-25, -20), 10, eyePaint);
    canvas.drawCircle(center.translate(25, -20), 10, eyePaint);
    // Sad mouth
    final sadPaint = Paint()
      ..color = Colors.black
      ..style = PaintingStyle.stroke
      ..strokeWidth = 5;
    final sadRect = Rect.fromCenter(center: center.translate(0, 35), width: 50, height: 30);
    canvas.drawArc(sadRect, pi, pi, false, sadPaint);
  }

  void _drawStarEyes(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final faceRect = Rect.fromCircle(center: center, radius: 80);
    final facePaint = Paint()
      ..shader = RadialGradient(colors: [Colors.yellow, Colors.orangeAccent]).createShader(faceRect);
    canvas.drawCircle(center, 80, facePaint);
    // Star eyes
    final starPaint = Paint()..color = Colors.orange;
    _drawStar(canvas, center.translate(-25, -20), 12, 6, starPaint);
    _drawStar(canvas, center.translate(25, -20), 12, 6, starPaint);
    // Smile
    final smilePaint = Paint()
      ..color = Colors.black
      ..style = PaintingStyle.stroke
      ..strokeWidth = 5;
    final smileRect = Rect.fromCenter(center: center.translate(0, 20), width: 50, height: 30);
    canvas.drawArc(smileRect, 0, pi, false, smilePaint);
  }

  void _drawSilly(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final faceRect = Rect.fromCircle(center: center, radius: 80);
    final facePaint = Paint()
      ..shader = RadialGradient(colors: [Colors.yellow, Colors.orangeAccent]).createShader(faceRect);
    canvas.drawCircle(center, 80, facePaint);
    // Eyes
    final eyePaint = Paint()..color = Colors.black;
    canvas.drawCircle(center.translate(-25, -20), 10, eyePaint);
    canvas.drawCircle(center.translate(25, -10), 10, eyePaint);
    // Tongue
    final tonguePaint = Paint()..color = Colors.pink;
    canvas.drawOval(Rect.fromCenter(center: center.translate(0, 40), width: 24, height: 18), tonguePaint);
    // Silly mouth
    final sillyPaint = Paint()
      ..color = Colors.black
      ..style = PaintingStyle.stroke
      ..strokeWidth = 5;
    final sillyRect = Rect.fromCenter(center: center.translate(0, 30), width: 50, height: 30);
    canvas.drawArc(sillyRect, 0.2, pi, false, sillyPaint);
  }

  void _drawStar(Canvas canvas, Offset center, double radius, int points, Paint paint) {
    final path = Path();
    for (int i = 0; i < points * 2; i++) {
      final isEven = i % 2 == 0;
      final r = isEven ? radius : radius / 2.5;
      final angle = (pi / points) * i;
      final x = center.dx + r * cos(angle - pi / 2);
      final y = center.dy + r * sin(angle - pi / 2);
      if (i == 0) {
        path.moveTo(x, y);
      } else {
        path.lineTo(x, y);
      }
    }
    path.close();
    canvas.drawPath(path, paint);
  }

  void _drawPartyFace(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);

    // Gradient Face
    final faceRect = Rect.fromCircle(center: center, radius: 80);
    final facePaint = Paint()
      ..shader =
          RadialGradient(colors: [Colors.yellow, Colors.orangeAccent]).createShader(faceRect);
    canvas.drawCircle(center, 80, facePaint);

    // Eyes
    final eyePaint = Paint()..color = Colors.black;
    canvas.drawCircle(center.translate(-30, -20), 10, eyePaint);
    canvas.drawCircle(center.translate(30, -20), 10, eyePaint);

    // Smile
    final smilePaint = Paint()
      ..color = Colors.black
      ..style = PaintingStyle.stroke
      ..strokeWidth = 5;
    final smileRect =
        Rect.fromCenter(center: center.translate(0, 20), width: 50, height: 30);
    canvas.drawArc(smileRect, 0, pi, false, smilePaint);

    // Party hat with gradient (right side up)
    final hatPath = Path()
      ..moveTo(center.dx, center.dy - 120) // top point
      ..lineTo(center.dx - 30, center.dy - 80) // bottom left
      ..lineTo(center.dx + 30, center.dy - 80) // bottom right
      ..close();
    final hatRect = Rect.fromLTWH(center.dx - 30, center.dy - 120, 60, 40);
    final hatPaint = Paint()
      ..shader =
          LinearGradient(colors: [Colors.purple, Colors.pink]).createShader(hatRect);
    canvas.drawPath(hatPath, hatPaint);

    // Hat band
    final bandPaint = Paint()..color = Colors.blue;
    canvas.drawRect(Rect.fromLTWH(center.dx - 15, center.dy - 80, 30, 8), bandPaint);

    // Confetti
    final confettiColors = [Colors.red, Colors.green, Colors.blue, Colors.orange, Colors.pink];
    final rand = Random(42);
    for (int i = 0; i < 15; i++) {
      final angle = rand.nextDouble() * 2 * pi;
      final radius = 100 + rand.nextDouble() * 30;
      final confettiOffset = Offset(center.dx + cos(angle) * radius,
          center.dy + sin(angle) * radius);
      final confettiPaint = Paint()..color = confettiColors[i % confettiColors.length];
      canvas.drawCircle(confettiOffset, 6, confettiPaint);
    }
  }

  void _drawHeart(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2 + 20);
    final rect = Rect.fromCenter(center: center, width: 200, height: 200);
    final Path path = Path();
    path.moveTo(center.dx, center.dy);
    path.cubicTo(center.dx + 60, center.dy - 80, center.dx + 120, center.dy + 40,
        center.dx, center.dy + 100);
    path.cubicTo(center.dx - 120, center.dy + 40, center.dx - 60, center.dy - 80,
        center.dx, center.dy);

    // Create a gradient shader for the heart shape
    final Paint heartPaint = Paint()
      ..shader = const RadialGradient(
        colors: [Colors.pink, Colors.red, Colors.deepPurple],
        stops: [0.2, 0.7, 1.0],
        center: Alignment(0, -0.3),
        radius: 0.9,
      ).createShader(rect);

    canvas.drawPath(path, heartPaint);
    // Optional: Add a white highlight for a glossy effect
    final highlightPaint = Paint()
      ..shader = const RadialGradient(
        colors: [Colors.white54, Colors.transparent],
        radius: 0.4,
        center: Alignment(-0.3, -0.5),
      ).createShader(rect)
      ..blendMode = BlendMode.lighten;
    canvas.drawPath(path, highlightPaint);
  }

  @override
  bool shouldRepaint(covariant EmojiPainter oldDelegate) =>
      oldDelegate.emojiType != emojiType;
}

/// Task 1: Basic Shapes with gradients
class BasicShapesPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final centerX = size.width / 2;
    final centerY = size.height / 2;

    // Square with gradient
    final squareRect = Rect.fromCenter(center: Offset(centerX - 80, centerY), width: 60, height: 60);
    final squarePaint = Paint()
      ..shader = LinearGradient(colors: [Colors.blue, Colors.lightBlueAccent])
          .createShader(squareRect);
    canvas.drawRect(squareRect, squarePaint);

    // Circle with radial gradient
    final circleCenter = Offset(centerX, centerY);
    final circleRect = Rect.fromCircle(center: circleCenter, radius: 30);
    final circlePaint = Paint()
      ..shader = RadialGradient(colors: [Colors.red, Colors.orange])
          .createShader(circleRect);
    canvas.drawCircle(circleCenter, 30, circlePaint);

    // Arc with sweep gradient
    final arcRect = Rect.fromCenter(center: Offset(centerX + 80, centerY), width: 60, height: 60);
    final arcPaint = Paint()
      ..shader = SweepGradient(colors: [Colors.green, Colors.lightGreenAccent])
          .createShader(arcRect)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 5;
    canvas.drawArc(arcRect, 0, 2.1, false, arcPaint);

    // Rectangle with gradient
    final rectRect = Rect.fromCenter(center: Offset(centerX - 160, centerY), width: 80, height: 40);
    final rectPaint = Paint()
      ..shader = LinearGradient(colors: [Colors.orange, Colors.deepOrangeAccent])
          .createShader(rectRect);
    canvas.drawRect(rectRect, rectPaint);

    // Line with gradient
    final linePaint = Paint()
      ..shader = LinearGradient(colors: [Colors.purple, Colors.pink])
          .createShader(Rect.fromPoints(
              Offset(centerX - 200, centerY - 50), Offset(centerX - 140, centerY + 50)))
      ..strokeWidth = 3;
    canvas.drawLine(
        Offset(centerX - 200, centerY - 50), Offset(centerX - 140, centerY + 50), linePaint);

    // Oval with gradient
    final ovalRect = Rect.fromCenter(center: Offset(centerX + 160, centerY), width: 80, height: 40);
    final ovalPaint = Paint()
      ..shader = LinearGradient(colors: [Colors.teal, Colors.cyan])
          .createShader(ovalRect);
    canvas.drawOval(ovalRect, ovalPaint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

/// Task 2: Combined Shapes with background gradient
class CombinedShapesPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final centerX = size.width / 2;
    final centerY = size.height / 2;

    // Background gradient
    final backgroundGradient =
        RadialGradient(center: Alignment.center, radius: 0.8, colors: [
      Colors.blue.shade100,
      Colors.white,
    ]);
    canvas.drawRect(
        Rect.fromLTWH(0, 0, size.width, size.height),
        Paint()
          ..shader = backgroundGradient.createShader(
              Rect.fromLTWH(0, 0, size.width, size.height)));

    // Sun with gradient
    final sunRect = Rect.fromCircle(center: Offset(centerX, centerY - 40), radius: 40);
    final sunPaint = Paint()
      ..shader = RadialGradient(colors: [Colors.yellow, Colors.orange])
          .createShader(sunRect);
    canvas.drawCircle(Offset(centerX, centerY - 40), 40, sunPaint);

    // Sun rays
    final rayPaint = Paint()
      ..color = Colors.orangeAccent
      ..strokeWidth = 3;
    for (int i = 0; i < 8; i++) {
      final angle = i * (pi / 4);
      final dx = cos(angle) * 60;
      final dy = sin(angle) * 60;
      canvas.drawLine(Offset(centerX, centerY - 40),
          Offset(centerX + dx, centerY - 40 + dy), rayPaint);
    }

    // House body with gradient
    final houseRect = Rect.fromCenter(center: Offset(centerX, centerY + 40), width: 80, height: 80);
    final housePaint = Paint()
      ..shader = LinearGradient(colors: [Colors.brown, Colors.deepOrange])
          .createShader(houseRect);
    canvas.drawRect(houseRect, housePaint);

    // Roof with gradient
    final roofRect = Rect.fromLTWH(centerX - 60, centerY - 60, 120, 60);
    final roofPaint = Paint()
      ..shader = LinearGradient(colors: [Colors.red, Colors.pink])
          .createShader(roofRect);
    final roofPath = Path()
      ..moveTo(centerX - 60, centerY)
      ..lineTo(centerX + 60, centerY)
      ..lineTo(centerX, centerY - 60)
      ..close();
    canvas.drawPath(roofPath, roofPaint);

    // Door with gradient
    final doorRect = Rect.fromCenter(center: Offset(centerX, centerY + 60), width: 30, height: 50);
    final doorPaint = Paint()
      ..shader = LinearGradient(colors: [Colors.blueGrey, Colors.grey])
          .createShader(doorRect);
    canvas.drawRect(doorRect, doorPaint);

    // Windows with gradient
    final leftWindow = Rect.fromCenter(center: Offset(centerX - 25, centerY + 20), width: 20, height: 20);
    final rightWindow = Rect.fromCenter(center: Offset(centerX + 25, centerY + 20), width: 20, height: 20);
    final windowPaint = Paint()
      ..shader = LinearGradient(colors: [Colors.blue.shade200, Colors.white])
          .createShader(leftWindow);
    canvas.drawRect(leftWindow, windowPaint);
    canvas.drawRect(rightWindow, windowPaint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}

/// Task 3: Styled Shapes with gradients
class StyledShapesPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final centerX = size.width / 2;
    final centerY = size.height / 2;

    // Gradient rectangle
    final rect = Rect.fromCenter(center: Offset(centerX, centerY - 100), width: 200, height: 60);
    final rectPaint = Paint()
      ..shader = LinearGradient(colors: [Colors.red, Colors.blue]).createShader(rect);
    canvas.drawRect(rect, rectPaint);

    // Circle with gradient fill + border
    final circleCenter = Offset(centerX - 80, centerY);
    final circleRect = Rect.fromCircle(center: circleCenter, radius: 40);
    final circlePaint = Paint()
      ..shader = RadialGradient(colors: [Colors.green, Colors.lightGreenAccent])
          .createShader(circleRect);
    canvas.drawCircle(circleCenter, 40, circlePaint);
    canvas.drawCircle(
        circleCenter, 40, Paint()..color = Colors.black..style = PaintingStyle.stroke..strokeWidth = 4);

    // Transparent oval with gradient
    final ovalRect = Rect.fromCenter(center: Offset(centerX + 80, centerY), width: 100, height: 60);
    final ovalPaint = Paint()
      ..shader = LinearGradient(colors: [Colors.purple, Colors.pink])
          .createShader(ovalRect)
      ..colorFilter = const ColorFilter.mode(Colors.transparent, BlendMode.dstOver);
    canvas.drawOval(ovalRect, ovalPaint);

    // Dashed line
    final dashPaint = Paint()
      ..color = Colors.orange
      ..strokeWidth = 3
      ..style = PaintingStyle.stroke;
    final path = Path();
    double startX = centerX - 100;
    const dashLength = 10.0;
    const spaceLength = 5.0;
    while (startX < centerX + 100) {
      path.moveTo(startX, centerY + 80);
      path.lineTo(min(startX + dashLength, centerX + 100), centerY + 80);
      startX += dashLength + spaceLength;
    }
    canvas.drawPath(path, dashPaint);

    // Gradient arc
    final arcRect = Rect.fromCenter(center: Offset(centerX, centerY + 100), width: 120, height: 120);
    final arcPaint = Paint()
      ..shader = SweepGradient(colors: [Colors.red, Colors.yellow, Colors.green])
          .createShader(arcRect)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 10
      ..strokeCap = StrokeCap.round;
    canvas.drawArc(arcRect, 0, 2.5, false, arcPaint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
