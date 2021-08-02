import 'package:boilerplate/constants/colors.dart';
import 'package:boilerplate/models/vehicle/vehicle.dart';
import 'package:boilerplate/stores/document/document_store.dart';
import 'package:boilerplate/stores/vehicle/vehicle_store.dart';

import 'package:boilerplate/utils/locale/app_localization.dart';
import 'package:boilerplate/widgets/app_bar_widget.dart';
import 'package:boilerplate/widgets/body_widget.dart';
import 'package:boilerplate/widgets/error_store_widget.dart';
import 'package:boilerplate/widgets/progress_indicator_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

class WarrantyScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _WarrantyScreenState();
}

class _WarrantyScreenState extends State<WarrantyScreen> {
  DocumentStore? _documentStore;
  VehicleStore? _vehicleStore;
  final GlobalKey<RefreshIndicatorState> _refreshIndicatorKey =
      new GlobalKey<RefreshIndicatorState>();
  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _documentStore = Provider.of<DocumentStore>(context);
    _vehicleStore = Provider.of<VehicleStore>(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarWidget(text: 'warranty_booklet'),
      body: RefreshIndicator(
          key: _refreshIndicatorKey,
          onRefresh: () =>
              _documentStore!.getVehicleWarranty(_vehicleStore!.vehicle!.id!),
          child: _buildBody()),
    );
  }

  Widget _buildBody() {
    return BodyWidget(
        firstWidget: ErrorStoreWidget(errorStore: _documentStore!.errorStore),
        secondWidget: _buildMainContent());
  }

  Widget _buildMainContent() {
    return Observer(
      builder: (context) {
        return _documentStore!.loading
            ? CustomProgressIndicatorWidget()
            : _buildListView();
      },
    );
  }

  Widget _buildListView() {
    return _documentStore!.documentList!.documents != null &&
            _documentStore!.documentList!.documents!.length > 0
        ? ListView.separated(
            itemCount: _documentStore!.documentList!.documents!.length,
            separatorBuilder: (context, position) {
              return Divider(height: 1, thickness: 2);
            },
            itemBuilder: (context, position) {
              return _buildListItem(position);
            },
          )
        : Center(
            child: Text(
              AppLocalizations.of(context)!.translate('no_warranty_found'),
            ),
          );
  }

  Widget _buildListItem(int position) {
    return InkWell(
      onTap: () async {
        String url = _documentStore!.documentList!.documents![position].view!;
        if (await canLaunch(url)) {
          await launch(url);
        } else {
          throw 'Could not launch $url';
        }
      },
      child: ListTile(
        contentPadding:
            EdgeInsets.only(left: 15, right: 15, top: 15, bottom: 15),
        dense: true,
        title: Row(
          children: <Widget>[
            SvgPicture.asset('assets/icons/ic_pdf.svg'),
            SizedBox(width: 10),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  AppLocalizations.of(context)!.translate("warranty_no") +
                      " " +
                      _documentStore!
                          .documentList!.documents![position].policyNo!,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  softWrap: false,
                  style: Theme.of(context).textTheme.title!.copyWith(
                      fontSize: 14,
                      color: AppColors.darkBlueColor,
                      fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 5),
                Text(
                  _documentStore!
                          .documentList!.documents![position].startDate! +
                      " - " +
                      _documentStore!
                          .documentList!.documents![position].endDate!,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  softWrap: false,
                  style: Theme.of(context)
                      .textTheme
                      .title!
                      .copyWith(fontSize: 14, color: AppColors.greyColor),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
