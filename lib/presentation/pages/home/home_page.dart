import 'package:constructor/core/constants/app_constants.dart';
import 'package:constructor/extensions/datetime.dart';
import 'package:constructor/presentation/bloc/home/home_bloc.dart';
import 'package:constructor/presentation/pages/home/printing_details_page.dart';
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
          title: const Text(AppConstants.appName),
        ),
        body: BlocBuilder<HomeBloc, HomeState>(
          builder: (context, state) {
            var homeBloc = context.read<HomeBloc>();

            return Column(
              children: [
                GestureDetector(
                  onTap: () async {
                    var date = await showDatePicker(
                      context: context,
                      locale: Locale('uz', 'UZ'),
                      initialDate: homeBloc.plannedDate,
                      firstDate: DateTime.now().subtract(Duration(days: 7)),
                      lastDate: DateTime.now().add(Duration(days: 7)),
                    );

                    if (date != null) {
                      homeBloc.add(ChangePlannedDateEvent(date));
                    }
                  },
                  child: Container(
                    width: double.infinity,
                    height: 50,
                    margin: EdgeInsets.only(left: 12, top: 8, right: 12),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(100),
                      color: Colors.white,
                    ),
                    child: Stack(
                      children: [
                        Align(
                          alignment: Alignment.center,
                          child: Text(
                            homeBloc.plannedDate.toYMD,
                            style: TextTheme.of(context).titleMedium,
                          ),
                        ),
                        Align(
                          alignment: Alignment.centerRight,
                          child: IconButton(
                            onPressed: () async {
                              var date = await showDatePicker(
                                context: context,
                                initialDate: homeBloc.plannedDate,
                                firstDate: DateTime.now().subtract(Duration(days: 7)),
                                lastDate: DateTime.now().add(Duration(days: 7)),
                              );

                              if (date != null) {
                                homeBloc.add(ChangePlannedDateEvent(date));
                              }
                            },
                            icon: Icon(Icons.calendar_today),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                if (state is HomeLoadingState)
                  Expanded(
                    child: Center(
                      child: CircularProgressIndicator(),
                    ),
                  ),
                if (state is HomeLoadedState)
                  Expanded(
                    child: RefreshIndicator(
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
                                  onPressed: () async {
                                    await Navigator.push(
                                      context,
                                      MaterialPageRoute(builder: (context) {
                                        return BlocProvider.value(
                                          value: homeBloc,
                                          child: PrintingDetailsPage(
                                            order: order,
                                          ),
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
                    ),
                  ),
              ],
            );
          },
        ),
      ),
    );
  }
}

// Home Widgets
