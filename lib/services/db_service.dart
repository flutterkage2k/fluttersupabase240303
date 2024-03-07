import 'dart:math';

import 'package:flutter/material.dart';
import 'package:fluttersupabase240303/constants/constants.dart';
import 'package:fluttersupabase240303/models/user_model.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class DbService extends ChangeNotifier {
  final SupabaseClient _supabase = Supabase.instance.client;
  UserModel? userModel;

  String generateRandomEmployeeId() {
    final random = Random();
    const allChars = "abcejdig123456789";
    final randomString = List.generate(
      8,
      (index) => allChars[random.nextInt(allChars.length)],
    ).join();
    return randomString;
  }

  // 서버쪽에 policies 부분에서 disable 해야합니다.
  Future insertNewUser(String email, var id) async {
    await _supabase.from(Constants.employeeTable).insert({
      'id': id,
      'name': '',
      'email': email,
      'employee_id': generateRandomEmployeeId(),
      'department': null,
    });
  }

  Future<UserModel> getUserData() async {
    final userData = await _supabase.from(Constants.employeeTable).select().eq('id', _supabase.auth.currentUser!.id).single();
    userModel = UserModel.fromJson(userData);
    return userModel!;
  }
}
