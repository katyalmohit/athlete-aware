import 'package:flutter/material.dart';
import 'package:athlete_aware/providers/user_provider.dart';
import 'package:athlete_aware/utils/global_variables.dart';
import 'package:provider/provider.dart';

class ResponsiveLayout extends StatefulWidget {
  final Widget webScreenLayout;
  final Widget mobileScreenLayout;
  const ResponsiveLayout({Key ? key, required this.webScreenLayout, required this.mobileScreenLayout, }) : super(key:key);

  @override
  State<ResponsiveLayout> createState() => _ResponsiveLayoutState();
}

class _ResponsiveLayoutState extends State<ResponsiveLayout> {

  @override
  void initState() {
    super.initState();
    addData();
  }

  addData() async{
    UserProvider _userProvider = Provider.of(context, listen : false);
    await _userProvider.refreshUser();
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints){
        if(constraints.maxWidth >600){
          // web screen
          return widget.webScreenLayout;
        }
        // mobile screen
        return widget.mobileScreenLayout;
      },
   );
  }
}