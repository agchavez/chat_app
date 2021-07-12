import 'package:chat_app/widgets/buttonBlue.dart';
import 'package:chat_app/widgets/custon_input.dart';
import 'package:chat_app/widgets/labels_footer.dart';
import 'package:chat_app/widgets/logo_app.dart';
import 'package:flutter/material.dart';

class RegisterPage extends StatelessWidget {
  const RegisterPage({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color(0xffF2F2F2),
        body: SafeArea(
            child: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Container(
            height: MediaQuery.of(context).size.height * 0.9,
            child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Logo(title: "Register"),
                  _Form(),
                  LabeStartPages(
                    page: "login",
                    textLabel: "Login!",
                    textIntial: "¿you already have an account?",
                  ),
                  Text(
                    "Terminos y condiciones de uso",
                    style: TextStyle(fontWeight: FontWeight.w400),
                  ),
                ]),
          ),
        )));
  }
}

final _formKey = GlobalKey<FormState>();

class _Form extends StatefulWidget {
  const _Form({Key? key}) : super(key: key);

  @override
  __FormState createState() => __FormState();
}

class __FormState extends State<_Form> {
  final emailCrtl = TextEditingController();
  final paswordCtrl = TextEditingController();
  final nameCrtl = TextEditingController();
  final phoneCtrl = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Container(
        margin: EdgeInsets.only(top: 10),
        padding: EdgeInsets.symmetric(horizontal: 50),
        child: Column(
          children: [
            CustonInput(
              icon: Icons.person_outline,
              placeholder: "Name",
              keyBoardtype: TextInputType.text,
              textController: nameCrtl,
            ),
            CustonInput(
              icon: Icons.lock_outlined,
              placeholder: "Number",
              keyBoardtype: TextInputType.phone,
              isPasword: true,
              textController: phoneCtrl,
            ),
            CustonInput(
              icon: Icons.email_outlined,
              placeholder: "Email",
              keyBoardtype: TextInputType.emailAddress,
              textController: emailCrtl,
            ),
            CustonInput(
              icon: Icons.lock_outlined,
              placeholder: "Password",
              keyBoardtype: TextInputType.visiblePassword,
              isPasword: true,
              textController: paswordCtrl,
            ),
            ButtomBlue(
                makeFn: () {
                  login();
                },
                textButton: "Login")
          ],
        ),
      ),
    );
  }

  login() {
    print(emailCrtl.text);
  }
}
