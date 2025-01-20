import 'package:constructor/presentation/bloc/home/home_bloc.dart';
import 'package:constructor/presentation/pages/home/printing_details_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../widgets/app_widgets/order_printing_card.dart';

class OrderDetailsPage extends StatelessWidget {
  final int orderIndex;

  const OrderDetailsPage({
    super.key,
    required this.orderIndex,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Noma'lum",
        ),
      ),
      body: BlocBuilder<HomeBloc, HomeState>(
        builder: (context, state) {
          final homeBloc = context.read<HomeBloc>();
          
          if (state is HomeLoadingState) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }

          if (state is HomeLoadedState) {
            Map order = state.orders[orderIndex];
            List orderPrintingTimes = order['order_printing_times'] ?? [];

            return RefreshIndicator(
              onRefresh: () async {
                context.read<HomeBloc>().add(LoadHomeDataEvent());
              },
              child: GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisSpacing: 8,
                  crossAxisSpacing: 8,
                ),
                padding: EdgeInsets.all(8),
                itemCount: orderPrintingTimes.length,
                itemBuilder: (context, index) {
                  Map orderPrintingTime = orderPrintingTimes[index];

                  return OrderPrintingCard(
                    orderPrintingTimeData: Map.from(orderPrintingTime),
                    onPressed: () async {
                      Map orderData = Map.from(order)..remove("order_printing_times");
                      orderData.addAll({"order_printing_time": orderPrintingTime});

                      var res = await Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) {
                          return BlocProvider.value(
                            value: homeBloc,
                            child: PrintingDetailsPage(
                              order: orderData,
                            ),
                          );
                        }),
                      );
                    },
                  );
                },
              ),
            );
          }

          return Center(
            child: Text(
              'No Data',
            ),
          );
        },
      ),
    );
  }
}

// Home Widgets
