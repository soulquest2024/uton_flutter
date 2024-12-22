import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:uton_flutter/common/common_widgets/animation_widget.dart';
import 'package:uton_flutter/home/Authentication/login_screen.dart';
import 'package:uton_flutter/providers/authProvider.dart';
import 'package:uton_flutter/providers/home_provider.dart';

import 'common/app_constant.dart';
import 'dependency_injection/service_locator.dart';
import 'home/home_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();

  await Firebase.initializeApp();
  setupLocator();
  runApp(
    EasyLocalization(
      supportedLocales: [Locale('en'), Locale('hu')],
      path: 'assets/translations',
      fallbackLocale: Locale('hu'),
      child: MultiProvider(
        providers: [
          ChangeNotifierProvider(
            create: (_) => locator<HomeProvider>(),
          ),
          ChangeNotifierProvider(
            create: (_) => locator<AuthProvider>(),
          ),
        ],
        child: MyApp(),
      ),
    ),
  );
}

class MyApp extends StatelessWidget {
  MyApp({Key? key}) : super(key: key);

  Future<void> initApp() async {
    await Firebase.initializeApp();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: initApp(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          return MaterialApp(
            title: 'Flutter Demo',
            locale: context.locale,
            localizationsDelegates: context.localizationDelegates,
            debugShowCheckedModeBanner: false,
            supportedLocales: context.supportedLocales,
            theme: ThemeData(
              colorScheme: ColorScheme.fromSeed(seedColor: Colors.white),
              useMaterial3: true,
            ),
            home: Builder(
              builder: (context) {
                Resources.context = context;
                return _myMaterialApp();
              },
            ),
          );
        }
        return Container();
      },
    );
  }

  Widget _myMaterialApp() {
    return AuthHandler();
  }
}

class AuthHandler extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<AuthProvider>(
      builder: (context, authProvider, child) {
        if (authProvider.isLoading) {
          return SplashScreen();
        }

        if (authProvider.user == null) {
          return LoginScreen();
        } else {
          return HomeScreen();
        }
      },
    );
  }
}

class SplashScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: AnimationWidget(),
      ),
    );
  }
}
