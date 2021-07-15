import 'package:chat_app/services/auth_services.dart';
import 'package:chat_app/services/socket_service.dart';
import 'package:chat_app/utils/alerts.dart';
import 'package:chat_app/utils/validate-field.dart';
import 'package:chat_app/widgets/alert_dialog.dart';
import 'package:chat_app/widgets/buttonBlue.dart';
import 'package:chat_app/widgets/custon_input.dart';
import 'package:chat_app/widgets/labels_footer.dart';
import 'package:chat_app/widgets/logo_app.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({Key? key}) : super(key: key);
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
                  Logo(
                    title: "Login",
                  ),
                  _Form(),
                  LabeStartPages(
                    page: "register",
                    textLabel: "Register!",
                    textIntial: "¿You do not have an account?",
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

class __FormState extends State<_Form> with TickerProviderStateMixin {
  final emailCrtl = TextEditingController();
  final paswordCtrl = TextEditingController();
  bool errorPassword = false,
      errorEmail = false,
      valid = true,
      charging = false;

  @override
  Widget build(BuildContext context) {
    AnimationController animatedCrtl = AnimationController(vsync: this);
    return Form(
      key: _formKey,
      child: Container(
        margin: EdgeInsets.only(top: 10),
        padding: EdgeInsets.symmetric(horizontal: 50),
        child: Column(
          children: [
            CustonInput(
              icon: Icons.email_outlined,
              placeholder: "Email",
              isError: errorEmail,
              keyBoardtype: TextInputType.emailAddress,
              textController: emailCrtl,
            ),
            CustonInput(
              icon: Icons.lock_outlined,
              placeholder: "Password",
              isError: errorPassword,
              keyBoardtype: TextInputType.visiblePassword,
              isPasword: true,
              textController: paswordCtrl,
            ),
            SizedBox(
              height: 10,
            ),
            !valid
                ? AnimatedContainer(
                    duration: Duration(milliseconds: 500),
                    curve: Curves.easeOut,
                    child: Text(
                      "Campos Obligatorios",
                      style: TextStyle(fontSize: 15.0, color: Colors.red),
                    ))
                : Center(),
            SizedBox(
              height: 10,
            ),
            !charging
                ? ButtomBlue(
                    makeFn: () {
                      login();
                    },
                    textButton: "Login")
                : CircularProgressIndicator()
          ],
        ),
      ),
    );
  }

  login() async {
    FocusScope.of(context).unfocus();
    setState(() {
      charging = true;
    });
    if (!validatedField()) {
      setState(() {
        charging = false;
      });
      return;
    }
    final authService = Provider.of<AuthServices>(context, listen: false);
    final socketServer = Provider.of<SocketService>(context, listen: false);
    final resp = await authService.login(emailCrtl.text, paswordCtrl.text);
    setState(() {
      charging = false;
    });
    if (resp) {
      socketServer.connect();
      Navigator.popAndPushNamed(context, "user");
    } else {
      showAlert(context, "Error", "Correo o contraseña incorrectas");
    }
  }

  bool validatedField() {
    if (!validatedEmail(emailCrtl.text)) {
      errorEmail = true;
    } else {
      errorEmail = false;
    }

    if (!isInputEmpty(paswordCtrl.text)) {
      errorPassword = true;
    } else {
      errorPassword = false;
    }

    if (errorEmail || errorPassword) {
      valid = false;
    } else {
      valid = true;
    }

    return valid;
  }
}
