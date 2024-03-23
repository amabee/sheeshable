import 'package:hive_flutter/hive_flutter.dart';

class SessionChecker {
  Future<void> setSession(String username, bool hasSession, String email,
      String fullname, String phoneNumber, String image) async {
    final box = await Hive.openBox('myBox');
    await box.put("hasSession", hasSession);
    await box.put("username", username);
    await box.put("email", email);
    await box.put("fullname", fullname);
    await box.put("phone_number", phoneNumber);
    await box.put("image", image);
  }

  Future<bool> checkSession() async {
    final box = await Hive.openBox('myBox');
    // print("Has Session: ${box.get("hasSession")}");
    // print(box.get("username"));
    // print(box.get("email"));
    // print(box.get("fullname"));
    return box.get("hasSession", defaultValue: false);
  }
}
