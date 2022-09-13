import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:ichat_app/Routes/router.dart';
import 'package:ichat_app/allConstants/color_constants.dart';
import 'package:ichat_app/allModels/popup_choice.dart';
import 'package:ichat_app/allScreens/login_page.dart';
import 'package:ichat_app/allScreens/settings_page.dart';
import 'package:ichat_app/allproviders/auth_provider.dart';
import 'package:ichat_app/allproviders/theme_provider.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
 
  final GoogleSignIn googleSignIn = GoogleSignIn();
  final ScrollController listScrollController = ScrollController();

   int _limit = 20;
   final int _limitIncrement = 20;
   final String _textSearch = "";
  bool isLoading = false;

  late String currentUseraId;
  late AuthProvider authProvider;
  //late HomeProvider homeProvider;

  void scrollListener(){
    if (listScrollController.offset >= listScrollController.position.maxScrollExtent && !listScrollController.position.outOfRange) {
      setState(() {
        
         _limit += _limitIncrement;
      });
    }
  }

  @override
  void initState() {
    super.initState();
     authProvider = context.read<AuthProvider>();
    // homeProvider = context.read<HomeProvider>();

    if(authProvider.getUserFirebaseId()?.isNotEmpty==true){
      currentUseraId = authProvider.getUserFirebaseId()!;
    } else{
      Routes.pushAndRemoveUntil(screen: const LoginPage());
    }
    listScrollController.addListener(scrollListener);
     }

 final List<PopupChoice> choices=[
  PopupChoice(title: 'Settings', icon: Icons.settings),
  PopupChoice(title: 'Sign out', icon: Icons.exit_to_app),
 ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:
          context.watch<ThemeProvider>().isWhite ? Colors.white : Colors.black,
      appBar: AppBar(
        backgroundColor: context.watch<ThemeProvider>().isWhite
            ? Colors.white
            : Colors.black,
        leading: IconButton(
          icon: Switch(
            value: context.read<ThemeProvider>().isWhite,
            onChanged: (value) {
              context.read<ThemeProvider>().darkmode();
            },
            activeTrackColor: Colors.grey,
            activeColor: Colors.white,
            inactiveTrackColor: Colors.grey,
            inactiveThumbColor: Colors.black45,
          ),
          onPressed: () => '',
        ),
        actions: [
          buildPopUpMenu(),
        ],
      ),
    );
  }

  Future<void> handleSignOut()async{
    authProvider.handleSignOut();
    Routes.pushReplacemen(screen: const LoginPage());
    
  }

  void onItemMenuPress(PopupChoice choice){
    if (choice.title=='Sign out') {
      handleSignOut();
    }else{
      Routes.push(screen: const SettingsPage());
    }
  }

  buildPopUpMenu() {
    return PopupMenuButton<PopupChoice>(
      icon: const Icon(Icons.more_vert,color: Colors.grey,),
      onSelected: onItemMenuPress,
      itemBuilder: (BuildContext context) {
        return choices.map((PopupChoice choice){
          return PopupMenuItem<PopupChoice>(
            value: choice,
            child: Row(
            children: [
              Icon(
                choice.icon,
                color: ColorConstants.primaryColor,
              ),
              Container(
                width: 10,
              ),
              Text(choice.title,style: const TextStyle(color: ColorConstants.primaryColor))
            ],
          ));
        }).toList();
      },
    );
  }
}
