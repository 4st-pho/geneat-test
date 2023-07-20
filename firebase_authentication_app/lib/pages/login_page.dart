import 'package:firebase_authentication_app/blocs/login/login_cubit.dart';
import 'package:firebase_authentication_app/constants/app_strings.dart';
import 'package:firebase_authentication_app/constants/app_text_style.dart';
import 'package:firebase_authentication_app/constants/route_configure.dart';
import 'package:firebase_authentication_app/pages/widgets/auth_text_form_field.dart';
import 'package:firebase_authentication_app/utils/error_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:validators/validators.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  late final TextEditingController _emailController;
  late final TextEditingController _passwordController;
  void formSubmit() async {
    if (_formKey.currentState!.validate()) {
      await context.read<LoginCubit>().login(
            email: _emailController.text.trim(),
            password: _passwordController.text.trim(),
          );
    }
  }

  @override
  void initState() {
    super.initState();
    _emailController = TextEditingController();
    _passwordController = TextEditingController();
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: BlocListener<LoginCubit, LoginState>(
        listener: (context, state) {
          if (state.loginStatus == LoginStatus.error) {
            errorDialog(context, state.error);
          }
          if (state.loginStatus == LoginStatus.success) {
            Navigator.of(context)
                .pushNamedAndRemoveUntil(Routes.homeRoute, (_) => false);
          }
        },
        child: Scaffold(
          body: Form(
            key: _formKey,
            child: ListView(
              padding: const EdgeInsets.all(30),
              children: [
                _buildLogo(),
                _buildEmailTextFormField(),
                _buildPasswordTextFormField(),
                _buildLoginButton(),
                const SizedBox(height: 10),
                _buildSignUpButton(context)
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildLogo() {
    return const Padding(
      padding: EdgeInsets.symmetric(vertical: 70),
      child: Center(child: FlutterLogo(size: 150)),
    );
  }

  Widget _buildEmailTextFormField() {
    return AuthTextFormField(
      controller: _emailController,
      keyboardType: TextInputType.emailAddress,
      textInputAction: TextInputAction.next,
      labelText: AppStrings.email,
      prefixIcon: const Icon(Icons.email),
      validator: (String? value) {
        if (value == null || value.trim().isEmpty) {
          return AppStrings.emailRequired;
        }
        if (!isEmail(value.trim())) {
          return AppStrings.enterAValidEmail;
        }
        return null;
      },
    );
  }

  Widget _buildPasswordTextFormField() {
    return Padding(
      padding: const EdgeInsets.only(top: 10, bottom: 20),
      child: AuthTextFormField(
        controller: _passwordController,
        obscureText: true,
        textInputAction: TextInputAction.done,
        labelText: AppStrings.password,
        prefixIcon: const Icon(Icons.password),
        validator: (String? value) {
          if (value == null || value.trim().isEmpty) {
            return AppStrings.passwordRequired;
          }
          if (value.trim().length < 6) {
            return AppStrings.passwordMinLengthWarning;
          }
          return null;
        },
        onFieldSubmitted: (_) => formSubmit(),
      ),
    );
  }

  Widget _buildLoginButton() {
    return BlocBuilder<LoginCubit, LoginState>(
      builder: (context, state) {
        final isLoading = state.loginStatus == LoginStatus.submitting;
        return ElevatedButton(
          onPressed: isLoading ? null : () => formSubmit(),
          style: ElevatedButton.styleFrom(
            elevation: 0,
            textStyle: AppTextStyle.fs20pxBold,
            padding: const EdgeInsets.all(12),
          ),
          child: Text(isLoading ? AppStrings.loading : AppStrings.login),
        );
      },
    );
  }

  Widget _buildSignUpButton(BuildContext context) {
    return TextButton(
      onPressed: () {
        Navigator.of(context).pushNamed(Routes.signupRoute);
      },
      style: TextButton.styleFrom(textStyle: AppTextStyle.fs20pxUnderline),
      child: const Text(AppStrings.notAMember),
    );
  }
}
