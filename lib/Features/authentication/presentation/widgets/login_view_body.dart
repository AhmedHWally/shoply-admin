import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:shoply_admin/Features/authentication/presentation/manager/login_cubit/login_cubit.dart';
import 'package:shoply_admin/core/widgets/custom_elevated_button.dart';
import 'package:shoply_admin/core/widgets/custom_text_field.dart';

import '../../../../constants.dart';
import '../../../home/presentation/views/homeview.dart';
import '../forget_password_view.dart';

class LoginViewBody extends StatelessWidget {
  LoginViewBody({super.key});
  final GlobalKey<FormState> _formLoginKey = GlobalKey<FormState>();
  bool isLoading = false;
  String? email, password;

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return SafeArea(
      child: BlocConsumer<LoginCubit, LoginState>(
        listener: (context, state) {
          if (state is LoginLoading) {
            isLoading = true;
          } else if (state is LoginSuccess) {
            Navigator.of(context).pushReplacement(
                MaterialPageRoute(builder: (context) => const HomeView()));
            isLoading = false;
          } else if (state is LoginFailure) {
            ScaffoldMessenger.of(context)
                .showSnackBar(SnackBar(content: Text(state.errorMessage)));
            isLoading = false;
          } else {
            isLoading = false;
          }
        },
        builder: (context, state) {
          return ModalProgressHUD(
            inAsyncCall: isLoading,
            opacity: 0,
            progressIndicator:
                const CircularProgressIndicator(color: kPrimaryColor),
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Column(children: [
                const SizedBox(
                  height: 8,
                ),
                SizedBox(
                  height: height * 0.375,
                  width: width,
                  child: Image.asset(
                    kLoginImage,
                    fit: BoxFit.fill,
                  ),
                ),
                const SizedBox(
                  height: 18,
                ),
                Form(
                    key: _formLoginKey,
                    child: Column(
                      children: [
                        CustomTextField(
                          textInputType: TextInputType.emailAddress,
                          onSaved: (userEmail) {
                            email = userEmail;
                            return null;
                          },
                          hintText: 'email',
                          iconShape: Icons.alternate_email,
                          isSecure: false,
                          textInputAction: TextInputAction.next,
                        ),
                        const SizedBox(
                          height: 16,
                        ),
                        CustomTextField(
                          isPasswordFeild: true,
                          textInputType: TextInputType.visiblePassword,
                          onSaved: (userPassword) {
                            password = userPassword;
                            return null;
                          },
                          hintText: 'password',
                          iconShape: Icons.lock,
                          isSecure: true,
                          textInputAction: TextInputAction.done,
                        ),
                      ],
                    )),
                const SizedBox(
                  height: 16,
                ),
                CustomElevatedButton(
                  width: width,
                  height: height,
                  text: 'Login',
                  onPressed: () async {
                    if (_formLoginKey.currentState!.validate()) {
                      _formLoginKey.currentState!.save();
                      await BlocProvider.of<LoginCubit>(context)
                          .login(email: email!, password: password!);
                    }
                  },
                ),
                const SizedBox(
                  height: 16,
                ),
                GestureDetector(
                    onTap: () {
                      precacheImage(
                          const AssetImage(kResetPasswordImage), context);
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => const ForgetPasswordView()));
                    },
                    child: const Text(
                      'Forgot password?',
                      style: TextStyle(color: kPrimaryColor, fontSize: 16),
                    )),
              ]),
            ),
          );
        },
      ),
    );
  }
}
