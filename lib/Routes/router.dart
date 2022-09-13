
import 'package:flutter/material.dart';

class Routes {
  static final navigaatorKey = GlobalKey<NavigatorState>();

  static push({required var screen}){
    navigaatorKey.currentState?.push(MaterialPageRoute(builder: (_)=>screen));
  }
    static pushReplacemen({required var screen}){
    navigaatorKey.currentState?.pushReplacement(MaterialPageRoute(builder: (_)=>screen));
  }

   static pushAndRemoveUntil({required var screen}){
    navigaatorKey.currentState?.pushAndRemoveUntil(MaterialPageRoute(builder:(_)=>screen), (route) => false);
  }


}