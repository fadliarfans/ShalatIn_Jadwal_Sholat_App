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
      height: 196,
      child: Column(
        children: [
          SizedBox(
            height: 155,
            width: double.infinity,
            child: Image.asset(
              image,
              fit: BoxFit.fill,
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              SizedBox(
                height: 30,
                width: 30,
                child: IconButton(
                    onPressed: () {},
                    icon: Image.asset(
                      "assets/images/icon_forward.png",
                    )),
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
          )
        ],
      ),
    );
  }
}
