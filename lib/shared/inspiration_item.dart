import 'package:flutter/material.dart';
import 'package:jadwal_sholat_app/theme.dart';

class InspirationItem extends StatelessWidget {
  const InspirationItem({required this.image, Key? key}) : super(key: key);
  final String image;
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 24),
      decoration:
          BoxDecoration(borderRadius: BorderRadius.circular(10), color: white),
      child: Column(
        children: [
          SizedBox(
            height: 155,
            width: double.infinity,
            child: Image.asset(
              image,
              fit: BoxFit.cover,
            ),
          ),
          const SizedBox(
            height: 14,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              GestureDetector(
                onTap: () {},
                child: Image.asset(
                  "assets/images/icon_forward.png",
                  height: 20,
                ),
              ),
              const SizedBox(
                width: 6,
              ),
              Text(
                "Bagikan",
                style: kBlack2TextStyle.copyWith(
                    fontSize: 12, letterSpacing: -0.2),
              ),
              const SizedBox(
                width: 25,
              ),
            ],
          ),
          const SizedBox(
            height: 7,
          )
        ],
      ),
    );
  }
}
