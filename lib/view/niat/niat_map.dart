import 'package:jadwal_sholat_app/data/models/niat_model.dart';
import 'package:jadwal_sholat_app/data/models/shalat_model.dart';

Map<Shalat, List<NiatModel>> niatMap = {
  Shalat.Subuh: [
    NiatModel(
        role: "Imam",
        niat:
            "أُصَلِّي فَرْضَ الصُّبْحِ رَكْعَتَيْنِ مُسْتَقْبِلَ الْقِبْلَةِ أَدَاءً إِمَامًا لِلهِ تَعَالَى",
        transliteration:
            "Ushallii fardash-Shubhi rak’ataini mustaqbilal qiblati imaaman lillaahi ta’aalaa.",
        translation:
            "Artinya: Saya (berniat) mengerjakan sholat fardhu Shubuh sebanyak dua raka’at dengan menghadap kiblat, sebagai imam, karena Allah Ta’ala"),
    NiatModel(
        role: "Makmum",
        niat:
            "ُصَلِّي فَرْضَ الصُّبْحِ رَكْعَتَيْنِ مُسْتَقْبِلَ الْقِبْلَةِ أَدَاءً مَأْمُوْمًا لِلهِ تَعَالَى",
        transliteration:
            "Ushallii fardhash-Shubhi rak’ataini mustaqbilal qiblati makmuuman lillaahi ta’aalaa.",
        translation:
            'Artinya: Saya (berniat) mengerjakan sholat fardhu Shubuh sebanyak dua raka’at dengan menghadap kiblat, sebagai makmum, karena Allah Ta’ala.')
  ]
};
