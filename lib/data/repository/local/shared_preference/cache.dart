

import 'package:injectable/injectable.dart';
import 'package:shared_preferences/shared_preferences.dart';

@Injectable()
class Cache{
  late SharedPreferences _sharedPreferences;

  void init() async{
    _sharedPreferences = await SharedPreferences.getInstance();
  }

  get pref => _sharedPreferences;
}
