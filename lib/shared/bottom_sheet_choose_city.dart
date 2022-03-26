import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/jadwal/jadwal_bloc.dart';
import '../data/city_model.dart';
import '../data/my_location_model.dart';
import '../service/city/city_manager.dart';
import '../theme.dart';

class BottomSheetChooseCity extends StatefulWidget {
  const BottomSheetChooseCity({this.city, Key? key}) : super(key: key);
  final City? city;

  @override
  State<BottomSheetChooseCity> createState() => _BottomSheetChooseCityState();
}

class _BottomSheetChooseCityState extends State<BottomSheetChooseCity> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 30),
      decoration: BoxDecoration(
          color: white,
          borderRadius: const BorderRadius.vertical(top: Radius.circular(34)),
          boxShadow: [
            BoxShadow(
                offset: const Offset(0, -4),
                blurRadius: 4,
                color: black.withOpacity(0.1))
          ]),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            children: [
              Image.asset(
                "assets/images/icon_map.png",
                height: 12,
                color: Colors.red,
              ),
              const SizedBox(
                width: 12,
              ),
              Text(
                "Pilih lokasi secara manual",
                style:
                    kBlack2TextStyle.copyWith(fontWeight: medium, fontSize: 14),
              ),
            ],
          ),
          const SizedBox(
            height: 30,
          ),
          Text(
            "Pilih Kota",
            style: kGreenTextStyle.copyWith(fontSize: 12),
          ),
          FutureBuilder<List<City>>(
              future: CityManager().getCities(),
              builder: ((context, snapshot) {
                if (snapshot.hasData) {
                  final data = snapshot.data
                      ?.map((value) => DropdownMenuItem<City>(
                          value: value, child: Text(value.cityName ?? "")))
                      .toList();
                  return DropdownButton<City>(
                      icon: Icon(
                        Icons.location_city,
                        color: black,
                      ),
                      hint: Text(
                        "Pilih Kota",
                        style: kGrey3TextStyle.copyWith(fontSize: 12),
                      ),
                      elevation: 16,
                      style: kBlackTextStyle,
                      underline: Container(
                        height: 1,
                        color: green,
                      ),
                      value: null,
                      items: data,
                      onChanged: (value) {
                        Navigator.pop(context);
                        BlocProvider.of<JadwalBloc>(context).add(
                            GetJadwalLocationManual(MyLocationModel(
                                city: value?.cityName,
                                country: "Indonesia",
                                cityId: value?.cityId)));
                      });
                } else {
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 24),
                    child: LinearProgressIndicator(
                      color: green,
                      backgroundColor: white,
                    ),
                  );
                }
              })),
        ],
      ),
    );
  }
}
