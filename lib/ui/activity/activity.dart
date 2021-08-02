import 'package:boilerplate/constants/colors.dart';
import 'package:boilerplate/constants/strings.dart';
import 'package:boilerplate/data/sharedpref/constants/preferences.dart';
import 'package:boilerplate/models/customer/activity.dart';
import 'package:boilerplate/models/motor/motor.dart';
import 'package:boilerplate/models/vehicle/vehicle.dart';
import 'package:boilerplate/models/motor/motor.dart';
import 'package:boilerplate/routes.dart';
import 'package:boilerplate/stores/language/language_store.dart';
import 'package:boilerplate/stores/motor/motor_store.dart';
import 'package:boilerplate/stores/theme/theme_store.dart';
import 'package:boilerplate/stores/user/user_store.dart';
import 'package:boilerplate/stores/vehicle/vehicle_store.dart';
import 'package:boilerplate/stores/motor/motor_store.dart';
import 'package:boilerplate/ui/vehicle/vehicle.dart';
import 'package:boilerplate/ui/motor/motor_detail.dart';
import 'package:boilerplate/ui/motor/motor_quote.dart';
import 'package:boilerplate/utils/locale/app_localization.dart';
import 'package:boilerplate/widgets/app_bar_widget.dart';
import 'package:boilerplate/widgets/body_widget.dart';
import 'package:boilerplate/widgets/card_widget.dart';
import 'package:boilerplate/widgets/error_store_widget.dart';
import 'package:boilerplate/widgets/list_tile_widget.dart';
import 'package:boilerplate/widgets/list_widget.dart';
import 'package:boilerplate/widgets/mini_progress_indicator_widget.dart';
import 'package:boilerplate/widgets/progress_indicator_widget.dart';
import 'package:boilerplate/widgets/rounded_button_widget.dart';
import 'package:boilerplate/widgets/scrollable_widget.dart';
import 'package:boilerplate/widgets/secondary_app_bar_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class ActivityScreen extends StatefulWidget {
  @override
  _ActivityScreenState createState() => _ActivityScreenState();
}

class _ActivityScreenState extends State<ActivityScreen> {
  //stores:---------------------------------------------------------------------
  UserStore? _userStore;

  final GlobalKey<RefreshIndicatorState> _refreshIndicatorKey =
      new GlobalKey<RefreshIndicatorState>();

  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    // initializing stores
    _userStore = Provider.of<UserStore>(context);

    // check to see if already called api
    if (!_userStore!.activityLoading) {
      _userStore!.getActivities();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBarWidget(text: 'activity'),
        body: RefreshIndicator(
            key: _refreshIndicatorKey,
            onRefresh: () => _userStore!.getActivities(),
            child: _buildBody()));
  }

  Widget _buildBody() {
    return BodyWidget(
        firstWidget: ErrorStoreWidget(errorStore: _userStore!.errorStore),
        secondWidget: _buildMainContent());
  }

  Widget _buildMainContent() {
    return Observer(
      builder: (context) {
        if (_userStore!.activityLoading) {
          return CustomProgressIndicatorWidget();
        } else {
          return (_userStore!.activityList != null &&
                  _userStore!.activityList!.activities!.length > 0)
              ? ListWidget(
                  count: _userStore!.activityList!.activities!.length,
                  itemBuilder: (context, position) {
                    return _buildActivityTile(
                        _userStore!.activityList!.activities![position]);
                  })
              : Padding(
                  padding: const EdgeInsets.only(top: 32, bottom: 32),
                  child: Center(
                    child: Text(
                      AppLocalizations.of(context)!
                          .translate('no_activity_found'),
                    ),
                  ),
                );
        }
      },
    );
  }

  Widget _buildActivityTile(Activity activity) {
    String topLeft = activity.data!.title!;
    String topRight =
        DateFormat(Strings.dateFormat).format(activity.createdAt!);
    String bottomLeft = activity.data!.message!;
    return ListTileWidget(
      topLeft: topLeft,
      topRight: topRight,
      bottomLeft: bottomLeft,
      bottomRight: '',
    );
  }
}
