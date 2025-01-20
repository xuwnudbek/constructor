part of 'home_bloc.dart';

abstract class HomeEvent extends Equatable {
  const HomeEvent();

  @override
  List<Object> get props => [];
}

class LoadHomeDataEvent extends HomeEvent {}

class ChangePlannedDateEvent extends HomeEvent {
  final DateTime date;

  const ChangePlannedDateEvent(this.date);

  @override
  List<Object> get props => [date];
}

class ChangeOrderPrintingStatusEvent extends HomeEvent {
  final int id;

  const ChangeOrderPrintingStatusEvent(this.id);

  @override
  List<Object> get props => [id];
}

class HomeMessageEvent extends HomeEvent {
  final String message;

  const HomeMessageEvent(this.message);

  @override
  List<Object> get props => [message];
}
