import 'package:cinelens/common/widgets/alerts.dart';
import 'package:cinelens/core/navigation/navigation.dart';
import 'package:cinelens/data/models/user_req.dart';
import 'package:cinelens/presentation/auth/bloc/auth_cubit.dart';
import 'package:cinelens/presentation/auth/bloc/auth_state.dart';
import 'package:cinelens/presentation/home/pages/home.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'sign_up.dart';

class SignIn extends StatefulWidget {
  const SignIn({super.key});

  @override
  State<SignIn> createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  final _formKey = GlobalKey<FormState>();

  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  bool _isPasswordVisible = false;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _signIn() {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    final user = UserReq(
      email: _emailController.text.trim(),
      password: _passwordController.text,
    );

    context.read<AuthCubit>().signIn(user: user);
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthCubit, AuthState>(
      listener: (context, state) {
        if (state is AuthSuccess) {
          Alerts.showSuccess(context, 'Signed in successfully');
          Navigation.pushReplacement(context, const Home());
        }

        if (state is AuthFailure) {
          Alerts.showError(context, state.message);
        }
      },
      child: Scaffold(
        body: SafeArea(
          minimum: const EdgeInsets.fromLTRB(20, 100, 20, 0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                _topText(),

                const SizedBox(height: 25),

                _emailInput(),

                const SizedBox(height: 16),

                _passwordInput(),

                const SizedBox(height: 24),

                BlocBuilder<AuthCubit, AuthState>(
                  builder: (context, state) {
                    final isLoading = state is AuthLoading;

                    return SizedBox(
                      height: 50,
                      width: 400,
                      child: ElevatedButton(
                        onPressed: isLoading ? null : _signIn,
                        child: Text(isLoading ? 'Signing in...' : 'Sign in'),
                      ),
                    );
                  },
                ),

                const SizedBox(height: 10),

                _belowButtonText(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _topText() {
    return const Text(
      'Sign in',
      style: TextStyle(
        color: Colors.white,
        fontWeight: FontWeight.w600,
        fontSize: 28,
      ),
    );
  }

  Widget _emailInput() {
    return TextFormField(
      controller: _emailController,
      keyboardType: TextInputType.emailAddress,
      textInputAction: TextInputAction.next,
      decoration: const InputDecoration(
        labelText: 'Email',
        hintText: 'Enter your email',
        prefixIcon: Icon(Icons.email_outlined),
      ),
      validator: (value) {
        final email = value?.trim() ?? '';

        if (email.isEmpty) {
          return 'Email is required';
        }

        if (!email.contains('@') || !email.contains('.')) {
          return 'Enter a valid email';
        }

        return null;
      },
    );
  }

  Widget _passwordInput() {
    return TextFormField(
      controller: _passwordController,
      obscureText: !_isPasswordVisible,
      textInputAction: TextInputAction.done,
      decoration: InputDecoration(
        labelText: 'Password',
        hintText: 'Enter your password',
        prefixIcon: const Icon(Icons.lock_outline),
        helperText: ' ',
        suffixIcon: IconButton(
          onPressed: () {
            setState(() {
              _isPasswordVisible = !_isPasswordVisible;
            });
          },
          icon: Icon(
            _isPasswordVisible
                ? Icons.visibility_outlined
                : Icons.visibility_off_outlined,
          ),
        ),
      ),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Password is required';
        }

        if (value.length < 6) {
          return 'Password must be at least 6 characters';
        }

        return null;
      },
    );
  }

  Widget _belowButtonText() {
    return Text.rich(
      TextSpan(
        children: [
          const TextSpan(
            text: 'Do not have account? ',
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.w500),
          ),
          TextSpan(
            text: 'Sign Up',
            style: const TextStyle(
              color: Colors.blue,
              fontWeight: FontWeight.w400,
            ),
            recognizer: TapGestureRecognizer()
              ..onTap = () {
                Navigation.pushReplacement(context, const SignUp());
              },
          ),
        ],
      ),
    );
  }
}
