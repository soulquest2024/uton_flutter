import 'package:flutter/cupertino.dart';
import 'package:get_it/get_it.dart';
import 'package:uton_flutter/common/api/api_resource.dart';
import 'package:uton_flutter/common/common_widgets/webview_screen.dart';
import 'package:uton_flutter/common/firestore/firebase_authentication.dart';
import 'package:uton_flutter/common/firestore/firestore_database.dart';
import 'package:uton_flutter/common/models/offer.dart';
import 'package:uton_flutter/common/models/program.dart';
import 'package:uton_flutter/home/Authentication/forgot_password_screen.dart';
import 'package:uton_flutter/home/Authentication/login_screen.dart';
import 'package:uton_flutter/home/Authentication/registration_screen.dart';
import 'package:uton_flutter/home/home_screen.dart';
import 'package:uton_flutter/home/offers/home_offers.dart';
import 'package:uton_flutter/home/programs/home_programs.dart';
import 'package:uton_flutter/providers/authProvider.dart';
import 'package:uton_flutter/providers/home_provider.dart';

final GetIt locator = GetIt.instance;

void setupLocator() {
  locator.registerLazySingleton<FirestoreDatabase>(() => FirestoreDatabase.shared);
  locator.registerLazySingleton<FirebaseAuthentication>(() => FirebaseAuthentication.shared);

  locator.registerLazySingleton<ApiResourceManager<List<Program>>>(() => ApiResourceManager<List<Program>>());
  locator.registerLazySingleton<ApiResourceManager<List<Offer>>>(() => ApiResourceManager<List<Offer>>());
  locator.registerLazySingleton<ApiResourceManager<Widget>>(() => ApiResourceManager<Widget>());

  locator.registerLazySingleton<LoginScreen>(() => LoginScreen());
  locator.registerLazySingleton<RegistrationScreen>(() => RegistrationScreen());
  locator.registerLazySingleton<ForgotPasswordScreen>(() => ForgotPasswordScreen());

  locator.registerLazySingleton<HomeProvider>(() => HomeProvider());
  locator.registerLazySingleton<AuthProvider>(() => AuthProvider());

  locator.registerLazySingleton<HomeScreen>(() => HomeScreen());
  locator.registerLazySingleton<HomePrograms>(() => HomePrograms());
  locator.registerLazySingleton<HomeOffers>(() => HomeOffers());

  locator.registerFactoryParam<WebViewScreen, Map<String, String>, void>((params, _) => WebViewScreen(url: params['url']!, title: params['title']!));}
