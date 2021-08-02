import 'package:boilerplate/constants/colors.dart';
import 'package:boilerplate/utils/locale/app_localization.dart';
import 'package:flutter/material.dart';

enum TabItem { home, activity, notification, account }

class BottomNavigation extends StatelessWidget {
  BottomNavigation({this.currentTab, this.onSelectTab});
  final TabItem? currentTab;
  final ValueChanged<TabItem>? onSelectTab;

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      backgroundColor: AppColors.primaryColor,
      selectedItemColor: AppColors.selectedColor,
      unselectedItemColor: Colors.white.withOpacity(0.3),
      type: BottomNavigationBarType.fixed,
      items: [
        _buildItem(tabItem: TabItem.home, context: context),
        _buildItem(tabItem: TabItem.activity, context: context),
        _buildItem(tabItem: TabItem.notification, context: context),
        _buildItem(tabItem: TabItem.account, context: context)
      ],
      onTap: (index) => onSelectTab!(
        TabItem.values[index],
      ),
    );
  }

  BottomNavigationBarItem _buildItem(
      {TabItem? tabItem, BuildContext? context}) {
    IconData icon;
    String text;
    if (tabItem == TabItem.activity) {
      icon = Icons.assignment;
      text = AppLocalizations.of(context!)!.translate('activity');
    } else if (tabItem == TabItem.notification) {
      icon = Icons.notifications;
      text = AppLocalizations.of(context!)!.translate('notification');
    } else if (tabItem == TabItem.account) {
      icon = Icons.person;
      text = AppLocalizations.of(context!)!.translate('account');
    } else {
      icon = Icons.home;
      text = AppLocalizations.of(context!)!.translate('home');
    }
    return BottomNavigationBarItem(
        title: Text(text,
            style: TextStyle(color: _colorTabMatching(item: tabItem!))),
        icon: Icon(
          icon,
          color: _colorTabMatching(item: tabItem!),
        ));
  }

  Color _colorTabMatching({TabItem? item}) {
    return currentTab == item
        ? AppColors.selectedColor
        : Colors.white.withOpacity(0.3);
  }
}
