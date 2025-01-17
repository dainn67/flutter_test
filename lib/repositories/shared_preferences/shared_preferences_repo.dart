import 'package:routing_app/repositories/shared_preferences/shared_preferences_constants.dart';
import 'package:routing_app/repositories/shared_preferences/shared_preferences_helper.dart';

class SharedPreferencesRepo {
  SharedPreferencesRepo._();

  static SharedPreferencesRepo? _instance;

  static SharedPreferencesRepo get instance => _instance ??= SharedPreferencesRepo._();

  // Authentication
  Future<void> setAuthUser(String authUser) async {
    await SharedPreferencesHelper.instance.setString(SharedPreferencesConstants.authUser, authUser);
  }

  Future<void> clearAuthUser() async {
    await SharedPreferencesHelper.instance.remove(SharedPreferencesConstants.authUser);
  }

  String? getAuthUser() {
    return SharedPreferencesHelper.instance.getString(SharedPreferencesConstants.authUser);
  }

  // Theme
  Future<void> setThemeValue(int themeValue) async {
    await SharedPreferencesHelper.instance.setInt(SharedPreferencesConstants.themeValue, themeValue);
  }

  int getThemeValue() {
    return SharedPreferencesHelper.instance.getInt(SharedPreferencesConstants.themeValue) ?? -1;
  }
}