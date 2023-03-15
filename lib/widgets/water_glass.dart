import 'package:flutter/material.dart';
//Add this CustomPaint widget to the Widget Tree

//Copy this CustomPainter code to the Bottom of the File
class RPSCustomPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    Path path_0 = Path();
    path_0.moveTo(0, 0);
    path_0.lineTo(0, size.height);
    path_0.lineTo(size.width, size.height);
    path_0.lineTo(size.width, 0);
    path_0.lineTo(0, 0);
    path_0.close();

    Paint paint_0_fill = Paint()..style = PaintingStyle.fill;
    paint_0_fill.color = Color(0xffffffff).withOpacity(1.0);
    canvas.drawPath(path_0, paint_0_fill);

    Path path_1 = Path();
    path_1.moveTo(size.width * 0.1526946, size.height * 0.08383234);
    path_1.cubicTo(
        size.width * 0.2467234,
        size.height * 0.1053260,
        size.width * 0.3415509,
        size.height * 0.1007228,
        size.width * 0.4371257,
        size.height * 0.1049084);
    path_1.cubicTo(
        size.width * 0.5695629,
        size.height * 0.1107081,
        size.width * 0.7144461,
        size.height * 0.1135329,
        size.width * 0.8443114,
        size.height * 0.08383234);
    path_1.cubicTo(
        size.width * 0.8362485,
        size.height * 0.07065329,
        size.width * 0.8196647,
        size.height * 0.07044132,
        size.width * 0.8053892,
        size.height * 0.06812515);
    path_1.cubicTo(
        size.width * 0.7685898,
        size.height * 0.06215509,
        size.width * 0.7315180,
        size.height * 0.06288443,
        size.width * 0.6946108,
        size.height * 0.05937186);
    path_1.cubicTo(
        size.width * 0.5614042,
        size.height * 0.04669551,
        size.width * 0.4266886,
        size.height * 0.05657066,
        size.width * 0.2934132,
        size.height * 0.05983653);
    path_1.cubicTo(
        size.width * 0.2592898,
        size.height * 0.06067246,
        size.width * 0.2254524,
        size.height * 0.06371377,
        size.width * 0.1916168,
        size.height * 0.06847186);
    path_1.cubicTo(
        size.width * 0.1776572,
        size.height * 0.07043503,
        size.width * 0.1611323,
        size.height * 0.07151407,
        size.width * 0.1526946,
        size.height * 0.08383234);
    path_1.close();

    Paint paint_1_fill = Paint()..style = PaintingStyle.fill;
    paint_1_fill.color = Color(0xffafdbe9).withOpacity(1.0);
    canvas.drawPath(path_1, paint_1_fill);

    Path path_2 = Path();
    path_2.moveTo(size.width * 0.1526946, size.height * 0.08383234);
    path_2.cubicTo(
        size.width * 0.1540066,
        size.height * 0.1473934,
        size.width * 0.1663865,
        size.height * 0.2122174,
        size.width * 0.1731560,
        size.height * 0.2754491);
    path_2.cubicTo(
        size.width * 0.1879012,
        size.height * 0.4131766,
        size.width * 0.2042757,
        size.height * 0.5507904,
        size.width * 0.2180569,
        size.height * 0.6886228);
    path_2.cubicTo(
        size.width * 0.2234410,
        size.height * 0.7424701,
        size.width * 0.2281057,
        size.height * 0.7966527,
        size.width * 0.2352563,
        size.height * 0.8502994);
    path_2.cubicTo(
        size.width * 0.2374635,
        size.height * 0.8668563,
        size.width * 0.2346949,
        size.height * 0.8934790,
        size.width * 0.2464608,
        size.height * 0.9065120);
    path_2.cubicTo(
        size.width * 0.2669069,
        size.height * 0.9291617,
        size.width * 0.3160749,
        size.height * 0.9309192,
        size.width * 0.3443114,
        size.height * 0.9349431);
    path_2.cubicTo(
        size.width * 0.4406647,
        size.height * 0.9486707,
        size.width * 0.5411168,
        size.height * 0.9458892,
        size.width * 0.6377246,
        size.height * 0.9369012);
    path_2.cubicTo(
        size.width * 0.6666856,
        size.height * 0.9342066,
        size.width * 0.7375988,
        size.height * 0.9313892,
        size.width * 0.7544192,
        size.height * 0.9035539);
    path_2.cubicTo(
        size.width * 0.7648713,
        size.height * 0.8862575,
        size.width * 0.7619072,
        size.height * 0.8550240,
        size.width * 0.7643263,
        size.height * 0.8353293);
    path_2.cubicTo(
        size.width * 0.7710479,
        size.height * 0.7805808,
        size.width * 0.7764551,
        size.height * 0.7255479,
        size.width * 0.7819431,
        size.height * 0.6706587);
    path_2.cubicTo(
        size.width * 0.7948263,
        size.height * 0.5418234,
        size.width * 0.8100659,
        size.height * 0.4131737,
        size.width * 0.8238503,
        size.height * 0.2844311);
    path_2.cubicTo(
        size.width * 0.8309222,
        size.height * 0.2183671,
        size.width * 0.8442665,
        size.height * 0.1502820,
        size.width * 0.8443114,
        size.height * 0.08383234);
    path_2.cubicTo(
        size.width * 0.6996826,
        size.height * 0.1169886,
        size.width * 0.5397904,
        size.height * 0.1113710,
        size.width * 0.3922156,
        size.height * 0.1049084);
    path_2.cubicTo(
        size.width * 0.3112725,
        size.height * 0.1013635,
        size.width * 0.2321934,
        size.height * 0.1020138,
        size.width * 0.1526946,
        size.height * 0.08383234);
    path_2.close();

    Paint paint_2_fill = Paint()..style = PaintingStyle.fill;
    paint_2_fill.color = Color(0xffa1cddd).withOpacity(1.0);
    canvas.drawPath(path_2, paint_2_fill);

    Path path_3 = Path();
    path_3.moveTo(size.width * 0.1586826, size.height * 0.08383234);
    path_3.lineTo(size.width * 0.1616766, size.height * 0.08682635);
    path_3.lineTo(size.width * 0.1586826, size.height * 0.08383234);
    path_3.close();

    Paint paint_3_fill = Paint()..style = PaintingStyle.fill;
    paint_3_fill.color = Color(0xffa9d3e3).withOpacity(1.0);
    canvas.drawPath(path_3, paint_3_fill);

    Path path_4 = Path();
    path_4.moveTo(size.width * 0.8353293, size.height * 0.08383234);
    path_4.lineTo(size.width * 0.8383234, size.height * 0.08682635);
    path_4.lineTo(size.width * 0.8353293, size.height * 0.08383234);
    path_4.close();

    Paint paint_4_fill = Paint()..style = PaintingStyle.fill;
    paint_4_fill.color = Color(0xffabd6e6).withOpacity(1.0);
    canvas.drawPath(path_4, paint_4_fill);

    Path path_5 = Path();
    path_5.moveTo(size.width * 0.1676647, size.height * 0.08682635);
    path_5.lineTo(size.width * 0.1706587, size.height * 0.08982036);
    path_5.lineTo(size.width * 0.1676647, size.height * 0.08682635);
    path_5.moveTo(size.width * 0.8263473, size.height * 0.08682635);
    path_5.lineTo(size.width * 0.8293413, size.height * 0.08982036);
    path_5.lineTo(size.width * 0.8263473, size.height * 0.08682635);
    path_5.moveTo(size.width * 0.1826347, size.height * 0.08982036);
    path_5.lineTo(size.width * 0.1856287, size.height * 0.09281437);
    path_5.lineTo(size.width * 0.1826347, size.height * 0.08982036);
    path_5.close();

    Paint paint_5_fill = Paint()..style = PaintingStyle.fill;
    paint_5_fill.color = Color(0xffa9d3e3).withOpacity(1.0);
    canvas.drawPath(path_5, paint_5_fill);

    Path path_6 = Path();
    path_6.moveTo(size.width * 0.1856287, size.height * 0.08982036);
    path_6.lineTo(size.width * 0.1886228, size.height * 0.09281437);
    path_6.lineTo(size.width * 0.1856287, size.height * 0.08982036);
    path_6.close();

    Paint paint_6_fill = Paint()..style = PaintingStyle.fill;
    paint_6_fill.color = Color(0xffabd6e6).withOpacity(1.0);
    canvas.drawPath(path_6, paint_6_fill);

    Path path_7 = Path();
    path_7.moveTo(size.width * 0.8133743, size.height * 0.09081826);
    path_7.lineTo(size.width * 0.8153683, size.height * 0.09181647);
    path_7.lineTo(size.width * 0.8133743, size.height * 0.09081826);
    path_7.moveTo(size.width * 0.2025949, size.height * 0.09381228);
    path_7.lineTo(size.width * 0.2045907, size.height * 0.09481048);
    path_7.lineTo(size.width * 0.2025949, size.height * 0.09381228);
    path_7.close();

    Paint paint_7_fill = Paint()..style = PaintingStyle.fill;
    paint_7_fill.color = Color(0xffa9d3e3).withOpacity(1.0);
    canvas.drawPath(path_7, paint_7_fill);

    Path path_8 = Path();
    path_8.moveTo(size.width * 0.2065868, size.height * 0.09281437);
    path_8.lineTo(size.width * 0.2095808, size.height * 0.09580838);
    path_8.lineTo(size.width * 0.2065868, size.height * 0.09281437);
    path_8.close();

    Paint paint_8_fill = Paint()..style = PaintingStyle.fill;
    paint_8_fill.color = Color(0xffabd6e6).withOpacity(1.0);
    canvas.drawPath(path_8, paint_8_fill);

    Path path_9 = Path();
    path_9.moveTo(size.width * 0.7924162, size.height * 0.09381228);
    path_9.lineTo(size.width * 0.7944102, size.height * 0.09481048);
    path_9.lineTo(size.width * 0.7924162, size.height * 0.09381228);
    path_9.moveTo(size.width * 0.2275449, size.height * 0.09580838);
    path_9.lineTo(size.width * 0.2275449, size.height * 0.09880240);
    path_9.lineTo(size.width * 0.2365269, size.height * 0.09880240);
    path_9.lineTo(size.width * 0.2275449, size.height * 0.09580838);
    path_9.close();

    Paint paint_9_fill = Paint()..style = PaintingStyle.fill;
    paint_9_fill.color = Color(0xffa9d3e3).withOpacity(1.0);
    canvas.drawPath(path_9, paint_9_fill);

    Path path_10 = Path();
    path_10.moveTo(size.width * 0.7604790, size.height * 0.09580838);
    path_10.lineTo(size.width * 0.7634731, size.height * 0.09880240);
    path_10.lineTo(size.width * 0.7604790, size.height * 0.09580838);
    path_10.close();

    Paint paint_10_fill = Paint()..style = PaintingStyle.fill;
    paint_10_fill.color = Color(0xffabd6e6).withOpacity(1.0);
    canvas.drawPath(path_10, paint_10_fill);

    Path path_11 = Path();
    path_11.moveTo(size.width * 0.7654701, size.height * 0.09680629);
    path_11.lineTo(size.width * 0.7674641, size.height * 0.09780449);
    path_11.lineTo(size.width * 0.7654701, size.height * 0.09680629);
    path_11.moveTo(size.width * 0.2634731, size.height * 0.09880240);
    path_11.lineTo(size.width * 0.2634731, size.height * 0.1017964);
    path_11.lineTo(size.width * 0.2754491, size.height * 0.1017964);
    path_11.lineTo(size.width * 0.2634731, size.height * 0.09880240);
    path_11.moveTo(size.width * 0.7215569, size.height * 0.09880240);
    path_11.lineTo(size.width * 0.7215569, size.height * 0.1017964);
    path_11.lineTo(size.width * 0.7335329, size.height * 0.1017964);
    path_11.lineTo(size.width * 0.7215569, size.height * 0.09880240);
    path_11.moveTo(size.width * 0.3143713, size.height * 0.1017964);
    path_11.lineTo(size.width * 0.3143713, size.height * 0.1047904);
    path_11.lineTo(size.width * 0.3323353, size.height * 0.1047904);
    path_11.lineTo(size.width * 0.3143713, size.height * 0.1017964);
    path_11.moveTo(size.width * 0.6646707, size.height * 0.1017964);
    path_11.lineTo(size.width * 0.6646707, size.height * 0.1047904);
    path_11.lineTo(size.width * 0.6826347, size.height * 0.1047904);
    path_11.lineTo(size.width * 0.6646707, size.height * 0.1017964);
    path_11.moveTo(size.width * 0.4041916, size.height * 0.1047904);
    path_11.lineTo(size.width * 0.4041916, size.height * 0.1077844);
    path_11.lineTo(size.width * 0.4491018, size.height * 0.1077844);
    path_11.lineTo(size.width * 0.4041916, size.height * 0.1047904);
    path_11.close();

    Paint paint_11_fill = Paint()..style = PaintingStyle.fill;
    paint_11_fill.color = Color(0xffa9d3e3).withOpacity(1.0);
    canvas.drawPath(path_11, paint_11_fill);

    Path path_12 = Path();
    path_12.moveTo(size.width * 0.4491018, size.height * 0.1047904);
    path_12.lineTo(size.width * 0.4520958, size.height * 0.1077844);
    path_12.lineTo(size.width * 0.4491018, size.height * 0.1047904);
    path_12.close();

    Paint paint_12_fill = Paint()..style = PaintingStyle.fill;
    paint_12_fill.color = Color(0xffabd6e6).withOpacity(1.0);
    canvas.drawPath(path_12, paint_12_fill);

    Path path_13 = Path();
    path_13.moveTo(size.width * 0.5479042, size.height * 0.1047904);
    path_13.lineTo(size.width * 0.5479042, size.height * 0.1077844);
    path_13.lineTo(size.width * 0.5958084, size.height * 0.1077844);
    path_13.lineTo(size.width * 0.5479042, size.height * 0.1047904);
    path_13.close();

    Paint paint_13_fill = Paint()..style = PaintingStyle.fill;
    paint_13_fill.color = Color(0xffa9d3e3).withOpacity(1.0);
    canvas.drawPath(path_13, paint_13_fill);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
