import 'package:flutter/material.dart';

class AnimatedCheck extends StatefulWidget {
  final bool animate;
  final double size;

  AnimatedCheck({
    Key key,
    @required this.animate,
    this.size = 72.0,
  }) : super(key: key);

  @override
  _AnimatedCheckState createState() => _AnimatedCheckState();
}

class _AnimatedCheckState extends State<AnimatedCheck>
    with SingleTickerProviderStateMixin {
  AnimationController _animationController;
  Animation<double> _scaleAnimation;
  bool _isAnimating = false;

  @override
  void didUpdateWidget(AnimatedCheck oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (oldWidget.animate != widget.animate) {
      if (_isAnimating && !widget.animate) {
        _stop();
      }
      if (!_isAnimating && widget.animate) {
        _start();
      }
    }
  }

  void _start() {
    _animationController.forward();

    _isAnimating = true;
  }

  void _stop() {
    _animationController.stop();
    _animationController.reset();
    _isAnimating = false;
  }

  @override
  void initState() {
    super.initState();

    _animationController = AnimationController(
      duration: Duration(milliseconds: 700),
      vsync: this,
      value: 0,
    );

    _scaleAnimation = Tween<double>(
      begin: 0,
      end: 1.0,
    ).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: Curves.elasticInOut,
      ),
    );

    if (widget.animate) {
      _start();
    }
  }

  @override
  Widget build(BuildContext context) {
    return ScaleTransition(
      scale: _scaleAnimation,
      // child: Container(
      //   width: widget.size,
      //   height: widget.size,
      //   color: Colors.green,
      // )
      child: Icon(
        Icons.check,
        color: Colors.green,
        size: widget.size,
      ),
    );
  }

  @override
  void dispose() {
    _animationController.dispose();

    super.dispose();
  }
}
