import 'package:core_kit/core_kit_internal.dart';
import 'package:flutter/material.dart';

const _peach = Color(0xFFE8C4B0);
const _ink = Color(0xFF1F2937);
const _gold = Color(0xFFC4A35A);

class SplashBackdrop extends StatelessWidget {
  const SplashBackdrop({super.key});

  @override
  Widget build(BuildContext context) {
    return IgnorePointer(
      child: Stack(
        children: [
          Positioned(
            top: -90.h,
            left: -80.w,
            child: const _PeachBlob(size: 260),
          ),
          Positioned(
            top: -70.h,
            right: -90.w,
            child: const _PeachBlob(size: 220, opacity: 0.32),
          ),
          Positioned(
            bottom: -100.h,
            left: -70.w,
            child: const _PeachBlob(size: 280, opacity: 0.4),
          ),
          Positioned(
            bottom: -80.h,
            right: -60.w,
            child: const _PeachBlob(size: 240, opacity: 0.36),
          ),
          Positioned(
            top: 52.h,
            left: 18.w,
            child: Transform.rotate(
              angle: -0.55,
              child: Opacity(
                opacity: 0.16,
                child: CustomPaint(
                  size: Size(42.w, 88.h),
                  painter: const _MakeupBrushPainter(),
                ),
              ),
            ),
          ),
          Positioned(
            top: 64.h,
            right: 22.w,
            child: Transform.rotate(
              angle: 0.45,
              child: Opacity(
                opacity: 0.13,
                child: CustomPaint(
                  size: Size(54.w, 54.w),
                  painter: const _ScissorsPainter(),
                ),
              ),
            ),
          ),
          Positioned(
            bottom: 90.h,
            left: 8.w,
            child: Transform.rotate(
              angle: -0.7,
              child: Opacity(
                opacity: 0.2,
                child: CustomPaint(
                  size: Size(56.w, 120.h),
                  painter: const _MakeupBrushPainter(),
                ),
              ),
            ),
          ),
          Positioned(
            bottom: 72.h,
            right: 16.w,
            child: Transform.rotate(
              angle: 0.35,
              child: Opacity(
                opacity: 0.18,
                child: CustomPaint(
                  size: Size(44.w, 92.h),
                  painter: const _CombPainter(),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class AmarStyleLogo extends StatelessWidget {
  const AmarStyleLogo({super.key, this.height = 148});

  final double height;

  @override
  Widget build(BuildContext context) {
    final width = height * 0.7;

    return SizedBox(
      width: width,
      height: height,
      child: Stack(
        alignment: Alignment.topCenter,
        children: [
          CustomPaint(
            size: Size(width, height),
            painter: const _MirrorPainter(),
          ),
          Positioned(
            top: height * 0.2,
            child: Text.rich(
              TextSpan(
                children: [
                  TextSpan(
                    text: 'A',
                    style: TextStyle(
                      fontFamily: 'Georgia',
                      fontSize: height * 0.26,
                      fontWeight: FontWeight.w700,
                      color: _ink,
                      height: 1,
                    ),
                  ),
                  TextSpan(
                    text: 'S',
                    style: TextStyle(
                      fontFamily: 'Georgia',
                      fontSize: height * 0.26,
                      fontWeight: FontWeight.w700,
                      color: _gold,
                      height: 1,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class SplashPageIndicator extends StatelessWidget {
  const SplashPageIndicator({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: 22.w,
          height: 8.h,
          decoration: BoxDecoration(
            color: const Color(0xFF4B5563),
            borderRadius: BorderRadius.circular(20.w),
          ),
        ),
        8.width,
        const _IndicatorDot(),
        8.width,
        const _IndicatorDot(),
      ],
    );
  }
}

class _IndicatorDot extends StatelessWidget {
  const _IndicatorDot();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 8.w,
      height: 8.w,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(color: const Color(0xFF9CA3AF), width: 1.4),
      ),
    );
  }
}

class _PeachBlob extends StatelessWidget {
  const _PeachBlob({required this.size, this.opacity = 0.42});

  final double size;
  final double opacity;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size.w,
      height: size.w,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        gradient: RadialGradient(
          colors: [
            _peach.withValues(alpha: opacity),
            _peach.withValues(alpha: 0),
          ],
        ),
      ),
    );
  }
}

class _MirrorPainter extends CustomPainter {
  const _MirrorPainter();

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = _ink
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2.2
      ..strokeCap = StrokeCap.round
      ..strokeJoin = StrokeJoin.round;

    final oval = Rect.fromCenter(
      center: Offset(size.width / 2, size.height * 0.36),
      width: size.width * 0.78,
      height: size.height * 0.58,
    );
    canvas.drawOval(oval, paint);
    canvas.drawOval(oval.deflate(6), paint);

    final cx = size.width / 2;
    final stemTop = oval.bottom - 1;
    final stemBottom = size.height * 0.74;
    const stemHalf = 5.5;

    final stem = Path()
      ..moveTo(cx - stemHalf, stemTop)
      ..lineTo(cx - stemHalf, stemBottom)
      ..moveTo(cx + stemHalf, stemTop)
      ..lineTo(cx + stemHalf, stemBottom);
    canvas.drawPath(stem, paint);

    canvas.drawOval(
      Rect.fromCenter(
        center: Offset(cx, size.height * 0.84),
        width: 22,
        height: 28,
      ),
      paint,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

class _MakeupBrushPainter extends CustomPainter {
  const _MakeupBrushPainter();

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = _ink
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.7
      ..strokeCap = StrokeCap.round
      ..strokeJoin = StrokeJoin.round;

    final cx = size.width / 2;
    final handleTop = size.height * 0.42;
    final ferruleBottom = size.height * 0.48;

    canvas.drawRRect(
      RRect.fromRectAndRadius(
        Rect.fromCenter(
          center: Offset(cx, (handleTop + size.height) / 2),
          width: size.width * 0.22,
          height: size.height * 0.52,
        ),
        const Radius.circular(4),
      ),
      paint,
    );

    canvas.drawRRect(
      RRect.fromRectAndRadius(
        Rect.fromLTWH(
          cx - size.width * 0.16,
          handleTop,
          size.width * 0.32,
          ferruleBottom - handleTop + 4,
        ),
        const Radius.circular(2),
      ),
      paint,
    );

    final bristleTop = Offset(cx, size.height * 0.04);
    final left = Offset(cx - size.width * 0.42, handleTop);
    final right = Offset(cx + size.width * 0.42, handleTop);
    canvas.drawLine(left, bristleTop, paint);
    canvas.drawLine(right, bristleTop, paint);
    canvas.drawLine(
      Offset(cx - size.width * 0.18, handleTop),
      bristleTop,
      paint,
    );
    canvas.drawLine(
      Offset(cx + size.width * 0.18, handleTop),
      bristleTop,
      paint,
    );
    canvas.drawLine(Offset(cx, handleTop), bristleTop, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

class _ScissorsPainter extends CustomPainter {
  const _ScissorsPainter();

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = _ink
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.7
      ..strokeCap = StrokeCap.round
      ..strokeJoin = StrokeJoin.round;

    final pivot = Offset(size.width * 0.42, size.height * 0.46);
    canvas.drawCircle(pivot, 3.2, paint);

    canvas.drawLine(pivot, Offset(size.width * 0.92, size.height * 0.1), paint);
    canvas.drawLine(
      pivot,
      Offset(size.width * 0.88, size.height * 0.28),
      paint,
    );

    canvas.drawOval(
      Rect.fromCenter(
        center: Offset(size.width * 0.22, size.height * 0.78),
        width: size.width * 0.28,
        height: size.height * 0.32,
      ),
      paint,
    );
    canvas.drawOval(
      Rect.fromCenter(
        center: Offset(size.width * 0.48, size.height * 0.82),
        width: size.width * 0.28,
        height: size.height * 0.32,
      ),
      paint,
    );

    canvas.drawLine(
      pivot,
      Offset(size.width * 0.28, size.height * 0.64),
      paint,
    );
    canvas.drawLine(
      pivot,
      Offset(size.width * 0.52, size.height * 0.66),
      paint,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

class _CombPainter extends CustomPainter {
  const _CombPainter();

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = _ink
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.7
      ..strokeCap = StrokeCap.round
      ..strokeJoin = StrokeJoin.round;

    final spine = RRect.fromRectAndRadius(
      Rect.fromLTWH(
        size.width * 0.12,
        size.height * 0.08,
        size.width * 0.76,
        size.height * 0.22,
      ),
      const Radius.circular(6),
    );
    canvas.drawRRect(spine, paint);

    final teethTop = size.height * 0.3;
    final teethBottom = size.height * 0.92;
    const count = 8;
    for (var i = 0; i < count; i++) {
      final t = i / (count - 1);
      final x = size.width * (0.22 + (0.56 * t));
      canvas.drawLine(Offset(x, teethTop), Offset(x, teethBottom), paint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
