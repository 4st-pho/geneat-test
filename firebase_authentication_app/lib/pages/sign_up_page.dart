import 'package:firebase_authentication_app/blocs/signup/sign_up_cubit.dart';
import 'package:firebase_authentication_app/constants/app_strings.dart';
import 'package:firebase_authentication_app/constants/app_text_style.dart';
import 'package:firebase_authentication_app/constants/route_configure.dart';
import 'package:firebase_authentication_app/pages/widgets/auth_text_form_field.dart';
import 'package:firebase_authentication_app/utils/error_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:validators/validators.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => SignUpPageState();
}

class SignUpPageState extends State<SignUpPage> {
  final _formKey = GlobalKey<FormState>();
  late final TextEditingController _emailController;
  late final TextEditingController _nameController;
  late final TextEditingController _passwordController;

  void formSubmit() {
    if (_formKey.currentState!.validate()) {
      context.read<SignUpCubit>().signUp(
            name: _nameController.text.trim(),
            email: _emailController.text.trim(),
            password: _passwordController.text.trim(),
          );
    }
  }

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController();
    _emailController = TextEditingController();
    _passwordController = TextEditingController();
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<SignUpCubit, SignUpState>(
      listener: (context, state) {
        if (state.signUpStatus == SignUpStatus.error) {
          errorDialog(context, state.error);
        }
        if (state.signUpStatus == SignUpStatus.success) {
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
              _buildNameTextFormField(),
              _buildEmailTextFormField(),
              _buildPasswordTextFormField(),
              _confirmPasswordTextFormField(),
              _buildSignUpButton(),
              const SizedBox(height: 10),
              _buildLoginButton(context)
            ],
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

  Widget _buildNameTextFormField() {
    return AuthTextFormField(
      controller: _nameController,
      textInputAction: TextInputAction.next,
      labelText: AppStrings.name,
      prefixIcon: const Icon(Icons.account_box),
      validator: (String? value) {
        if (value == null || value.trim().isEmpty) {
          return AppStrings.nameRequired;
        }
        if (value.trim().length < 2) {
          return AppStrings.nameMinLengthWaring;
        }
        return null;
      },
    );
  }

  Widget _buildEmailTextFormField() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: AuthTextFormField(
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
            return AppStrings.emailRequired;
          }
          return null;
        },
      ),
    );
  }

  Widget _buildPasswordTextFormField() {
    return AuthTextFormField(
      controller: _passwordController,
      obscureText: true,
      textInputAction: TextInputAction.next,
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
    );
  }

  Widget _confirmPasswordTextFormField() {
    return Padding(
      padding: const EdgeInsets.only(top: 10, bottom: 20),
      child: AuthTextFormField(
        obscureText: true,
        textInputAction: TextInputAction.done,
        labelText: AppStrings.confirmPassword,
        prefixIcon: const Icon(Icons.password),
        validator: (String? value) {
          if (value != null && value != _passwordController.text) {
            return AppStrings.passwordNotMatch;
          }
          return null;
        },
        onFieldSubmitted: (_) => formSubmit(),
      ),
    );
  }

  Widget _buildSignUpButton() {
    return BlocBuilder<SignUpCubit, SignUpState>(
      builder: (context, state) {
        final isLoading = state.signUpStatus == SignUpStatus.submitting;
        return ElevatedButton(
          onPressed: isLoading ? null : () => formSubmit(),
          style: ElevatedButton.styleFrom(
            elevation: 0,
            textStyle: AppTextStyle.fs20pxBold,
            padding: const EdgeInsets.all(12),
          ),
          child: Text(isLoading ? AppStrings.loading : AppStrings.signUp),
        );
      },
    );
  }

  Widget _buildLoginButton(BuildContext context) {
    return TextButton(
      onPressed: () {
        Navigator.of(context).pop();
      },
      style: TextButton.styleFrom(textStyle: AppTextStyle.fs20pxUnderline),
      child: const Text(AppStrings.alreadyHaveAnAccount),
    );
  }
}
