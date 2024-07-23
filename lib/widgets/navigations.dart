import 'package:flutter/material.dart';

// function to make navigation
GlobalKey<NavigatorState> navigateKey = GlobalKey<NavigatorState>();
BuildContext context = navigateKey.currentContext!;

navigateTo(Widget className) {
  Navigator.push<void>(
    context,
    MaterialPageRoute<void>(
      builder: (BuildContext context) => className,
    ),
  );
}

popScreen() {
  Navigator.pop(context);
}

pushScreen(String screenName) {
  Navigator.popAndPushNamed(context, screenName);
}