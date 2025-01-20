import 'package:constructor/core/constants/app_constants.dart';
import 'package:constructor/presentation/bloc/home/home_bloc.dart';
import 'package:constructor/presentation/pages/home/order_details_page.dart';
import 'package:constructor/presentation/widgets/app_widgets/order_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => HomeBloc()..add(LoadHomeDataEvent()),
      child: Scaffold(
        appBar: AppBar(
          title: const Text(
            AppConstants.appName,
          ),
        ),
        body: BlocBuilder<HomeBloc, HomeState>(
          builder: (context, state) {
            var homeBloc = context.read<HomeBloc>();

            if (state is HomeLoadingState) {
              return Center(
                child: CircularProgressIndicator(),
              );
            }

            if (state is HomeLoadedState) {
              return RefreshIndicator(
                onRefresh: () async {
                  context.read<HomeBloc>().add(LoadHomeDataEvent());
                },
                child: state.orders.isNotEmpty
                    ? GridView.builder(
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          mainAxisSpacing: 8,
                          crossAxisSpacing: 8,
                        ),
                        padding: EdgeInsets.all(8),
                        itemCount: state.orders.length,
                        itemBuilder: (context, index) {
                          Map order = state.orders[index];

                          return OrderCard(
                            order: order,
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) {
                                  return BlocProvider.value(
                                    value: homeBloc,
                                    child: OrderDetailsPage(orderIndex: index),
                                  );
                                }),
                              );
                            },
                          );
                        },
                      )
                    : ListView(
                        physics: AlwaysScrollableScrollPhysics(),
                        itemExtent: MediaQuery.of(context).size.height - 100,
                        children: [
                          Center(
                            child: Text(
                              "Buyurtmalar ro'yxati bo'sh",
                            ),
                          ),
                        ],
                      ),
              );
            }

            return Center(
              child: Text(
                'Home Page',
              ),
            );
          },
        ),
      ),
    );
  }
}

// Home Widgets
