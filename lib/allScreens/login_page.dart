import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:ichat_app/allScreens/home_page.dart';
import 'package:ichat_app/allWidgets/loading_view.dart';
import 'package:ichat_app/allproviders/auth_provider.dart';
import 'package:provider/provider.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    AuthProvider authProvider = Provider.of<AuthProvider>(context);

    switch (authProvider.status) {
      case Status.authenticatingError:
        Fluttertoast.showToast(msg: "Signin failed");
        break;
      case Status.authenticatedCancelled:
        Fluttertoast.showToast(msg: "SignIn cancelled");
        break;
      case Status.authenticated:
        Fluttertoast.showToast(msg: 'Signin Success');
        break;
      default:
        break;
    }
    return Scaffold(
      backgroundColor: Colors.black,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Image.asset('images/back.png'),
          ),
          const SizedBox(
            height: 20,
          ),
          Padding(
            padding: const EdgeInsets.all(20),
            child: GestureDetector(
              onTap: () async {
                bool isSuccess = await authProvider.handleSignIn();
                if (isSuccess) {
                  Navigator.of(context).pushReplacement(
                      MaterialPageRoute(builder: (_) =>  HomePage()));
                }
              },
              child: Image.asset('images/google_login.jpg'),
            ),
          ),
           SizedBox(
            child: authProvider.status==Status.authenticating?LoadingView() : const SizedBox(),)
        ],
      ),
    );
  }
}
