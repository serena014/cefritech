import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../data.dart';

class StudentData{
  saveJsonData(jsonData) async{
    final currentData = await SharedPreferences.getInstance();
    debugPrint('$defaultData');
    defaultData.addEntries(jsonData.entries);
    debugPrint('$defaultData');
    var saveJsonData = jsonEncode(defaultData);
    await currentData.setString('students', saveJsonData);
  }
}