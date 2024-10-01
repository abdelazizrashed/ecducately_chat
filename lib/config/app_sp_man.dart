import 'package:shared_preferences/shared_preferences.dart';

// Interface for shared pereferences.
class AppSpMan {
  AppSpMan();

  static SharedPreferences? _sp;
  static Future<void> init() async {
    _sp = await SharedPreferences.getInstance();
  }

  static SharedPreferences get sp => _sp!;

  static SPBool isDarkMode = SPBool(key: 'isDarkMode');

  static SPBool isRemeberMe = SPBool(key: 'isRemeberMe');
  static SPString email = SPString(key: 'email');
  static SPString password = SPString(key: 'password');

  static SPBool isLoggedIn = SPBool(key: 'isLoggedIn');
  static SPString language = SPString(key: 'language');

  static SPString token = SPString(key: "token");
}

class SPBool {
  final bool? value;
  final String key;
  SPBool({
    this.value,
    required this.key,
  });

  Future<bool> save(bool newValue) async =>
      await AppSpMan.sp.setBool(key, newValue);

  Future<bool> remove() async => await AppSpMan.sp.remove(key);

  bool? get() => AppSpMan.sp.getBool(key) ?? value;
}

class SPString {
  final String? value;
  final String key;
  SPString({
    this.value,
    required this.key,
  });

  Future<bool> save(String newValue) async =>
      await AppSpMan.sp.setString(key, newValue);

  Future<bool> remove() async => await AppSpMan.sp.remove(key);

  String? get() => AppSpMan.sp.getString(key) ?? value;
}

class SPInt {
  final int? value;
  final String key;
  SPInt({
    this.value,
    required this.key,
  });

  Future<bool> save(int newValue) async =>
      await AppSpMan.sp.setInt(key, newValue);

  Future<bool> remove() async => await AppSpMan.sp.remove(key);

  int? get() => AppSpMan.sp.getInt(key);
}

class SPCustom<T> {
  final T? value;
  final String key;
  final String Function(T value) valToString;
  final T Function(String value) stringToVal;
  SPCustom({
    required this.valToString,
    required this.stringToVal,
    this.value,
    required this.key,
  });

  Future<bool> save(T newValue) async =>
      await AppSpMan.sp.setString(key, valToString(newValue));

  Future<bool> remove() async => await AppSpMan.sp.remove(key);

  T? get() {
    final value = AppSpMan.sp.getString(key);
    if (value != null) {
      return stringToVal(value);
    }
    return null;
  }
}
