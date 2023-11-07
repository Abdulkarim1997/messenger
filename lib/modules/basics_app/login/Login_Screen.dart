import 'package:flutter/material.dart';

import '../../../shard/components/components.dart';


class Login_Screen extends StatefulWidget {
  @override
  State<Login_Screen> createState() => _Login_ScreenState();
}

class _Login_ScreenState extends State<Login_Screen> {
  var formKey = GlobalKey<FormState>();

  var emailController = TextEditingController();

  var passwordController = TextEditingController();

  bool isPassword = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Center(
          child: SingleChildScrollView(
            child: Form(
              key: formKey,
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Login',
                      style: TextStyle(
                        fontSize: 40,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(
                      height: 40,
                    ),
                    //textFormField email
                    defaultFormField(
                        controller: emailController,
                        type: TextInputType.emailAddress,
                        lable: 'Email',
                        prefix: Icons.email,
                        validator: (value) {
                          if (value!.isEmpty) return 'email must be empty';
                          return null;
                        }),

                    const SizedBox(
                      height: 15,
                    ),
                    //textFormField password
                    defaultFormField(
                        controller: passwordController,
                        type: TextInputType.visiblePassword,
                        lable: 'password',
                        prefix: Icons.lock,
                        suffix:  isPassword ? Icons.visibility : Icons.visibility_off,
                        isPassword: isPassword,
                        suffixPressed: () {
                          setState(() {
                            isPassword = !isPassword;
                          });
                        },
                        validator: (value) {
                          if (value!.isEmpty) return 'password is too short';
                          return null;
                        }),

                    const SizedBox(
                      height: 20,
                    ),
                    defaultButton(
                      radius: 10.0,
                      function: () {
                        if (formKey.currentState!.validate()) {
                          print(emailController.text);
                          print(passwordController.text);
                        }
                      },
                      text: "login",
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    defaultButton(
                      width: 200.0,
                      function: () {
                        print("hi");
                      },
                      text: "LOgIN",
                      background: Colors.amberAccent,
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text('Don\'t have an account?'),
                        TextButton(
                          onPressed: () {},
                          child: const Text('Register Now'),
                        )
                      ],
                    )
                  ]),
            ),
          ),
        ),
      ),
    );
  }
}
