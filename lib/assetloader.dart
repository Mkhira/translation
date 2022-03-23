import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'dart:ui';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/services.dart';

class MyAssetLoader extends AssetLoader {
  String getLocalePath(String basePath, Locale locale) {
    return '$basePath${localeToString(locale, separator: "-")}.json';
  }

  @override
  Future<Map<String, dynamic>> load(String path, Locale locale) async {
    var localePath = getLocalePath(path, locale);
    log('easy localization loader: load json file $localePath');
    File file = File( localePath); // 1
    String fileContent = await file.readAsString();

    return jsonDecode(fileContent);
  }
}
class JsonSingleAssetLoader extends AssetLoader {
  Map? jsonData;

  @override
  Future<Map<String, dynamic>> load(String path, Locale locale) async {
    if (jsonData == null) {
      log('easy localization loader: load json file $path');
      File file = File( path); // 1
      String fileContent = await file.readAsString();
      jsonData = jsonDecode(fileContent);

    } else {

      log('easy localization loader: json already loaded, read cache');
    }
    return jsonData![locale.toString()];
  }
}