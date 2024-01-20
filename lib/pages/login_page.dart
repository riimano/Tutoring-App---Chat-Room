import 'package:chat_app_tutoring/components/my_bottons.dart';
import 'package:chat_app_tutoring/components/my_text_field.dart';
import 'package:chat_app_tutoring/services/auth/auth_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class loginPage extends StatefulWidget {
  final void Function()? onTap;
  const loginPage({super.key, required this.onTap});

  @override
  State<loginPage> createState() => _loginPageState();
}

class _loginPageState extends State<loginPage> {
//text controllers
  final emailController = TextEditingController();
  final passowrdController = TextEditingController();

  //sign in user

  void signIn() async {
    // get the auth service
    final authService = Provider.of<AuthService>(context, listen: false);

    try {
      await authService.signInWithEmailandPassword(
        emailController.text,
        passowrdController.text,
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            e.toString(),
          ),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(
                  height: 25,
                ),

                //logo
                Icon(
                  Icons.message,
                  size: 100,
                  color: Colors.grey[800],
                ),

                const SizedBox(
                  height: 25,
                ),

                //welcome back message
                const Text(
                  'Welcome back',
                  style: TextStyle(
                    fontSize: 16,
                  ),
                ),
                const SizedBox(
                  height: 25,
                ),
                //email text field
                MyTextField(
                    controller: emailController,
                    hintText: 'Email',
                    obscureText: false),

                const SizedBox(
                  height: 25,
                ),

                // passowrd text field

                MyTextField(
                    controller: passowrdController,
                    hintText: 'Password',
                    obscureText: true),

                const SizedBox(
                  height: 25,
                ),

                //sign in button
                MyButton(onTap: signIn, text: 'Sign In'),

                const SizedBox(
                  height: 25,
                ),

                // not a member? register now

                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      'Not  member?',
                    ),
                    const SizedBox(
                      width: 4,
                    ),
                    GestureDetector(
                      onTap: widget.onTap,
                      child: const Text(
                        'Register now',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
