import 'package:boilerplate/ui/account/account.dart';
import 'package:boilerplate/ui/activity/activity.dart';
import 'package:boilerplate/ui/home/home.dart';
import 'package:boilerplate/ui/notification/notification.dart';
import 'package:boilerplate/widgets/bottom_navigation_widget.dart';
import 'package:flutter/material.dart';

class TabNavigatorRoutes {
  static const String root = '/';
}

class TabNavigator extends StatelessWidget {
  TabNavigator({this.navigatorKey, this.tabItem});
  final GlobalKey<NavigatorState>? navigatorKey;
  final TabItem? tabItem;

  Map<String, WidgetBuilder> _routeBuilders(BuildContext context) {
    if (this.tabItem == TabItem.home) {
      return {TabNavigatorRoutes.root: (context) => HomeScreen()};
    } else if (this.tabItem == TabItem.activity) {
      return {TabNavigatorRoutes.root: (context) => ActivityScreen()};
    } else if (this.tabItem == TabItem.notification) {
      return {TabNavigatorRoutes.root: (context) => NotificationScreen()};
    } else if (this.tabItem == TabItem.account) {
      return {TabNavigatorRoutes.root: (context) => AccountScreen()};
    } else {
      return {TabNavigatorRoutes.root: (context) => HomeScreen()};
    }
  }

  @override
  Widget build(BuildContext context) {
    final routeBuilders = _routeBuilders(context);
    return Navigator(
      key: navigatorKey,
      initialRoute: TabNavigatorRoutes.root,
      onGenerateRoute: (routeSettings) {
        return MaterialPageRoute(
          builder: (context) => routeBuilders[routeSettings.name]!(context),
        );
      },
    );
  }
}
