// import 'dart:math';

// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:intl/intl.dart';
// import 'package:procrastinator/Theme/color_scheme_my.dart';

// import '../../../../Theme/app_theme_light.dart';
// import '../../../../fake_data/user_fake_data/user_fake_data.dart';

// class StatisticCircleNew extends StatefulWidget {
//   const StatisticCircleNew({super.key});

//   @override
//   State<StatisticCircleNew> createState() => _StatisticCircleNewState();
// }

// class _StatisticCircleNewState extends State<StatisticCircleNew> {
//   final user = userPitty;
//   var percent = NumberFormat("##%");

//   var totalVisits = userPitty.userGroup!.daysQty;
//   var userVisits = userPitty.userVisits;
//   // var homeOffice = userPitty.userVisits;

//   double? schoolVisitsQty() {
//     double qty = 0;
//     for (var element in userVisits!) {
//       if (element.type.contains('Schule')) {
//         qty++;
//       }
//     }
//     return qty;
//   }

//   double? homeOfficeQty() {
//     double qty = 0;
//     for (var element in userVisits!) {
//       if (element.type.contains('Heim')) {
//         qty++;
//       }
//     }
//     return qty;
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       height: 500,
//       constraints: const BoxConstraints(maxWidth: 600, maxHeight: 600),
//       decoration: BoxDecoration(
//         color: MyAppColorScheme.primaryBackground,
//         borderRadius: BorderRadius.circular(20),
//       ),
//       child: Center(
//         child: Column(
//           children: [
//             Padding(
//               padding: const EdgeInsets.all(8.0),
//               child: Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 mainAxisSize: MainAxisSize.max,
//                 children: [
//                   Padding(
//                     padding: const EdgeInsets.all(8.0),
//                     child: Text(
//                       '${user.userName} Anmeldungen',
//                       style: MyAppThemeLight.themeLight.textTheme.titleLarge,
//                     ),
//                   ),
//                   IconButton(
//                       onPressed: () {},
//                       icon: const Icon(Icons.cloud_download_rounded))
//                 ],
//               ),
//             ),
//             Padding(
//               padding: const EdgeInsets.only(top: 44, bottom: 32),
//               child: SizedBox(
//                   height: 220,
//                   width: 220,
//                   child: Center(
//                     child: Stack(
//                       children: [
//                         CircularProgressIndicator(
//                           strokeWidth: 44,
//                           value: schoolVisitsQty()! / totalVisits,
//                         ),
//                         CircularProgressIndicator(
//                           strokeWidth: 44,
//                           color: MyAppColorScheme.secondary,
//                           value: homeOfficeQty()! / totalVisits,
//                         ),
//                       ],
//                     ),
//                   )

//                   // CustomPaint(painter: RadialDiagramm()),
//                   ),
//             ),
//             Padding(
//               padding: const EdgeInsets.all(20),
//               child: Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 mainAxisSize: MainAxisSize.max,
//                 children: [
//                   Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       // if (user.userVisits!.length  >= 0){
//                       //   return
//                       // }
//                       Text('${schoolVisitsQty()!.toInt()} Tage oder',
//                           style:
//                               MyAppThemeLight.themeLight.textTheme.bodyLarge),
//                       Text(
//                         '${(percent.format(schoolVisitsQty()!.toInt() / user.userGroup!.daysQty)).toString()} ',
//                         style: const TextStyle(
//                             color: MyAppColorScheme.primary,
//                             fontSize: 32,
//                             fontWeight: FontWeight.w700),

//                         //
//                         overflow: TextOverflow.ellipsis,
//                       ),
//                       Text(
//                         'im Schule',
//                         style: MyAppThemeLight.themeLight.textTheme.bodyLarge,
//                         //
//                         overflow: TextOverflow.ellipsis,
//                       ),
//                     ],
//                   ),
//                   Column(
//                     crossAxisAlignment: CrossAxisAlignment.end,
//                     children: [
//                       Text(
//                         '${homeOfficeQty()!.toInt()} Tage oder',
//                         style: MyAppThemeLight.themeLight.textTheme.bodyLarge,
//                       ),
//                       Text(
//                         '${(percent.format(homeOfficeQty()!.toInt() / user.userGroup!.daysQty)).toString()}',
//                         style: const TextStyle(
//                             color: MyAppColorScheme.secondary,
//                             fontSize: 32,
//                             fontWeight: FontWeight.w700),
//                         //
//                         overflow: TextOverflow.ellipsis,
//                       ),
//                       Text(
//                         'Zuhause',
//                         style: MyAppThemeLight.themeLight.textTheme.bodyLarge,
//                         //
//                         overflow: TextOverflow.ellipsis,
//                       ),
//                     ],
//                   )
//                 ],
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

// class RadialDiagramm extends CustomPainter {
// // final _kursplanQueryList = fakeDataLessons;
// //   final _studentLessonsList = fakeAnmeldungen;

//   // var totalVisits;
//   // var schoolVisits;
//   // var homeOffice;

//   var totalVisits = 256;
//   var schoolVisits = 120;
//   var homeOffice = 65;

//   // var schoolPrecent = schoolVisits / totalVisits;
//   // var homePrecent = homeOffice / totalVisits;

//   @override
//   void paint(Canvas canvas, Size size) {
//     var schoolPrecent = schoolVisits / totalVisits;
//     var homePrecent = homeOffice / totalVisits;

//     final backgroundPaint = Paint();
//     backgroundPaint.color = Color.fromARGB(255, 240, 240, 240);
//     backgroundPaint.style = PaintingStyle.stroke;
//     backgroundPaint.strokeWidth = 44;
//     canvas.drawArc(Offset(2.5, 2.5) & Size(size.width - 22, size.height - 22),
//         pi, pi * 4, false, backgroundPaint);

//     final schoolPaint = Paint();
//     schoolPaint.color = MyAppColorScheme.primary;
//     schoolPaint.style = PaintingStyle.stroke;
//     schoolPaint.strokeWidth = 44;
//     canvas.drawArc(Offset(2.5, 2.5) & Size(size.width - 22, size.height - 22),
//         pi / 2, pi * 2 * schoolPrecent, false, schoolPaint);

//     final homePaint = Paint();
//     homePaint.color = MyAppColorScheme.secondary;
//     homePaint.style = PaintingStyle.stroke;
//     homePaint.strokeWidth = 44;
//     canvas.drawArc(Offset(2.5, 2.5) & Size(size.width - 22, size.height - 22),
//         pi / 2, pi * 2 * -homePrecent, false, homePaint);
//   }

//   @override
//   bool shouldRepaint(covariant CustomPainter oldDelegate) {
//     return true;
//   }
// }
