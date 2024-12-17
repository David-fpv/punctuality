import 'package:flutter/material.dart';
import 'package:first_application/models/profile_model.dart';
import 'package:first_application/data/database_helper.dart';

class ProfileViewModel extends ChangeNotifier {

  Profile? _profile;
  
  Profile? get profile => _profile;

  Future<void> loadProfile() async {
    _profile = await DatabaseHelper.database_punctuality.getProfile();
    notifyListeners();
  }

  Future<void> updateProfile(Profile profile) async {
    await DatabaseHelper.database_punctuality.updateProfile(profile);
    await loadProfile(); // Обновляем список задач после изменения
  }

  Future<void> deleteTask(Profile profile) async {
    await DatabaseHelper.database_punctuality.deleteTask(profile.userId);
    await loadProfile(); // Обновляем список задач после изменения
  }
}