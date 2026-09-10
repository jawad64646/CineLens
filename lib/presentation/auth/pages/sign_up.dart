import 'package:cinelens/common/widgets/alerts.dart';
import 'package:cinelens/core/navigation/navigation.dart';
import 'package:cinelens/data/models/user_req.dart';
import 'package:cinelens/presentation/auth/bloc/auth_cubit.dart';
import 'package:cinelens/presentation/auth/bloc/auth_state.dart';
import 'package:cinelens/presentation/auth/pages/sign_in.dart';
import 'package:cinelens/presentation/home/pages/home.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SignUp extends StatefulWidget {
  const SignUp({super.key});

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  // Form key
  final _formKey = GlobalKey<FormState>();

  // Controllers
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  // Controls whether the password is hidden or visible.
  bool _isPasswordVisible = false;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _signUp() {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    final user = UserReq(
      email: _emailController.text.trim(),
      password: _passwordController.text,
    );

    context.read<AuthCubit>().signUp(user: user);
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthCubit, AuthState>(
      listener: (context, state) {
        if (state is AuthSuccess) {
          Alerts.showSuccess(context, 'Account created successfully');
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
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                _topText(),
                const SizedBox(height: 32),
                _emailInput(),
                const SizedBox(height: 16),
                _passwordInput(),
                const SizedBox(height: 32),
                BlocBuilder<AuthCubit, AuthState>(
                  builder: (context, state) {
                    final isLoading = state is AuthLoading;

                    return SizedBox(
                      height: 50,
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: isLoading ? null : _signUp,
                        child: Text(isLoading ? 'Signing Up...' : 'Sign Up'),
                      ),
                    );
                  },
                ),
                const SizedBox(height: 20),
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
      'Sign Up',
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
            text: "Do you have account? ",
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.w500),
          ),
          TextSpan(
            text: "Sign In",
            style: const TextStyle(
              color: Colors.blue,
              fontWeight: FontWeight.w400,
            ),
            recognizer: TapGestureRecognizer()
              ..onTap = () {
                Navigation.pushReplacement(context, const SignIn());
              },
          ),
        ],
      ),
    );
  }
}
