import 'package:constructor/core/themes/colors.dart';
import 'package:constructor/extensions/datetime.dart';
import 'package:constructor/presentation/bloc/home/home_bloc.dart';
import 'package:constructor/presentation/widgets/custom_snackbars.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';

class PrintingDetailsPage extends StatelessWidget {
  final Map order;

  const PrintingDetailsPage({
    super.key,
    required this.order,
  });

  @override
  Widget build(BuildContext context) {
    final Map orderPrintingTimeData = order['order_printing_time'] ?? {};
    final List instructions = order['instructions'] ?? [];

    final DateTime plannedTime = DateTime.parse(orderPrintingTimeData['planned_time']);
    final DateTime? actualTime = DateTime.tryParse(orderPrintingTimeData['actual_time'] ?? "");
    final String comment = orderPrintingTimeData['comment'] ?? '';
    final Map user = orderPrintingTimeData['user'] ?? {};
    final Map model = orderPrintingTimeData['model'] ?? {};
    final List submodels = orderPrintingTimeData['submodels'] ?? [];
    final List sizes = orderPrintingTimeData['sizes'] ?? [];
    final String status = orderPrintingTimeData['status'] ?? '';

    return Scaffold(
      appBar: AppBar(
        title: Text('${model['name'] ?? 'No Name'}'),
      ),
      body: BlocConsumer<HomeBloc, HomeState>(
        listener: (context, state) {
          if (state is HomeMessageState) {
            if (state.type == MessageType.error) {
              CustomSnackbars(context).error(state.message);
            } else if (state.type == MessageType.success) {
              CustomSnackbars(context).success(state.message);
              Navigator.pop(context, true);
            }
          }
        },
        builder: (context, state) {
          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              spacing: 8.0,
              children: [
                Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: AppColors.light,
                    borderRadius: BorderRadius.circular(8.0),
                    boxShadow: [
                      BoxShadow(
                        color: AppColors.dark.withValues(alpha: 0.05),
                        blurRadius: 8.0,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text.rich(
                        TextSpan(
                          children: [
                            TextSpan(
                              text: 'Reja: ',
                              style: TextTheme.of(context).bodyLarge,
                            ),
                            TextSpan(
                              text: plannedTime.toLocal().toHM,
                              style: TextTheme.of(context).titleSmall?.copyWith(
                                    fontWeight: FontWeight.bold,
                                  ),
                            ),
                          ],
                        ),
                      ),
                      Text.rich(
                        TextSpan(
                          children: [
                            TextSpan(
                              text: 'Bajarildi: ',
                              style: TextTheme.of(context).bodyLarge,
                            ),
                            TextSpan(
                              text: actualTime?.toLocal().toHM ?? 'N/A',
                              style: TextTheme.of(context).titleSmall?.copyWith(
                                    fontWeight: FontWeight.bold,
                                  ),
                            ),
                          ],
                        ),
                      ),
                      if (actualTime == null)
                        Text.rich(
                          TextSpan(
                            children: [
                              TextSpan(
                                text: 'Holat: ',
                                style: TextTheme.of(context).bodyLarge,
                              ),
                              TextSpan(
                                text: 'bajarilmagan',
                                style: TextTheme.of(context).titleSmall?.copyWith(
                                      fontWeight: FontWeight.bold,
                                      color: AppColors.danger,
                                    ),
                              ),
                            ],
                          ),
                        ),
                      if (user.isNotEmpty)
                        Text.rich(
                          TextSpan(
                            children: [
                              TextSpan(
                                text: 'Masul: ',
                                style: TextTheme.of(context).bodyLarge,
                              ),
                              TextSpan(
                                text: '${user['employee']['name']}',
                                style: TextTheme.of(context).titleSmall?.copyWith(
                                      fontWeight: FontWeight.bold,
                                    ),
                              ),
                            ],
                          ),
                        ),
                      if (comment.isNotEmpty)
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Izoh: ',
                              style: TextTheme.of(context).bodyLarge,
                            ),
                            Container(
                              width: double.infinity,
                              padding: const EdgeInsets.all(8.0),
                              decoration: BoxDecoration(
                                color: AppColors.secondary,
                                borderRadius: BorderRadius.circular(6.0),
                              ),
                              child: Text(
                                comment,
                                style: TextTheme.of(context).titleSmall,
                              ),
                            ),
                          ],
                        )
                    ],
                  ),
                ),
                Expanded(
                  child: submodels.isEmpty
                      ? Center(
                          child: Text(
                            'Submodelar yo\'q',
                            style: TextTheme.of(context).titleMedium,
                          ),
                        )
                      : SingleChildScrollView(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            spacing: 8.0,
                            children: [
                              if (submodels.isNotEmpty)
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "Submodellar:",
                                      style: TextTheme.of(context).titleMedium,
                                    ).marginOnly(left: 8.0),
                                    ListView.builder(
                                      shrinkWrap: true,
                                      physics: NeverScrollableScrollPhysics(),
                                      itemCount: submodels.length,
                                      itemBuilder: (context, index) {
                                        Map submodel = submodels[index]['submodel'] ?? {};

                                        return Container(
                                          padding: const EdgeInsets.all(8.0),
                                          margin: const EdgeInsets.only(bottom: 8.0),
                                          decoration: BoxDecoration(
                                            color: AppColors.light,
                                            borderRadius: BorderRadius.circular(8.0),
                                          ),
                                          child: Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            spacing: 4.0,
                                            children: [
                                              Text(
                                                '${submodel['name']}',
                                                style: TextTheme.of(context).titleMedium?.copyWith(
                                                      fontWeight: FontWeight.bold,
                                                    ),
                                              ).paddingOnly(left: 8.0),
                                              Text(
                                                'O\'lchamlar: ',
                                                style: TextTheme.of(context).titleSmall,
                                              ),
                                              Container(
                                                width: double.infinity,
                                                padding: const EdgeInsets.all(8.0),
                                                decoration: BoxDecoration(
                                                  color: AppColors.secondary,
                                                  borderRadius: BorderRadius.circular(6.0),
                                                ),
                                                child: Wrap(
                                                  spacing: 8.0,
                                                  runSpacing: 8.0,
                                                  children: sizes
                                                      .map(
                                                        (size) => Text.rich(
                                                          TextSpan(
                                                            children: [
                                                              TextSpan(
                                                                text: '${size['size']['name']}',
                                                                style: TextTheme.of(context).titleSmall?.copyWith(
                                                                      // color: AppColors.light,
                                                                      fontWeight: FontWeight.bold,
                                                                    ),
                                                              ),
                                                              TextSpan(
                                                                text: ' — ${size['quantity']} ta,',
                                                                style: TextTheme.of(context).titleSmall?.copyWith(
                                                                    // color: AppColors.light,
                                                                    ),
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                      )
                                                      .toList(),
                                                ),
                                              ),
                                            ],
                                          ),
                                        );
                                      },
                                    ),
                                  ],
                                ),
                              if (instructions.isNotEmpty)
                                Column(
                                  children: [
                                    Row(
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.only(left: 8, top: 16.0, bottom: 4.0),
                                          child: Text(
                                            "Instruksiyalar:",
                                            style: TextTheme.of(context).titleMedium,
                                          ),
                                        ),
                                      ],
                                    ),
                                    ListView.builder(
                                      shrinkWrap: true,
                                      physics: NeverScrollableScrollPhysics(),
                                      itemCount: instructions.length,
                                      itemBuilder: (context, index) {
                                        Map instruction = instructions[index] ?? {};

                                        return Container(
                                          margin: const EdgeInsets.only(bottom: 8.0),
                                          padding: const EdgeInsets.all(8.0),
                                          decoration: BoxDecoration(
                                            color: AppColors.light,
                                            borderRadius: BorderRadius.circular(8.0),
                                          ),
                                          child: Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            spacing: 4.0,
                                            children: [
                                              Text(
                                                '${instruction['title']}',
                                                style: TextTheme.of(context).titleMedium?.copyWith(
                                                      fontWeight: FontWeight.bold,
                                                    ),
                                              ).paddingOnly(left: 8.0),
                                              Container(
                                                width: double.infinity,
                                                padding: const EdgeInsets.all(8.0),
                                                decoration: BoxDecoration(
                                                  color: AppColors.secondary,
                                                  borderRadius: BorderRadius.circular(6.0),
                                                ),
                                                child: Text("${instruction['description']}"),
                                              ),
                                            ],
                                          ),
                                        );
                                      },
                                    ),
                                  ],
                                ),
                              if (order['comment'] != null && order['comment'].isNotEmpty)
                                Container(
                                  decoration: BoxDecoration(
                                    color: AppColors.light,
                                    borderRadius: BorderRadius.circular(8.0),
                                    boxShadow: [
                                      BoxShadow(
                                        color: AppColors.dark.withValues(alpha: 0.05),
                                        blurRadius: 8.0,
                                        offset: const Offset(0, 2),
                                      ),
                                    ],
                                  ),
                                  padding: EdgeInsets.all(8.0),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    spacing: 8,
                                    children: [
                                      Text(
                                        'Izoh: ',
                                        style: TextTheme.of(context).titleMedium,
                                      ).paddingOnly(left: 8.0),
                                      Container(
                                        width: double.infinity,
                                        padding: const EdgeInsets.all(8.0),
                                        decoration: BoxDecoration(
                                          color: AppColors.secondary,
                                          borderRadius: BorderRadius.circular(6.0),
                                        ),
                                        child: Text(
                                          order['comment'] + "asdihwhd9 2d9h98 d2983h d298dh92 d3h9",
                                          style: TextTheme.of(context).titleSmall,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              SizedBox.shrink(),
                            ],
                          ),
                        ),
                ),
                TextButton(
                  onPressed: () {
                    if (status == 'printing') {
                      context.read<HomeBloc>().add(ChangeOrderPrintingStatusEvent(orderPrintingTimeData['id']));
                    }
                  },
                  style: TextButton.styleFrom(
                    backgroundColor: status == 'printing' ? AppColors.primary : AppColors.dark.withValues(alpha: 0.5),
                    fixedSize: const Size(double.infinity, 48.0),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        status != 'printing' ? 'Bajarilgan' : 'Bajarish',
                        style: TextTheme.of(context).titleMedium?.copyWith(
                              color: AppColors.light,
                            ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

/*

{
  "id": 3,
  "planned_time": "2025-01-19 18:47:53",
  "actual_time": "2025-01-19 18:47:56",
  "status": "printing",
  "comment": null,
  "model": {
      "id": 50,
      "name": "Prezident",
      "rasxod": "0.5"
  },
  "submodels": [
      {
          "id": 102,
          "submodel": {
              "id": 67,
              "name": "Kastyum4"
          },
          "total_quantity": 0
      },
      {
          "id": 103,
          "submodel": {
              "id": 68,
              "name": "123-23"
          },
          "total_quantity": 0
      }
  ],
  "sizes": [
      {
          "id": 5,
          "size": {
              "id": 149,
              "name": "123-12"
          },
          "quantity": 1
      },
      {
          "id": 6,
          "size": {
              "id": 150,
              "name": "12-21"
          },
          "quantity": 1
      }
  ]
}
*/
