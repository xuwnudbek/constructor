part of 'home_bloc.dart';

abstract class HomeEvent extends Equatable {
  const HomeEvent();

  @override
  List<Object> get props => [];
}

class LoadHomeDataEvent extends HomeEvent {}

class RefreshHomeDataEvent extends HomeEvent {}

class ChangePlannedDateEvent extends HomeEvent {
  final DateTime date;

  const ChangePlannedDateEvent(this.date);

  @override
  List<Object> get props => [date];
}

class ChangeOrderPrintingStatusEvent extends HomeEvent {
  final Map orderPrintingTime;

  const ChangeOrderPrintingStatusEvent(this.orderPrintingTime);

  @override
  List<Object> get props => [orderPrintingTime];
}

class HomeMessageEvent extends HomeEvent {
  final String message;

  const HomeMessageEvent(this.message);

  @override
  List<Object> get props => [message];
}
