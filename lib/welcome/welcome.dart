import 'package:flutter/material.dart';
import 'package:ui_sample/components/button.dart';
import 'package:ui_sample/login/sign_in.dart';

class WelcomePage extends StatelessWidget {
  const WelcomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(automaticallyImplyLeading: false),
      extendBodyBehindAppBar: true,
      body: SizedBox(
        height: double.infinity,
        width: double.infinity,
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Welcome!",
                style: Theme.of(context)
                    .textTheme
                    .titleLarge!
                    .copyWith(fontWeight: FontWeight.w700, fontSize: 30),
              ),
              Text(
                "Sign In or Create New Account",
                style: Theme.of(context)
                    .textTheme
                    .bodySmall!
                    .copyWith(color: Colors.grey),
              ),
              const SizedBox(
                height: 20,
              ),
              Image.asset("assets/images/baloon.png"),
              const SizedBox(
                height: 20,
              ),
              ButtonPrimary(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const SignInPage(),
                      ),
                    );
                  },
                  text: "Go to sign in"),
              const SizedBox(
                height: 10,
              ),
              ButtonPrimary(
                onPressed: () {},
                text: "",
                textWidget: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "No account yet?",
                      style: Theme.of(context)
                          .textTheme
                          .bodySmall!
                          .copyWith(color: Colors.grey),
                    ),
                    const SizedBox(
                      width: 4,
                    ),
                    Text(
                      "Sign up",
                      style: Theme.of(context).textTheme.bodySmall!.copyWith(
                          color: Colors.red, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
                color: Colors.white,
                textColor: Colors.red,
              )
            ],
          ),
        ),
      ),
    );
  }
}
