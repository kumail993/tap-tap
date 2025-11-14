import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:tap_task/core/widgets/custom_button.dart';
import 'package:tap_task/core/widgets/custom_text.dart';
import 'package:tap_task/core/widgets/custom_textfield.dart';
import 'package:tap_task/core/widgets/sizedbox.dart';
import 'package:tap_task/features/authentication/bloc/authentication_bloc.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView>
    with SingleTickerProviderStateMixin {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  late AnimationController _controller;
  late Animation<double> _fadeIn;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 900),
    );
    _fadeIn = CurvedAnimation(parent: _controller, curve: Curves.easeOut);

    _controller.forward();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocListener<AuthenticationBloc, AuthenticationState>(
        listener: (context, state) {
          if (state.isUserLoggedIn) {
            WidgetsBinding.instance.addPostFrameCallback((_) {
              context.go('/dashboard/products');
            });
          }
        },
        child: Stack(
          children: [
            Container(
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Color(0xFF0F172A),
                    Color(0xFF1E293B),
                    Color(0xFF020617),
                  ],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
              ),
            ),
            Positioned(
              top: -100,
              left: -80,
              child: _blurCircle(
                220,
                Colors.blueAccent.withValues(alpha: 0.25),
              ),
            ),
            Positioned(
              bottom: -80,
              right: -40,
              child: _blurCircle(
                180,
                Colors.cyanAccent.withValues(alpha: 0.20),
              ),
            ),
            Center(
              child: FadeTransition(
                opacity: _fadeIn,
                child: ConstrainedBox(
                  constraints: const BoxConstraints(maxWidth: 420),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(28),
                    child: BackdropFilter(
                      filter: ImageFilter.blur(sigmaX: 25, sigmaY: 25),
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 32,
                          vertical: 45,
                        ),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(28),
                          border: Border.all(
                            color: Colors.white.withValues(alpha: 0.15),
                          ),
                          gradient: LinearGradient(
                            colors: [
                              Colors.white.withValues(alpha: 0.16),
                              Colors.white.withValues(alpha: 0.05),
                            ],
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                          ),
                        ),

                        child: Form(
                          key: _formKey,
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              ShaderMask(
                                shaderCallback: (bounds) =>
                                    const LinearGradient(
                                      colors: [
                                        Color(0xFF4FACFE),
                                        Color(0xFF00F2FE),
                                      ],
                                      begin: Alignment.topLeft,
                                      end: Alignment.bottomRight,
                                    ).createShader(bounds),
                                child: const CustomText(
                                  title: "Welcome Back 👋",
                                  fontSize: 30,
                                  fontWeight: FontWeight.w700,
                                  color: Colors.white,
                                ),
                              ),

                              verticalSpace(8),

                              const CustomText(
                                title: "Login to continue",
                                fontSize: 15,
                                color: Colors.white70,
                              ),

                              verticalSpace(35),
                              CustomTextField(
                                controller: emailController,
                                hintText: "Email",
                                keyboardType: TextInputType.emailAddress,
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Please enter some text';
                                  }
                                  return null;
                                },
                              ),

                              verticalSpace(20),
                              CustomTextField(
                                controller: passwordController,
                                hintText: "Password",
                                obscureText: true,
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Please enter some text';
                                  }
                                  return null;
                                },
                              ),

                              verticalSpace(30),
                              BlocBuilder<
                                AuthenticationBloc,
                                AuthenticationState
                              >(
                                builder: (context, state) {
                                  return CustomIconButton(
                                    text: "Login",
                                    maxSize: const Size(double.infinity, 51),
                                    minSize: const Size(double.infinity, 51),
                                    backgroundColor: const Color(
                                      0xFF3B82F6,
                                    ).withValues(alpha: 0.85),
                                    textColor: Colors.white,
                                    onPressed: () {
                                      if (_formKey.currentState!.validate()) {
                                        context.read<AuthenticationBloc>().add(
                                          LoginEvent(
                                            email: emailController.text,
                                            password: passwordController.text,
                                          ),
                                        );
                                      }
                                    },
                                  );
                                },
                              ),
                              verticalSpace(20),
                              const CustomText(
                                title:
                                    "Forgot password? Contact admin to reset.",
                                fontSize: 13,
                                color: Colors.white54,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _blurCircle(double size, Color color) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(shape: BoxShape.circle, color: color),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 80, sigmaY: 80),
        child: const SizedBox(),
      ),
    );
  }
}
