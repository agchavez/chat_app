import 'package:chat_app/services/auth_services.dart';
import 'package:chat_app/services/socket_service.dart';
import 'package:chat_app/utils/alerts.dart';
import 'package:chat_app/utils/validate-field.dart';
import 'package:chat_app/widgets/buttonBlue.dart';
import 'package:chat_app/widgets/custon_input.dart';
import 'package:chat_app/widgets/labels_footer.dart';
import 'package:chat_app/widgets/logo_app.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

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
  bool errorName = false,
      errorEmail = false,
      errorPassword = false,
      errorPhone = false,
      charging = false,
      valid = true;

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
              isError: errorName,
              keyBoardtype: TextInputType.text,
              textController: nameCrtl,
            ),
            CustonInput(
              icon: Icons.phone_android_outlined,
              placeholder: "Number",
              isError: errorPhone,
              keyBoardtype: TextInputType.phone,
              textController: phoneCtrl,
            ),
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
              keyBoardtype: TextInputType.visiblePassword,
              isPasword: true,
              isError: errorPassword,
              textController: paswordCtrl,
            ),
            SizedBox(
              height: 10,
            ),
            !valid
                ? Center(
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
                      register();
                    },
                    textButton: "Register")
                : CircularProgressIndicator()
          ],
        ),
      ),
    );
  }

  register() async {
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
    setState(() {
      charging = false;
    });
    final authService = Provider.of<AuthServices>(context, listen: false);
    final socketServer = Provider.of<SocketService>(context, listen: false);
    final resp = await authService.register(emailCrtl.text, paswordCtrl.text,
        nameCrtl.text, int.parse(phoneCtrl.text));
    if (resp) {
      socketServer.connect();
      Navigator.popAndPushNamed(context, "user");
    } else {
      showAlert(context, "Error", "Correo o numero de telefono ya registrado");
    }
  }

  bool validatedField() {
    if (!validatedEmail(emailCrtl.text)) {
      errorEmail = true;
    } else {
      errorEmail = false;
    }

    if (!isInputEmpty(nameCrtl.text)) {
      errorName = true;
    } else {
      errorName = false;
    }
    if (!isInputEmpty(paswordCtrl.text)) {
      errorPassword = true;
    } else {
      errorPassword = false;
    }
    if (!isInputEmpty(phoneCtrl.text)) {
      errorPhone = true;
    } else {
      errorPhone = false;
    }

    if (errorEmail || errorName || errorPassword || errorPhone) {
      valid = false;
    } else {
      valid = true;
    }
    return valid;
  }
}
