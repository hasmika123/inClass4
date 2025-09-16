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
  final List<String> _emojiOptions = ['Party Face', 'Heart'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Shapes Drawing Demo'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Task 1: Basic Shapes',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            const SizedBox(height: 10),
            SizedBox(
              height: 200,
              child: CustomPaint(
                painter: BasicShapesPainter(),
                size: const Size(double.infinity, 200),
              ),
            ),
            const SizedBox(height: 20),
            const Text('Task 2: Combined Shapes (Abstract Design)',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            const SizedBox(height: 10),
            SizedBox(
              height: 300,
              child: CustomPaint(
                painter: CombinedShapesPainter(),
                size: const Size(double.infinity, 300),
              ),
            ),
            const SizedBox(height: 20),
            const Text('Task 3: Styled Shapes',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            const SizedBox(height: 10),
            SizedBox(
              height: 300,
              child: CustomPaint(
                painter: StyledShapesPainter(),
                size: const Size(double.infinity, 300),
              ),
            ),
            const SizedBox(height: 20),
            const Text('Part 1: Emoji Drawing',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            const SizedBox(height: 10),
            Row(
              children: [
                const Text('Select Emoji: '),
                DropdownButton<String>(
                  value: _selectedEmoji,
                  items: _emojiOptions
                      .map((e) => DropdownMenuItem(value: e, child: Text(e)))
                      .toList(),
                  onChanged: (value) {
                    if (value != null) {
                      setState(() {
                        _selectedEmoji = value;
                      });
                    }
                  },
                ),
              ],
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
    );
  }
}

/// CustomPainter for Party Face and Heart Emojis
class EmojiPainter extends CustomPainter {
  final String emojiType;
  EmojiPainter(this.emojiType);

  @override
  void paint(Canvas canvas, Size size) {
    if (emojiType == 'Party Face') {
      _drawPartyFace(canvas, size);
    } else {
      _drawHeart(canvas, size);
    }
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

    // Party hat with gradient
    final hatPath = Path()
      ..moveTo(center.dx, center.dy - 80)
      ..lineTo(center.dx - 30, center.dy - 120)
      ..lineTo(center.dx + 30, center.dy - 120)
      ..close();
    final hatRect = Rect.fromLTWH(center.dx - 30, center.dy - 120, 60, 40);
    final hatPaint = Paint()
      ..shader =
          LinearGradient(colors: [Colors.purple, Colors.pink]).createShader(hatRect);
    canvas.drawPath(hatPath, hatPaint);

    // Hat band
    final bandPaint = Paint()..color = Colors.blue;
    canvas.drawRect(Rect.fromLTWH(center.dx - 15, center.dy - 90, 30, 8), bandPaint);

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
    final heartPaint = Paint()
      ..shader = LinearGradient(
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        colors: [Colors.red, Colors.pinkAccent],
      ).createShader(rect);

    final path = Path();
    path.moveTo(center.dx, center.dy);
    path.cubicTo(center.dx + 60, center.dy - 80, center.dx + 120, center.dy + 40,
        center.dx, center.dy + 100);
    path.cubicTo(center.dx - 120, center.dy + 40, center.dx - 60, center.dy - 80,
        center.dx, center.dy);
    canvas.drawPath(path, heartPaint);
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
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
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
