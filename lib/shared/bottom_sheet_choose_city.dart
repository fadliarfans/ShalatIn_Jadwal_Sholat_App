import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/jadwal/jadwal_bloc.dart';
import '../data/models/city_model.dart';
import '../data/models/my_location_model.dart';
import '../service/city/city_manager.dart';
import '../theme.dart';

class BottomSheetChooseCity extends StatefulWidget {
  const BottomSheetChooseCity({this.city, Key? key}) : super(key: key);
  final City? city;

  @override
  State<BottomSheetChooseCity> createState() => _BottomSheetChooseCityState();
}

class _BottomSheetChooseCityState extends State<BottomSheetChooseCity> {
  late TextEditingController _textEditingController;
  List<City> cities = [];
  List<City> allCities = [];

  @override
  void initState() {
    super.initState();
    getCities();
    _textEditingController = TextEditingController();
    _textEditingController.addListener(filterCities);
  }

  getCities() async {
    allCities = await CityManager().getCities();
    cities = allCities;
    setState(() {});
  }

  filterCities() {
    setState(() {
      cities = allCities
          .where((element) =>
              (element.lokasi
                  ?.toLowerCase()
                  .contains(_textEditingController.text.toLowerCase())) ??
              false)
          .toList();
    });
  }

  @override
  void dispose() {
    super.dispose();
    _textEditingController.dispose();
  }

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
          Container(
            padding: const EdgeInsets.symmetric(vertical: 2, horizontal: 20),
            margin: const EdgeInsets.only(top: 12),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: grey,
                    offset: const Offset(2, 2),
                    blurRadius: 2.0,
                  ),
                ]),
            child: TextFormField(
                controller: _textEditingController,
                decoration: const InputDecoration(
                    hintText: "Tulis Nama Kota", border: InputBorder.none)),
          ),
          const SizedBox(
            height: 20,
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height / 2,
            child: ListView.builder(
                scrollDirection: Axis.vertical,
                itemCount: cities.length,
                itemBuilder: ((context, index) {
                  return ListTile(
                      onTap: () {
                        Navigator.pop(context);
                        BlocProvider.of<JadwalBloc>(context).add(
                            GetJadwalLocationManual(MyLocationModel(
                                city: cities[index].lokasi ?? "Error",
                                country: "Indonesia",
                                cityId: cities[index].id ?? "Error")));
                      },
                      leading: const Icon(
                        Icons.my_location,
                        color: green,
                      ),
                      title: Text(cities[index].lokasi ?? "Error"));
                })),
          )

          // FutureBuilder<List<City>>(
          //     future: CityManager().getCities(),
          //     builder: ((context, snapshot) {
          //       if (snapshot.hasData) {
          //         final data = snapshot.data
          //             ?.map((value) => DropdownMenuItem<City>(
          //                 value: value, child: Text(value.lokasi ?? "")))
          //             .toList();
          //         return DropdownButton<City>(
          //             icon: Icon(
          //               Icons.location_city,
          //               color: black,
          //             ),
          //             hint: Text(
          //               "Pilih Kota",
          //               style: kGrey3TextStyle.copyWith(fontSize: 12),
          //             ),
          //             elevation: 16,
          //             style: kBlackTextStyle,
          //             underline: Container(
          //               height: 1,
          //               color: green,
          //             ),
          //             value: null,
          //             items: data,
          //             onChanged: (value) {
          //               Navigator.pop(context);
          //               BlocProvider.of<JadwalBloc>(context).add(
          //                   GetJadwalLocationManual(MyLocationModel(
          //                       city: value?.lokasi,
          //                       country: "Indonesia",
          //                       cityId: value?.id)));
          //             });
          //       } else {
          //         return Padding(
          //           padding: const EdgeInsets.symmetric(horizontal: 24),
          //           child: LinearProgressIndicator(
          //             color: green,
          //             backgroundColor: white,
          //           ),
          //         );
          //       }
          //     })),
        ],
      ),
    );
  }
}
