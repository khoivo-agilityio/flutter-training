import 'dart:io';

import 'package:accessibility_tools/accessibility_tools.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:poltry_farm/environments/app_providers.dart';
import 'package:poltry_farm/firebase_options.dart';
import 'package:poltry_farm/resources/l10n_generated/l10n.dart';
import 'package:poltry_farm/router.dart';
import 'package:poltry_farm/shared/local_database/local_database.dart';
import 'package:poltry_farm/themes/app_theme.dart';

Future<void> main() async {
  // Initialize the Flutter binding.
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load(fileName: ".env");

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  // Set up the preferred orientations.
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  await HiveLocalDb.instance.init();

  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> with WidgetsBindingObserver {
  @override
  void initState() {
    WidgetsBinding.instance.addObserver(this);
    super.initState();
  }

  @override

  /// Called when the app's lifecycle state changes.
  ///
  /// We use this callback to hide the keyboard when  the app is inactive,
  /// which is when the screen is turned off on Android devices.
  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);

    if (state == AppLifecycleState.inactive) {
      // For android device when screen off will unfocus to close keyboard
      // This is a workaround for a bug in Android where the keyboard is not
      // dismissed when the screen is turned off.
      if ((FocusManager.instance.primaryFocus?.hasFocus ?? false) &&
          Platform.isAndroid) {
        FocusManager.instance.primaryFocus?.unfocus();
      }
    }
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AppProvider(
      child: MaterialApp.router(
        theme: PfTheme.light,

        themeMode: ThemeMode.dark,
        debugShowCheckedModeBanner: false,
        // Locale
        locale: const Locale('en', 'US'),

        localizationsDelegates: const [
          S.delegate,
        ],
        supportedLocales: [
          ...S.delegate.supportedLocales,
          const Locale('en', ''),
        ],

        routeInformationProvider: PfRouter.router.routeInformationProvider,
        routeInformationParser: PfRouter.router.routeInformationParser,
        routerDelegate: PfRouter.router.routerDelegate,
        builder: (context, child) => AccessibilityTools(child: child),
      ),
    );
  }
}
