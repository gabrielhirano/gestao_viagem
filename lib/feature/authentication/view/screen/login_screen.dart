import 'package:flutter/material.dart';

import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:gestao_viajem_onfly/core/layout/components/app_text.dart';
import 'package:gestao_viajem_onfly/core/layout/foundation/app_shapes.dart';
import 'package:gestao_viajem_onfly/core/theme/theme_global.dart';
import 'package:gestao_viajem_onfly/feature/authentication/view/widget/email_text_field_widget.dart';
import 'package:gestao_viajem_onfly/feature/authentication/view/widget/password_text_field_widget.dart';

// Importações restantes

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  // final LoginController _controller = getIt<LoginController>();
  // late AppDialog _appDialog;

  @override
  void initState() {
    // _appDialog = AppDialog(context);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Observer(builder: (_) {
      return Scaffold(
        resizeToAvoidBottomInset: false,
        body: SingleChildScrollView(
          child: SizedBox(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            child: Stack(
              children: [
                SizedBox(
                  height: 240,
                  width: double.infinity,
                  child: Image.asset(
                    'assets/images/login.png',
                    fit: BoxFit.cover,
                  ),
                ),
                Positioned(
                  top: 220,
                  bottom: 0,
                  left: 0,
                  right: 0,
                  child: _buildLoginForm(),
                ),
              ],
            ),
          ),
        ),
      );
    });
  }

  Widget _buildLoginForm() {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: 500,
      decoration: AppShapes.decoration(
        color: appColors.white,
        customRadius: const BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
      ),
      padding: const EdgeInsets.all(20),
      child: Form(
        key: _formKey,
        child: Column(
          children: [
            EmailTextFieldWidget(controller: _emailController),
            const SizedBox(height: 20),
            PasswordTextFieldWidget(controller: _passwordController),
            const SizedBox(height: 40),
            _buildLoginButton(),
          ],
        ),
      ),
    );
  }

  Widget _buildLoginButton() {
    return Container(
      height: 40,
      decoration: AppShapes.decoration(
        color: appColors.colorBrandPrimaryBlue,
        radius: RadiusSize.circle,
      ),
      child: Center(
        child: AppText(
          text: 'Login',
          textStyle: AppTextStyle.paragraphMedium,
          textColor: appColors.white,
        ),
      ),
    );
  }

  void _onLoginButtonPressed() async {
    if (_formKey.currentState!.validate()) {
      // await _controller.authentication(
      //   email: _emailController.text,
      //   password: _passwordController.text,
      // );

      // if (_controller.dataManager.hasSucessfull) {
      //   appNavigator.navigate(const HomeScreen());
      // }

      // if (_controller.dataManager.hasFailed) {
      //   _appDialog.showAlert(message: _controller.dataManager.getMessageError);
      // }
    }
  }
}
