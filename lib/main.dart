import 'package:bot_toast/bot_toast.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/core/app_theme_manager.dart';
import 'package:todo_app/core/page_routes_names.dart';
import 'package:todo_app/core/routes_generator.dart';
import 'package:todo_app/core/services/loading_services.dart';
import 'package:todo_app/core/settings_provider.dart';

void main() async {
  //to make sure every await task is done
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(ChangeNotifierProvider(
      create: (context) => SettingsProvider(), child: const MyApp()));
  configLoading();
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<SettingsProvider>(context); //singleton
    return MaterialApp(
      themeMode: provider.currentTheme,
      // themeMode: ThemeMode.light,
      theme: AppThemeManager.lightTheme,
      darkTheme: AppThemeManager.darkTheme,
      // locale: Locale("ar"),
      locale: Locale(provider.currentLanguage),
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      debugShowCheckedModeBanner: false,
      title: 'To Do Project',
      // theme: AppThemeManager.lightTheme,
      initialRoute: PageRoutesNames.initial,
      onGenerateRoute: RoutesGenerator.onGenerateRoutes,
      builder: EasyLoading.init(
        builder: BotToastInit(),
      ),
    );
  }
}
