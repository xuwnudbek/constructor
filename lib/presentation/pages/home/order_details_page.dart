import 'package:constructor/presentation/bloc/home/home_bloc.dart';
import 'package:constructor/presentation/pages/home/printing_details_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../widgets/app_widgets/order_printing_card.dart';

class OrderDetailsPage extends StatelessWidget {
  final Map order;

  const OrderDetailsPage({
    super.key,
    required this.order,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "${order['name'] ?? 'Noma\'lum'}",
        ),
      ),
      body: BlocBuilder<HomeBloc, HomeState>(
        builder: (context, state) {
          var homeBloc = context.read<HomeBloc>();
          List orderPrintingTimes = order['order_printing_times'] ?? [];

          if (state is HomeLoadedState) {
            return RefreshIndicator(
              onRefresh: () async {
                // context.read<HomeBloc>().add(RefreshHomeDataEvent());
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
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) {
                          return BlocProvider.value(
                            value: homeBloc,
                            child: PrintingDetailsPage(
                              orderPrintingTimeData: orderPrintingTime,
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
