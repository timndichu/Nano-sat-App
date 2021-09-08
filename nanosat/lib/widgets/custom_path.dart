import 'package:flutter/material.dart';
import 'dart:math' as math;


class BezierClipper extends CustomClipper<Path> {
  @override
Path getClip(Size size) {
    Path path = Path();
    final double _xScaling = size.width / 177;
    final double _yScaling = size.height / 90;
    path.lineTo(0 * _xScaling,27 * _yScaling);
    path.cubicTo(0 * _xScaling,27 * _yScaling,0 * _xScaling,63 * _yScaling,0 * _xScaling,63 * _yScaling,);
    path.cubicTo(0 * _xScaling,74.2492 * _yScaling,0 * _xScaling,79.8738 * _yScaling,2.86475 * _xScaling,83.8168 * _yScaling,);
    path.cubicTo(3.78994 * _xScaling,85.0902 * _yScaling,4.9098 * _xScaling,86.2101 * _yScaling,6.18322 * _xScaling,87.1353 * _yScaling,);
    path.cubicTo(10.1262 * _xScaling,90 * _yScaling,15.7508 * _xScaling,90 * _yScaling,27 * _xScaling,90 * _yScaling,);
    path.cubicTo(27 * _xScaling,90 * _yScaling,103.272 * _xScaling,90 * _yScaling,103.272 * _xScaling,90 * _yScaling,);
    path.cubicTo(109.627 * _xScaling,90 * _yScaling,112.804 * _xScaling,90 * _yScaling,115.59 * _xScaling,88.8298 * _yScaling,);
    path.cubicTo(116.507 * _xScaling,88.4445 * _yScaling,117.384 * _xScaling,87.969 * _yScaling,118.207 * _xScaling,87.4102 * _yScaling,);
    path.cubicTo(120.707 * _xScaling,85.7127 * _yScaling,122.44 * _xScaling,83.0494 * _yScaling,125.905 * _xScaling,77.723 * _yScaling,);
    path.cubicTo(125.905 * _xScaling,77.723 * _yScaling,149.324 * _xScaling,41.723 * _yScaling,149.324 * _xScaling,41.723 * _yScaling,);
    path.cubicTo(159.863 * _xScaling,25.5212 * _yScaling,165.133 * _xScaling,17.4204 * _yScaling,163.219 * _xScaling,10.8219 * _yScaling,);
    path.cubicTo(162.619 * _xScaling,8.75138 * _yScaling,161.579 * _xScaling,6.83464 * _yScaling,160.171 * _xScaling,5.20224 * _yScaling,);
    path.cubicTo(155.683 * _xScaling,0 * _yScaling,146.019 * _xScaling,0 * _yScaling,126.691 * _xScaling,0 * _yScaling,);
    path.cubicTo(126.691 * _xScaling,0 * _yScaling,27 * _xScaling,0 * _yScaling,27 * _xScaling,0 * _yScaling,);
    path.cubicTo(15.7508 * _xScaling,0 * _yScaling,10.1262 * _xScaling,0 * _yScaling,6.18322 * _xScaling,2.86475 * _yScaling,);
    path.cubicTo(4.9098 * _xScaling,3.78994 * _yScaling,3.78994 * _xScaling,4.9098 * _yScaling,2.86475 * _xScaling,6.18322 * _yScaling,);
    path.cubicTo(0 * _xScaling,10.1262 * _yScaling,0 * _xScaling,15.7508 * _yScaling,0 * _xScaling,27 * _yScaling,);
    path.cubicTo(0 * _xScaling,27 * _yScaling,0 * _xScaling,27 * _yScaling,0 * _xScaling,27 * _yScaling,);
    return path;
  }

  @override
  bool shouldReclip(oldClipper) => true;
}

class BezierClipper2 extends CustomClipper<Path> {
 @override
  Path getClip(Size size) {
    Path path = Path();
    final double _xScaling = size.width / 177;
    final double _yScaling = size.height / 90;
    path.lineTo(0 * _xScaling,63 * _yScaling);
    path.cubicTo(0 * _xScaling,63 * _yScaling,0 * _xScaling,27 * _yScaling,0 * _xScaling,27 * _yScaling,);
    path.cubicTo(0 * _xScaling,15.7508 * _yScaling,0 * _xScaling,10.1262 * _yScaling,2.86475 * _xScaling,6.18322 * _yScaling,);
    path.cubicTo(3.78994 * _xScaling,4.9098 * _yScaling,4.9098 * _xScaling,3.78994 * _yScaling,6.18322 * _xScaling,2.86475 * _yScaling,);
    path.cubicTo(10.1262 * _xScaling,0 * _yScaling,15.7508 * _xScaling,0 * _yScaling,27 * _xScaling,0 * _yScaling,);
    path.cubicTo(27 * _xScaling,0 * _yScaling,103.654 * _xScaling,0 * _yScaling,103.654 * _xScaling,0 * _yScaling,);
    path.cubicTo(109.998 * _xScaling,0 * _yScaling,113.17 * _xScaling,0 * _yScaling,115.953 * _xScaling,1.16702 * _yScaling,);
    path.cubicTo(116.869 * _xScaling,1.55122 * _yScaling,117.745 * _xScaling,2.02549 * _yScaling,118.568 * _xScaling,2.58284 * _yScaling,);
    path.cubicTo(121.066 * _xScaling,4.27583 * _yScaling,122.799 * _xScaling,6.93246 * _yScaling,126.266 * _xScaling,12.2457 * _yScaling,);
    path.cubicTo(126.266 * _xScaling,12.2457 * _yScaling,149.756 * _xScaling,48.2457 * _yScaling,149.756 * _xScaling,48.2457 * _yScaling,);
    path.cubicTo(160.333 * _xScaling,64.4561 * _yScaling,165.621 * _xScaling,72.5612 * _yScaling,163.712 * _xScaling,79.1661 * _yScaling,);
    path.cubicTo(163.113 * _xScaling,81.2385 * _yScaling,162.074 * _xScaling,83.1572 * _yScaling,160.665 * _xScaling,84.7915 * _yScaling,);
    path.cubicTo(156.177 * _xScaling,90 * _yScaling,146.499 * _xScaling,90 * _yScaling,127.143 * _xScaling,90 * _yScaling,);
    path.cubicTo(127.143 * _xScaling,90 * _yScaling,27 * _xScaling,90 * _yScaling,27 * _xScaling,90 * _yScaling,);
    path.cubicTo(15.7508 * _xScaling,90 * _yScaling,10.1262 * _xScaling,90 * _yScaling,6.18322 * _xScaling,87.1353 * _yScaling,);
    path.cubicTo(4.9098 * _xScaling,86.2101 * _yScaling,3.78994 * _xScaling,85.0902 * _yScaling,2.86475 * _xScaling,83.8168 * _yScaling,);
    path.cubicTo(0 * _xScaling,79.8738 * _yScaling,0 * _xScaling,74.2492 * _yScaling,0 * _xScaling,63 * _yScaling,);
    path.cubicTo(0 * _xScaling,63 * _yScaling,0 * _xScaling,63 * _yScaling,0 * _xScaling,63 * _yScaling,);
    return path;
  }
  
