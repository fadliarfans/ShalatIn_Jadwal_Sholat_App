import 'package:jadwal_sholat_app/data/models/niat_model.dart';
import 'package:jadwal_sholat_app/data/models/shalat_model.dart';

Map<Shalat, List<NiatModel>> niatData = {
  Shalat.Subuh: [
    NiatModel(
        role: "Imam",
        niat:
            "أُصَلِّي فَرْضَ الصُّبْحِ رَكْعَتَيْنِ مُسْتَقْبِلَ الْقِبْلَةِ أَدَاءً إِمَامًا لِلهِ تَعَالَى",
        transliteration:
            "Ushallii fardash-Shubhi rak’ataini mustaqbilal qiblati adaa-an imaaman lillaahi ta’aalaa.",
        translation:
            'Saya (berniat) mengerjakan sholat fardhu Shubuh sebanyak dua raka’at dengan menghadap kiblat, sebagai imam, karena Allah Ta’ala.'),
    NiatModel(
        role: "Makmum",
        niat:
            "أُصَلِّي فَرْضَ الصُّبْحِ رَكْعَتَيْنِ مُسْتَقْبِلَ الْقِبْلَةِ أَدَاءً مَأْمُوْمًا لِلهِ تَعَالَى",
        transliteration:
            "Ushallii fardhash-Shubhi rak’ataini mustaqbilal qiblati adaa-an ma’muman lillaahi ta’aalaa.",
        translation:
            'Saya (berniat) mengerjakan sholat fardhu Shubuh sebanyak dua raka’at dengan menghadap kiblat, sebagai makmum, karena Allah Ta’ala.'),
    NiatModel(
        role: "Sendiri",
        niat:
            "أُصَلِّى فَرْضَ الصُّبْح رَكَعتَيْنِ مُسْتَقْبِلَ الْقِبْلَةِ أَدَاءً لله تَعَالَى",
        transliteration:
            "Ushallii fardash-Shubhi rak’ataini mustaqbilal qiblati adaa’an lillaahi ta’aalaa.",
        translation:
            'Saya (berniat) mengerjakan sholat fardhu Shubuh sebanyak dua raka’at dengan menghadap kiblat, karena Allah Ta’ala.'),
  ],
  Shalat.Dzuhur: [
    NiatModel(
        role: "Imam",
        niat:
            "أُصَلِّي فَرْضَ الظُّهْرِ رَكْعَتَيْنِ مُسْتَقْبِلَ الْقِبْلَةِ أَدَاءً إِمَامًا لِلهِ تَعَالَى",
        transliteration:
            "Ushalliy fardha-zzhuhri arba’a raka’atin mustaqblilal-qiblati adaa-an imaman lillahi ta’ala.",
        translation:
            "Aku berniat sholat fardhu Zuhur empat rakaat menghadap kiblat sebagai imam karena Allah Ta’ala"),
    NiatModel(
        role: "Makmum",
        niat:
            "أُصَلِّي فَرْضَ الظُّهْرِ رَكْعَتَيْنِ مُسْتَقْبِلَ الْقِبْلَةِ أَدَاءً مَأْمُوْمًا لِلهِ تَعَالَى",
        transliteration:
            "Ushalliy fardha-zzhuhri arba’a raka’atin mustaqblilal-qiblati adaa-an ma’muman lillahi ta’ala.",
        translation:
            "Aku berniat sholat fardhu Zuhur empat rakaat menghadap kiblat sebagai makmum karena Allah Ta’ala"),
    NiatModel(
        role: "Sendiri",
        niat:
            "اُصَلِّيْ فَرْضَ الظُّهْرِ أَرْبَعَ رَكَعاَتٍ مُسْتَقْبِلَ الْقِبْلَةِ أَدَاءً لله تَعَالَى",
        transliteration:
            "Usholli Fardlon dhuhri Arba'a Rok'aataim Mustaqbilal Qiblati Adaa-an Lillahi ta'aala.",
        translation:
            "Aku niat melakukan sholat fardu dhuhur 4 rakaat, sambil menghadap qiblat, saat ini, karena Allah ta'ala"),
  ],
  Shalat.Ashar: [
    NiatModel(
        role: "Imam",
        niat:
            "أُصَلِّى فَرْضَ العَصْرِأَرْبَعَ رَكَعاَتٍ مُسْتَقْبِلَ الْقِبْلَةِ أَدَاءً لله تَعَالَى",
        transliteration:
            "Ushalli fardhol 'ashri arba'a raka'aatin mustaqbilalqiblati adaan lillaahi ta'ala.",
        translation:
            "Saya melakukan sholat fardhu ashar sebanyak empat rakaat dengan menghadap kiblat, pada waktunya karena Allah Ta’ala"),
    NiatModel(
        role: "Makmum",
        niat:
            "أُصَلِّي فَرْضَ العَصْرِ رَكْعَتَيْنِ مُسْتَقْبِلَ الْقِبْلَةِ أَدَاءً مَأْمُوْمًا لِلهِ تَعَالَى",
        transliteration:
            "Ushalliy fardhal-ashri arba’a raka’atin mustaqbilal-qiblati ada-an ma’muman lillahi ta’ala.",
        translation:
            "Aku berniat sholat fardhu Ashar empat rakaat menghadap kiblat sebagai makmum karena Allah Ta’ala"),
    NiatModel(
        role: "Sendiri",
        niat:
            "أُصَلِّى فَرْضَ العَصْرِأَرْبَعَ رَكَعاَتٍ مُسْتَقْبِلَ الْقِبْلَةِ أَدَاءً لله تَعَالَى",
        transliteration:
            "Usholli Fardlol Ashri Arba'a Roka'aataim Mustaqbilal Qiblati Adaa-an Lillahi ta'aala",
        translation:
            " Aku niat melakukan sholat fardu ashar 4 rakaat, sambil menghadap qiblat, saat ini, karena Allah ta'ala"),
  ],
  Shalat.Maghrib: [
    NiatModel(
        role: "Imam",
        niat:
            "أُصَلِّي فَرْضَ الْمَغْرِبِ رَكْعَتَيْنِ مُسْتَقْبِلَ الْقِبْلَةِ أَدَاءً إِمَامًا لِلهِ تَعَالَى",
        transliteration:
            "Ushalliy fardhal-maghribi tsalatsa raka’atin mustaqbilal-qiblati adaa-an imaman lillahi ta’ala.",
        translation:
            "Aku berniat sholat fardhu Maghrib tiga rakaat menghadap kiblat sebagai imam karena Allah Ta’ala"),
    NiatModel(
        role: "Makmum",
        niat:
            "أُصَلِّي فَرْضَ الْمَغْرِبِ رَكْعَتَيْنِ مُسْتَقْبِلَ الْقِبْلَةِ أَدَاءً مَأْمُوْمًا لِلهِ تَعَالَىتَعَالَى",
        transliteration:
            "Ushalliy fardhal-maghribi tsalatsa raka’atin mustaqbilal-qiblati adaa-an ma’muman lillahi ta’ala.",
        translation:
            "Aku berniat sholat fardhu Maghrib tiga rakaat menghadap kiblat sebagai makmum karena Allah Ta’ala"),
    NiatModel(
        role: "Sendiri",
        niat:
            "أُصَلِّى فَرْضَ المَغْرِبِ ثَلاَثَ رَكَعاَتٍ مُسْتَقْبِلَ الْقِبْلَةِ أَدَاءً لله تَعَالَ",
        transliteration:
            "Usholli Fardlol Maghribi Tsalaatsa Roka'aataim Mustaqbilal Qiblati Adaa-an Lillahi ta'aala",
        translation:
            "Aku niat melakukan sholat fardu maghrib 3 rakaat, sambil menghadap qiblat, saat ini, karena Allah ta'ala"),
  ],
  Shalat.Isya: [
    NiatModel(
        role: "Imam",
        niat:
            "أُصَلِّي فَرْضَ الْعِشَاءِ رَكْعَتَيْنِ مُسْتَقْبِلَ الْقِبْلَةِ أَدَاءً إِمَامًا لِلهِ تَعَالَى",
        transliteration:
            "Ushalliy fardhal-isyaa-I arba’a raka’atin mustaqbilal-qiblati adaa-an imaman lillahi ta’ala.",
        translation:
            "Aku berniat sholat fardhu Isya empat rakaat menghadap kiblat karena Allah Ta’ala"),
    NiatModel(
        role: "Makmum",
        niat:
            "أُصَلِّي فَرْضَ الْعِشَاءِ رَكْعَتَيْنِ مُسْتَقْبِلَ الْقِبْلَةِ أَدَاءً مَأْمُوْمًا لِلهِ تَعَالَى",
        transliteration:
            "Ushalliy fardhal-isyaa-I arba’a raka’atin mustaqbilal-qiblati adaa-an ma’muman lillahi ta’ala.",
        translation:
            "Aku berniat sholat fardhu Isya empat rakaat menghadap kiblat sebagai makmum karena Allah Ta’ala"),
    NiatModel(
        role: "Sendiri",
        niat:
            "أُصَلِّى فَرْضَ العِشَاء ِأَرْبَعَ رَكَعاَتٍ مُسْتَقْبِلَ الْقِبْلَةِ أَدَاءً لله تَعَالَى",
        transliteration:
            "Usholli Fardlol I'syaa-i Arba'a Roka'aataim Mustaqbilal Qiblati Adaa-an Lillahi ta'aala",
        translation:
            " Aku niat melakukan sholat fardu isya 4 rakaat, sambil menghadap qiblat, saat ini, karena Allah ta'ala"),
  ]
};
