import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';


class AppLocal{
  final Locale locale;
  AppLocal(this.locale);

  Map<String, String> _loadedLocalizeValues = {};

  static AppLocal of (BuildContext context){
    return Localizations.of(context, AppLocal);
  }

  Future load() async{
    String _langFile = await rootBundle.loadString('assets/lang/${locale.languageCode}.json');
    Map<String, dynamic> _loadedValue = jsonDecode(_langFile);
    _loadedLocalizeValues = _loadedValue.map((key, value) => MapEntry(key, value.toString()));
  }

  String getTranslation(String key){
    return _loadedLocalizeValues[key].toString();
  }

  static const LocalizationsDelegate<AppLocal> delegate = _AppLocaleDelegate();
}

class _AppLocaleDelegate extends LocalizationsDelegate<AppLocal>{

  const _AppLocaleDelegate();

  @override
  bool isSupported(Locale locale) {
    // TODO: implement isSupported
    return ["ar", "en"].contains(locale.languageCode);
  }

  @override
  Future<AppLocal> load(Locale locale) async{
    AppLocal appLocal = AppLocal(locale);
    await appLocal.load();
    return appLocal;
  }

  @override
  bool shouldReload(covariant _AppLocaleDelegate old) => false;

}

String translate(BuildContext context, String key){
  return AppLocal.of(context).getTranslation(key);
}