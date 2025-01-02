import 'package:routing_app/repositories/shared_preferences/shared_preferences_constants.dart';
import 'package:routing_app/repositories/shared_preferences/shared_preferences_helper.dart';

class SharedPreferencesRepo {
  SharedPreferencesRepo._();

  static SharedPreferencesRepo? _instance;

  static SharedPreferencesRepo get instance => _instance ??= SharedPreferencesRepo._();

  Future<void> saveAuthUser(String authUser) async {
    await SharedPreferencesHelper.instance.setString(SharedPreferencesConstants.authUser, authUser);
  }

  String? getAuthUser() {
    return SharedPreferencesHelper.instance.getString(SharedPreferencesConstants.authUser);
  }
}