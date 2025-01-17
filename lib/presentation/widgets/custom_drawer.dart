import 'package:constructor/core/themes/colors.dart';
import 'package:constructor/presentation/pages/auth/auth_page.dart';
import 'package:flutter/material.dart';

class CustomDrawer extends StatefulWidget {
  const CustomDrawer({
    super.key,
  });

  @override
  State<CustomDrawer> createState() => _CustomDrawerState();
}

class _CustomDrawerState extends State<CustomDrawer> {
  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: const BoxConstraints(
        maxWidth: 250,
        minWidth: 200,
      ),
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topRight: Radius.circular(8),
          bottomRight: Radius.circular(8),
        ),
      ),
      padding: const EdgeInsets.all(8),
      // margin: const EdgeInsets.all(8),
      child: Column(
        children: [
          DrawerHeader(
            child: Column(
              children: [
                CircleAvatar(
                  radius: 40,
                  backgroundColor: AppColors.primary.withValues(alpha: 0.1),
                  child: Icon(
                    Icons.person,
                    size: 40,
                    color: AppColors.primary,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  'Technologist',
                  style: TextStyle(
                    color: AppColors.primary,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
          Divider(
            color: AppColors.primary.withValues(alpha: 0.5),
          ),
          const SizedBox(height: 8),
          ...List.generate(
            10,
            (index) {
              return ActionChip(
                label: Text('Menu $index'),
                backgroundColor: index == 0
                    ? AppColors.primary
                    : AppColors.primary.withValues(alpha: 0.1),
                onPressed: () {
                  Navigator.pop(context);
                },
                padding: const EdgeInsets.only(bottom: 8),
              );
            },
          ),
          const Spacer(),
          // Logout
          TextButton(
            style: TextButton.styleFrom(
              backgroundColor: AppColors.danger.withValues(alpha: 0.1),
              foregroundColor: AppColors.danger,
            ),
            onPressed: () async {
              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (context) => AuthPage()),
                (route) => false,
              );
            },
            child: const Row(
              children: [
                Icon(Icons.logout),
                SizedBox(width: 8),
                Text('Chiqish'),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