  @override
  bool shouldReclip(oldClipper) => true;
}


class LandingPageClipper extends CustomClipper<Path> {
 @override
  Path getClip(Size size) {
    Path path = Path();
    final double _xScaling = size.width / 360;
    final double _yScaling = size.height / 400;
    path.lineTo(0 * _xScaling,326 * _yScaling);
    path.cubicTo(0 * _xScaling,326 * _yScaling,0 * _xScaling,0 * _yScaling,0 * _xScaling,0 * _yScaling,);
    path.cubicTo(0 * _xScaling,0 * _yScaling,360 * _xScaling,0 * _yScaling,360 * _xScaling,0 * _yScaling,);
    path.cubicTo(360 * _xScaling,0 * _yScaling,360 * _xScaling,296.5 * _yScaling,360 * _xScaling,296.5 * _yScaling,);
    path.cubicTo(360 * _xScaling,296.5 * _yScaling,338.883 * _xScaling,326 * _yScaling,305.698 * _xScaling,326 * _yScaling,);
    path.cubicTo(272.514 * _xScaling,326 * _yScaling,212.179 * _xScaling,276.5 * _yScaling,166.927 * _xScaling,273 * _yScaling,);
    path.cubicTo(121.676 * _xScaling,269.5 * _yScaling,0 * _xScaling,326 * _yScaling,0 * _xScaling,326 * _yScaling,);
    path.cubicTo(0 * _xScaling,326 * _yScaling,0 * _xScaling,326 * _yScaling,0 * _xScaling,326 * _yScaling,);
    return path;
  }
  
  @override
  bool shouldReclip(oldClipper) => true;
}

class LandingPageClipper2 extends CustomClipper<Path> {
 @override
  Path getClip(Size size) {
    Path path = Path();
    final double _xScaling = size.width / 360;
    final double _yScaling = size.height / 392;
    path.lineTo(0 * _xScaling,326 * _yScaling);
    path.cubicTo(0 * _xScaling,326 * _yScaling,0 * _xScaling,0 * _yScaling,0 * _xScaling,0 * _yScaling,);
    path.cubicTo(0 * _xScaling,0 * _yScaling,360 * _xScaling,0 * _yScaling,360 * _xScaling,0 * _yScaling,);
    path.cubicTo(360 * _xScaling,0 * _yScaling,360 * _xScaling,296.5 * _yScaling,360 * _xScaling,296.5 * _yScaling,);
    path.cubicTo(360 * _xScaling,296.5 * _yScaling,338.883 * _xScaling,326 * _yScaling,305.698 * _xScaling,326 * _yScaling,);
    path.cubicTo(272.514 * _xScaling,326 * _yScaling,212.179 * _xScaling,276.5 * _yScaling,166.927 * _xScaling,273 * _yScaling,);
    path.cubicTo(121.676 * _xScaling,269.5 * _yScaling,0 * _xScaling,326 * _yScaling,0 * _xScaling,326 * _yScaling,);
    path.cubicTo(0 * _xScaling,326 * _yScaling,0 * _xScaling,326 * _yScaling,0 * _xScaling,326 * _yScaling,);
    return path;
  }
  
  @override
  bool shouldReclip(oldClipper) => true;
}



class MyArc extends StatelessWidget {
  final double diameter;
  final Color color;

  const MyArc({Key key, this.diameter = 200, this.color}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: MyPainter(color: color),
      size: Size(diameter, 120),
    );
  }
}

// This is the Painter class
class MyPainter extends CustomPainter {
  final Color color;
  MyPainter({this.color});
  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()..color = color;
    canvas.drawArc(
      Rect.fromCenter(
        center: Offset(size.height / 2, size.width / 2),
        height: size.height,
        width: size.width,
      ),
      math.pi,
      math.pi,
      false,
      paint,
    );
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}