import 'dart:developer';

import 'package:constructor/core/themes/colors.dart';
import 'package:constructor/extensions/datetime.dart';
import 'package:flutter/material.dart';

class PrintingDetailsPage extends StatelessWidget {
  final Map orderPrintingTimeData;

  const PrintingDetailsPage({
    super.key,
    required this.orderPrintingTimeData,
  });

  @override
  Widget build(BuildContext context) {
    final DateTime plannedTime = DateTime.parse(orderPrintingTimeData['planned_time']);
    final DateTime? actualTime = DateTime.tryParse(orderPrintingTimeData['actual_time'] ?? "");
    final String comment = orderPrintingTimeData['comment'] ?? '';
    final Map user = orderPrintingTimeData['user'] ?? {};
    final Map model = orderPrintingTimeData['model'] ?? {};
    final List submodels = orderPrintingTimeData['submodels'] ?? [];

    return Scaffold(
      appBar: AppBar(
        title: Text('${model['name'] ?? 'No Name'}'),
      ),
      body: SingleChildScrollView(
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
                    color: AppColors.dark.withValues(alpha: 0.1),
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
            submodels.isEmpty
                ? Center(
                    child: Text(
                      'Submodelar yo\'q',
                      style: TextTheme.of(context).titleMedium,
                    ),
                  )
                : GridView.builder(
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 16.0,
                      mainAxisSpacing: 16.0,
                    ),
                    physics: NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: submodels.length,
                    itemBuilder: (context, index) {
                      if (index == 0) {
                        inspect(submodels[index]);
                      }
                      Map submodel = submodels[index]['submodel'] ?? {};
                      List sizes = submodels[index]['sizes'] ?? [];

                      return Container(
                        margin: const EdgeInsets.only(top: 16.0),
                        padding: const EdgeInsets.all(16.0),
                        decoration: BoxDecoration(
                          color: AppColors.light,
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              '${submodel['name']}',
                              style: TextTheme.of(context).titleMedium?.copyWith(
                                    fontWeight: FontWeight.bold,
                                  ),
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
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
                                    children: sizes
                                        .map(
                                          (size) => Text(
                                            '${size['name']} - ${size['count']} ta',
                                            style: TextTheme.of(context).titleSmall,
                                          ),
                                        )
                                        .toList(),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      );
                    },
                  ),
          ],
        ),
      ),
    );
  }
}
