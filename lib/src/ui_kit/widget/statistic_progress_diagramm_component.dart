import 'dart:math';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class StatisticProgressDiagrammComponent extends StatelessWidget {
  final int totalVisits;
  final int? schoolVisits;
  final int? homeOffice;

  const StatisticProgressDiagrammComponent(
      {super.key,
      required this.totalVisits,
      this.schoolVisits,
      this.homeOffice});

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
        painter: RadialDiagramm(
            totalVisits: totalVisits,
            schoolVisits: schoolVisits,
            homeOffice: homeOffice));
  }
}

class RadialDiagramm extends CustomPainter {
  final int totalVisits;
  final int? schoolVisits;
  final int? homeOffice;

  const RadialDiagramm(
      {required this.totalVisits, this.schoolVisits, this.homeOffice});

  @override
  void paint(Canvas canvas, Size size) {
    final schoolPrecent =
        schoolVisits != null ? schoolVisits! / totalVisits : 0;
    final homePrecent = homeOffice != null ? homeOffice! / totalVisits : 0;

    final backgroundPaint = Paint();
    backgroundPaint.color = const Color.fromARGB(33, 125, 125, 125);
    backgroundPaint.style = PaintingStyle.stroke;
    backgroundPaint.strokeWidth = 58;
    canvas.drawArc(
        const Offset(2.5, 2.5) & Size(size.width - 22, size.height - 22),
        pi,
        pi * 4,
        false,
        backgroundPaint);

    if (homeOffice != null) {
      final homePaint = Paint();
      homePaint.color = const Color.fromARGB(230, 112, 208, 110);
      homePaint.style = PaintingStyle.stroke;
      homePaint.strokeWidth = 44;
      homePaint.strokeCap = StrokeCap.round;
      canvas.drawArc(
          const Offset(2.5, 2.5) & Size(size.width - 22, size.height - 22),
          (pi / 8) + schoolPrecent * pi,
          pi * 2 * homePrecent,
          false,
          homePaint);
    }

    if (schoolVisits != null) {
      final schoolPaint = Paint();
      schoolPaint.color = const Color.fromARGB(230, 50, 43, 250);
      schoolPaint.style = PaintingStyle.stroke;
      schoolPaint.strokeWidth = 44;
      schoolPaint.strokeCap = StrokeCap.round;
      canvas.drawArc(
          const Offset(2.5, 2.5) & Size(size.width - 22, size.height - 22),
          pi + homePrecent * pi,
          pi * 2 * schoolPrecent,
          false,
          schoolPaint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
