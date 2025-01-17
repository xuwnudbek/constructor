part of "app_bloc.dart";

abstract class AppEvent extends Equatable {}

class ChangeThemeEvent extends AppEvent {
  final bool isDarkMode;

  ChangeThemeEvent(this.isDarkMode);

  @override
  List<Object> get props => [isDarkMode];
}

class CheckAuthEvent extends AppEvent {
  @override
  List<Object> get props => [];
}

class SplashEvent extends AppEvent {
  @override
  List<Object> get props => [];
}
