import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ok_edus_kz/firebase_options.dart';
import 'package:ok_edus_kz/provider/theme_provider.dart';
import 'package:provider/provider.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:ok_edus_kz/generated/l10n.dart';
import 'package:ok_edus_kz/features/auth_screen/view/auth_screen.dart';
import 'package:ok_edus_kz/features/onboarding_screens/onboarding_page_view.dart';
import 'package:ok_edus_kz/features/mainscreen_navbar/custom_bottom_navbar.dart';
import 'package:shared_preferences/shared_preferences.dart';

int? initScreen;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  FirebaseMessaging messaging = FirebaseMessaging.instance;

  SharedPreferences prefs = await SharedPreferences.getInstance();
  initScreen = prefs.getInt('initScreen');
  await prefs.setInt("initScreen", 1);

  await messaging.requestPermission(
    alert: true,
    announcement: false,
    badge: true,
    carPlay: false,
    criticalAlert: false,
    provisional: false,
    sound: true,
  );

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => ThemeProvider(),
        ),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  late Locale appLocale;
  bool onboardingCompleted = false;
  bool isLoggedIn = false;

  Future<void> loadPrefs() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    onboardingCompleted = prefs.getBool('onboardingCompleted') ?? false;
    isLoggedIn = prefs.getBool('isLoggedIn') ?? false;
  }

  Future<void> loadSelectedLanguage() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final selectedLanguage = prefs.getString('selectedLanguage');
    if (selectedLanguage != null) {
      appLocale = Locale(selectedLanguage);
    } else {
      appLocale = const Locale('kk');
    }
  }

  @override
  void initState() {
    super.initState();
    appLocale = const Locale('kk'); // Устанавливаем начальное значение
    loadSelectedLanguage().then((_) {
      setState(() {
        S.load(appLocale);
        loadPrefs().then((_) {
        context.read<ThemeProvider>().loadTheme(); // Load the theme here
        //setState(() {});
        });
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    return ScreenUtilInit(
      designSize: const Size(390, 844),
      child: MaterialApp(
        localizationsDelegates: const [
          S.delegate,
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        locale: appLocale,
        supportedLocales: S.delegate.supportedLocales,
        debugShowCheckedModeBanner: false,
        title: 'Ok edus kz',
        theme: ThemeData(
          colorScheme: ColorScheme.light(
            primary: themeProvider.primaryColor,
            secondary: themeProvider.secondaryColor,
          ),
        ),
        initialRoute:
            initScreen == 0 || initScreen == null ? "/onboarding" : "/home",
        routes: {
          '/onboarding': (context) => const PageViewOnBoarding(),
          '/home': (context) =>
              isLoggedIn ? const BottomNavBar() : const AuthScreen(),
        },
      ),
    );
  }
}
