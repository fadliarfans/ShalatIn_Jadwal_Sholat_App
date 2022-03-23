import 'package:flutter/material.dart';
import 'package:jadwal_sholat_app/theme.dart';

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
                height: 155,
                decoration: BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage(image), fit: BoxFit.fill)),
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
            ],
          ),
        ),
      ),
    );
  }
}
