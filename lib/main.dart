import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:local_notifications/localization_provider.dart';
import 'package:local_notifications/main_screen.dart';
import 'package:local_notifications/translation/codegen_loader.g.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();
  runApp(EasyLocalization(
      supportedLocales: const [Locale('en'), Locale('ar')],
      path: 'assets/translations',
      fallbackLocale: const Locale('ar'),
      assetLoader: const CodegenLoader(),
      child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
        create: (_) => LocalizationsProvider(),
        child: Consumer<LocalizationsProvider>(
          builder: (context, lp, child) {
            return MaterialApp(
              localizationsDelegates: context.localizationDelegates,
              supportedLocales: context.supportedLocales,
              locale: lp.isEnglish ? Locale('en') : Locale('ar'),
              theme: ThemeData(
                colorScheme: ColorScheme.fromSeed(seedColor: Colors.pinkAccent),
              ),
              home: MainScreen(),
            );
          },
        ));
  }
}
