import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class StatisticProgressDiagrammComponent extends StatelessWidget {
  final totalVisits;
  final schoolVisits;
  final homeOffice;

  StatisticProgressDiagrammComponent(
      {super.key,
      required this.totalVisits,
      required this.schoolVisits,
      required this.homeOffice});

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
  final totalVisits;
  final schoolVisits;
  final homeOffice;

  RadialDiagramm(
      {required this.totalVisits,
      required this.schoolVisits,
      required this.homeOffice});

  @override
  void paint(Canvas canvas, Size size) {
    var schoolPrecent = schoolVisits / totalVisits;
    var homePrecent = homeOffice / totalVisits;

    final backgroundPaint = Paint();
    backgroundPaint.color = Color.fromARGB(33, 125, 125, 125);
    backgroundPaint.style = PaintingStyle.stroke;
    backgroundPaint.strokeWidth = 58;
    canvas.drawArc(Offset(2.5, 2.5) & Size(size.width - 22, size.height - 22),
        pi, pi * 4, false, backgroundPaint);

    final homePaint = Paint();
    homePaint.color = const Color.fromARGB(230, 112, 208, 110);
    homePaint.style = PaintingStyle.stroke;
    homePaint.strokeWidth = 44;
    homePaint.strokeCap = StrokeCap.round;
    canvas.drawArc(Offset(2.5, 2.5) & Size(size.width - 22, size.height - 22),
        (pi / 8) + schoolPrecent * pi, pi * 2 * homePrecent, false, homePaint);
    final schoolPaint = Paint();
    schoolPaint.color = const Color.fromARGB(230, 50, 43, 250);
    schoolPaint.style = PaintingStyle.stroke;
    schoolPaint.strokeWidth = 44;
    schoolPaint.strokeCap = StrokeCap.round;
    canvas.drawArc(Offset(2.5, 2.5) & Size(size.width - 22, size.height - 22),
        pi + homePrecent * pi, pi * 2 * schoolPrecent, false, schoolPaint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
