import 'package:constructor/core/themes/colors.dart';
import 'package:constructor/presentation/bloc/app/app_bloc.dart';
import 'package:constructor/presentation/bloc/auth/auth_bloc.dart';
import 'package:constructor/presentation/widgets/custom_input.dart';
import 'package:constructor/presentation/widgets/custom_snackbars.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AuthPage extends StatelessWidget {
  const AuthPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (cotntext) => AuthBloc(),
      child: BlocListener<AuthBloc, AuthState>(
        listener: (context, state) {
          if (state is AuthSuccessState) {
            context.read<AppBloc>().add(CheckAuthEvent());
          } else if (state is AuthErrorState) {
            CustomSnackbars(context).error(state.message);
          }
        },
        child: LoginScreen(),
      ),
    );
  }
}

class LoginScreen extends StatelessWidget {
  LoginScreen({super.key});

  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          width: 350,
          padding: const EdgeInsets.all(24),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(8),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withValues(alpha: 0.2),
                spreadRadius: 3,
                blurRadius: 7,
                offset: const Offset(0, 3),
              ),
            ],
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'Kirish',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: AppColors.primary,
                ),
              ),
              const SizedBox(height: 16),
              CustomInput(
                controller: usernameController,
                hint: 'Username',
              ),
              const SizedBox(height: 8),
              CustomInput(
                controller: passwordController,
                hint: 'Parol',
              ),
              const SizedBox(height: 24),
              TextButton(
                onPressed: () {
                  final authBloc = context.read<AuthBloc>();

                  if (authBloc.state is AuthLoadingState) {
                    return;
                  }

                  if (usernameController.text.isEmpty ||
                      passwordController.text.isEmpty) {
                    CustomSnackbars(context)
                        .warning("Username va parolni kiriting!");
                    return;
                  }

                  authBloc.add(LoginEvent(
                    username: usernameController.text,
                    password: passwordController.text,
                  ));
                },
                child: BlocBuilder<AuthBloc, AuthState>(
                  builder: (context, state) {
                    // if state us AuthLoading return loading widget
                    return Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: state is AuthLoadingState
                          ? [
                              SizedBox.square(
                                dimension: 24,
                                child: CircularProgressIndicator(
                                  color: AppColors.light,
                                ),
                              )
                            ]
                          : [
                              const Icon(
                                Icons.login,
                                color: Colors.white,
                              ),
                              const SizedBox(width: 8),
                              const Text('Kirish'),
                            ],
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
