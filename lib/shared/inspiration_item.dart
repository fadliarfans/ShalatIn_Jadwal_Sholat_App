import 'package:flutter/material.dart';
import '../theme.dart';

class InspirationItem extends StatelessWidget {
  const InspirationItem({required this.image, Key? key}) : super(key: key);
  final String image;
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 7),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(10),
        child: Container(
          height: 196,
          color: white,
          child: Column(
            children: [
              Container(
                height: 196,
                decoration: BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage(image), fit: BoxFit.fill)),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
