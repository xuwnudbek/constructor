import 'package:constructor/core/constants/app_constants.dart';
import 'package:constructor/core/themes/app_theme.dart';
import 'package:constructor/presentation/bloc/app/app_bloc.dart';
import 'package:constructor/presentation/pages/auth/auth_page.dart';
import 'package:constructor/presentation/pages/home/home_page.dart';
import 'package:constructor/presentation/pages/splash/splash_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:get_storage/get_storage.dart';

void main() async {
  await GetStorage.init("constructor");
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AppBloc()..add(SplashEvent()),
      child: BlocBuilder<AppBloc, AppState>(
        builder: (context, state) {
          bool isDarkMode = false;

          if (state is AppThemeChangedState) {
            isDarkMode = state.isDarkMode;
          }

          return MaterialApp(
            debugShowCheckedModeBanner: false,
            title: AppConstants.appName,
            localizationsDelegates: const [
              GlobalMaterialLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
              GlobalCupertinoLocalizations.delegate,
            ],
            supportedLocales: const [
              Locale('en'),
              Locale('uz'),
              Locale('ru'),
            ],
            // Standart tilni o'rnatamiz
            locale: const Locale('uz'),
            theme: isDarkMode ? AppTheme.darkTheme : AppTheme.lightTheme,
            home: state is AppSplashState
                ? const SplashPage()
                : state is AppAuthenticatedState
                    ? const HomePage()
                    : const AuthPage(),
          );
        },
      ),
    );
  }
}
