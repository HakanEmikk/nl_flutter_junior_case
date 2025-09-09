import 'package:flutter/material.dart';
import 'package:jr_case_boilerplate/core/constants/app_theme.dart';
import 'package:jr_case_boilerplate/core/routes/app_routes.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:jr_case_boilerplate/l10n/app_localizations.dart';

final RouteObserver<PageRoute> routeObserver = RouteObserver<PageRoute>();
void main() {
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      navigatorObservers: [routeObserver],
      localeResolutionCallback: (locale, supportedLocales) {
        // Telefonun dili destekleniyorsa onu kullan, yoksa Türkçe kullan
        if (locale != null) {
          for (var supportedLocale in supportedLocales) {
            if (supportedLocale.languageCode == locale.languageCode) {
              return supportedLocale;
            }
          }
        }
        return const Locale('tr');
      },
      supportedLocales: const [
        Locale('tr'), // Türkçe
        Locale('en'), // İngilizce
      ],
      localizationsDelegates: const [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      onGenerateRoute: AppRoutes.onGenerateRoute,
      initialRoute: AppRoutes.splash,
    );
  }
}
