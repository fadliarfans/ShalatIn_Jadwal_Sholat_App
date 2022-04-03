import 'dart:developer' as developer;
import 'dart:io';

import 'package:android_alarm_manager_plus/android_alarm_manager_plus.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:injectable/injectable.dart';
import 'package:path_provider_android/path_provider_android.dart';
import 'package:path_provider_ios/path_provider_ios.dart';

@Injectable()
class AlarmAdzan{
  static Future<void> _callback() async {
    developer.log('Alarm fired!');
    try {
      if (Platform.isAndroid) PathProviderAndroid.registerWith();
      if (Platform.isIOS) PathProviderIOS.registerWith();
      AudioCache audioPlayer = AudioCache();
      audioPlayer.play("audio/Adzan-Misyari-Rasyid.mp3");
    } catch (e) {
      rethrow;
    }
  }

  Future<void> playAdzan(DateTime date, int id) async {
    await AndroidAlarmManager.oneShotAt(date, id, _callback);
  }

  Future<void> cancelAdzan(int id) async {
    await AndroidAlarmManager.cancel(id);
  }
}
