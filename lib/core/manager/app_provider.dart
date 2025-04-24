import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class app_provider extends ChangeNotifier {

  String? _username;

  String? get username => _username;

  void setUsername(String name) {
    _username = name;
    notifyListeners();
  }
    app_provider() {
      Getlang();
      getTheme();
    }

  ThemeMode currenttheme = ThemeMode.light;
    String lang = "en";


  Future<void> Savelang () async{
   final SharedPreferences prefs = await SharedPreferences.getInstance() ;
    prefs.setString("language", lang);
    notifyListeners();
  }

     Future<void> Getlang () async{
   final SharedPreferences prefs = await SharedPreferences.getInstance() ;
   final savedlang = prefs.getString("language")??"en";

    if (savedlang == "ar") {
      lang = "ar"; }
    else {  lang = "en"; }


    notifyListeners();
  }

  Future<void> saveTheme() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString("theme", currenttheme == ThemeMode.dark ? "dark" : "light");
  }

  Future<void> getTheme() async {
    final prefs = await SharedPreferences.getInstance();
    String? savedTheme = prefs.getString("theme");

    if (savedTheme == "dark") {
      currenttheme = ThemeMode.dark;
    } else {
      currenttheme = ThemeMode.light;
    }

    notifyListeners();
  }


  void changeTheme([ThemeMode? theme]) {
    if (theme != null) {
      currenttheme = theme;
    } else {
      if (currenttheme == ThemeMode.light) {
        currenttheme = ThemeMode.dark;
      } else {
        currenttheme = ThemeMode.light;
      }
    }
    saveTheme();
    notifyListeners();
  }

  void  changeLang() {
    if (lang == "en") {
      lang = "ar";
    } else {
      lang = "en";
    }
    Savelang();
    notifyListeners();
  }


  Future <void> Firsttimesetter() async{

   final SharedPreferences prefs = await SharedPreferences.getInstance() ;

    prefs.setBool("fisttime", false);

 }
Future <bool> Firsttimegetter() async{

   final SharedPreferences prefs = await SharedPreferences.getInstance() ;

   return prefs.getBool("fisttime")?? true ;



 }



}
