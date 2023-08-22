import 'package:flutter/material.dart';

class IconWithTapAnimation extends StatefulWidget {
  final Icon icon;
  final VoidCallback onTap; // Add onTap callback

  IconWithTapAnimation({required this.icon, required this.onTap});

  @override
  _IconWithTapAnimationState createState() => _IconWithTapAnimationState();
}

class _IconWithTapAnimationState extends State<IconWithTapAnimation> {
  double scaleFactor = 1.0;

  void _onTapDown(TapDownDetails details) {
    setState(() {
      scaleFactor = 0.8;
    });
  }

  void _onTapUp(TapUpDetails details) {
    setState(() {
      scaleFactor = 1.0;
    });
    widget.onTap();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: _onTapDown,
      onTapUp: _onTapUp,
      onTapCancel: () {
        setState(() {
          scaleFactor = 1.0;
        });
      },
      child: AnimatedContainer(
        duration: Duration(milliseconds: 150),
        transform: Matrix4.identity()..scale(scaleFactor),
        child: widget.icon,
      ),
    );
  }
}
