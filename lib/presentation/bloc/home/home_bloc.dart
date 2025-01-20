import 'dart:developer';

import 'package:constructor/core/constants/api_constants.dart';
import 'package:constructor/core/services/http_service.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  DateTime plannedDate = DateTime.now();

  HomeBloc() : super(HomeInitialState()) {
    on<LoadHomeDataEvent>(_onLoadHomeData);
    on<ChangePlannedDateEvent>(_onChangePlannedDate);
    on<ChangeOrderPrintingStatusEvent>(_onChangeOrderPringtingTimeStatus);
  }

  // Main methods
  Future<void> _onLoadHomeData(
    LoadHomeDataEvent event,
    Emitter<HomeState> emit,
  ) async {
    emit(HomeLoadingState());

    List orders = await _getOrders();    

    emit(HomeLoadedState(orders));
  }

  Future<void> _onChangeOrderPringtingTimeStatus(
    ChangeOrderPrintingStatusEvent event,
    Emitter<HomeState> emit,
  ) async {
    var res = await HttpService.post("${ApiConsts.orderPrintingTimes}/${event.id}", {});

    if (res['status'] == Result.success) {
      emit(HomeMessageState(
        "Order printing time updated",
      ));

      add(LoadHomeDataEvent());
    } else {
      emit(HomeMessageState(
        "Failed to update order printing time",
        MessageType.error,
      ));
    }
  }

  void _onChangePlannedDate(
    ChangePlannedDateEvent event,
    Emitter<HomeState> emit,
  ) {
    plannedDate = event.date;
    add(LoadHomeDataEvent());
  }

  // Additional methods
  Future<List> _getOrders() async {
    var res = await HttpService.get(
      ApiConsts.order,
      param: {
        'planned_time': plannedDate.toIso8601String(),
      },
    );

    if (res['status'] == Result.success) {
      return res['data'] ?? [];
    }

    return [];
  }
}
