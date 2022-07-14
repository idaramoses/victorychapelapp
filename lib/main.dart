import 'dart:async';

import 'package:WeightApp/routes.dart';
import 'package:WeightApp/theming/theme_manager.dart';
import 'package:WeightApp/utils/push_notification.dart';
import 'package:WeightApp/welcome/Splash.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:provider/provider.dart';
// import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'app_state.dart';
import 'application.dart';
import 'localization.dart';

const debug = true;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  FlutterDownloader.initialize(debug: debug);

  await Firebase.initializeApp();
  runApp(AppState(
    child: ChangeNotifierProvider<ThemeNotifier>(
      create: (_) => new ThemeNotifier(),
      child: MyApp(),
    ),
  ));
}

class MyApp extends StatefulWidget {
  final Brightness brightness;

  const MyApp({Key key, this.brightness}) : super(key: key);

  @override
  MyAppState createState() {
    return new MyAppState();
  }
}

class MyAppState extends State<MyApp> {
  AppLocalizationsDelegate _appLocaleDelegate;
  Brightness brightness;
  static final FirebaseMessaging _firebaseMessaging = FirebaseMessaging();

  @override
  void initState() {
    super.initState();
    _appLocaleDelegate = AppLocalizationsDelegate(newLocale: Locale('en', ''));
    application.onLocaleChanged = onLocaleChange;
  }

  @override
  Widget build(BuildContext context) {
    final pushNotificationService = PushNotificationService(_firebaseMessaging);
    pushNotificationService.initialise();
    return FutureBuilder<SharedPreferences>(
      future: loadPreferences(),
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if (snapshot.hasData) {
          return new Consumer<ThemeNotifier>(
              builder: (context, theme, child) => MaterialApp(
                    title: '',
                    theme: theme.getTheme(),
                    home: new Splash(),
                    debugShowCheckedModeBanner: false,
                    routes: routes(context),
                    localizationsDelegates: [
                      _appLocaleDelegate,
                      const AppLocalizationsDelegate(),
                    ],
                    supportedLocales: application.supportedLocales(),
                  ));
        }
        return CircularProgressIndicator();
      },
    );
  }

  void onLocaleChange(Locale locale) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('lang', locale.languageCode);
    setState(() {
      _appLocaleDelegate = AppLocalizationsDelegate(newLocale: locale);
    });
  }

  Future<SharedPreferences> loadPreferences() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (prefs.getBool('auto_dark') ?? true) {
      this.brightness = DateTime.now().hour < 18 && DateTime.now().hour > 5
          ? Brightness.light
          : Brightness.light;
    }

    String language = prefs.getString('lang') ?? 'en';
    _appLocaleDelegate = AppLocalizationsDelegate(
      newLocale: Locale(language, ''),
    );

    return prefs;
  }
}
