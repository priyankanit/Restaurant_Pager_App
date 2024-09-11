import 'package:flutter/material.dart';

class CurvedContainer extends CustomClipper<Path> {
    @override
  Path getClip(Size size) {
    Path path = Path();
    final double _xScaling = size.width / 360;
    final double _yScaling = size.height / 161;
    path.lineTo(0 * _xScaling,0 * _yScaling);
    path.cubicTo(0 * _xScaling,0 * _yScaling,360 * _xScaling,0 * _yScaling,360 * _xScaling,0 * _yScaling,);
    path.cubicTo(360 * _xScaling,0 * _yScaling,360 * _xScaling,161 * _yScaling,360 * _xScaling,161 * _yScaling,);
    path.cubicTo(360 * _xScaling,161 * _yScaling,317.011 * _xScaling,161 * _yScaling,317.011 * _xScaling,161 * _yScaling,);
    path.cubicTo(291.304 * _xScaling,161 * _yScaling,266.61 * _xScaling,150.977 * _yScaling,248.175 * _xScaling,133.061 * _yScaling,);
    path.cubicTo(248.175 * _xScaling,133.061 * _yScaling,241.027 * _xScaling,126.114 * _yScaling,241.027 * _xScaling,126.114 * _yScaling,);
    path.cubicTo(204.52 * _xScaling,90.635 * _yScaling,145.779 * _xScaling,92.8297 * _yScaling,112.021 * _xScaling,130.934 * _yScaling,);
    path.cubicTo(95.0816 * _xScaling,150.054 * _yScaling,70.7614 * _xScaling,161 * _yScaling,45.2168 * _xScaling,161 * _yScaling,);
    path.cubicTo(45.2168 * _xScaling,161 * _yScaling,0 * _xScaling,161 * _yScaling,0 * _xScaling,161 * _yScaling,);
    path.cubicTo(0 * _xScaling,161 * _yScaling,0 * _xScaling,0 * _yScaling,0 * _xScaling,0 * _yScaling,);
    path.cubicTo(0 * _xScaling,0 * _yScaling,0 * _xScaling,0 * _yScaling,0 * _xScaling,0 * _yScaling,);
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<dynamic> oldClipper) {
    return false;
  }
}