import 'package:flutter/material.dart';
import '../theme.dart';

class NavigationItem extends StatefulWidget {
  const NavigationItem(
      {required this.image,
      required this.title,
      required this.color,
      required this.callback,
      Key? key})
      : super(key: key);
  final String image;
  final String title;
  final Color color;
  final Function callback;

  @override
  State<NavigationItem> createState() => _NavigationItemState();
}

class _NavigationItemState extends State<NavigationItem>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 100));
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animationController,
      builder: (context, child) => Transform.scale(
        scale: 1 - (_animationController.value * 0.3),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            GestureDetector(
                onTap: () async {
                  await _animationController.forward();
                  widget.callback();
                  _animationController.reverse();
                },
                child: Image.asset(
                  widget.image,
                  height: 30,
                  color: widget.color,
                )),
            Text(
              widget.title,
              style:
                  kGreen3TextStyle.copyWith(fontSize: 10, color: widget.color),
            )
          ],
        ),
      ),
    );
  }
}
