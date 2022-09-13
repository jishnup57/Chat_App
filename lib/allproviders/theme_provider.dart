import 'package:flutter/material.dart';

class ThemeProvider extends ChangeNotifier {
   bool isWhite = true;
   
   darkmode(){
    isWhite = !isWhite;
    notifyListeners();
   }
}