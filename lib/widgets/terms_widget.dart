import 'package:boilerplate/constants/colors.dart';
import 'package:boilerplate/data/network/constants/endpoints.dart';
import 'package:boilerplate/utils/locale/app_localization.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class TermsWidget extends StatelessWidget {
  final String action;

  const TermsWidget({
    Key? key,
    this.action = "logging_in",
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Wrap(
      children: <Widget>[
        Text.rich(
          TextSpan(
            style: TextStyle(
              fontSize: 15,
            ),
            children: [
              TextSpan(
                text: AppLocalizations.of(context)!
                        .translate('by_' + this.action + ',_you_agree_to_our') +
                    " ",
              ),
              WidgetSpan(
                  child: InkWell(
                      onTap: () async {
                        if (await canLaunch(Endpoints.getTerms)) {
                          await launch(Endpoints.getTerms);
                        }
                      },
                      child: Text(
                          AppLocalizations.of(context)!
                              .translate('terms_and_conditions'),
                          style: TextStyle(color: AppColors.primaryColor)))),
              TextSpan(
                text:
                    " " + AppLocalizations.of(context)!.translate('and') + " ",
              ),
              WidgetSpan(
                  child: InkWell(
                      onTap: () async {
                        if (await canLaunch(Endpoints.getPrivacy)) {
                          await launch(Endpoints.getPrivacy);
                        }
                      },
                      child: Text(
                          AppLocalizations.of(context)!
                              .translate('privacy_policy'),
                          style: TextStyle(color: AppColors.primaryColor)))),
              TextSpan(
                text: ".",
              )
            ],
          ),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}
