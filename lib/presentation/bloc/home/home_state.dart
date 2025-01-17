part of 'home_bloc.dart';

enum MessageType {
  success,
  warning,
  error,
}

abstract class HomeState extends Equatable {
  const HomeState();

  @override
  List<Object> get props => [];
}

class HomeInitialState extends HomeState {}

class HomeLoadingState extends HomeState {}

class HomeLoadedState extends HomeState {
  final List orders;

  const HomeLoadedState(this.orders);

  @override
  List<Object> get props => [orders];
}

class HomeMessageState extends HomeState {
  final String message;
  final MessageType type;

  const HomeMessageState(
    this.message, [
    this.type = MessageType.success,
  ]);

  @override
  List<Object> get props => [message];
}
