// Copyright 2018 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

// ignore_for_file: public_member_api_docs

import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:android_intent/android_intent.dart';
import 'package:boilerplate/constants/strings.dart';
import 'package:boilerplate/data/network/constants/endpoints.dart';
import 'package:boilerplate/data/sharedpref/constants/preferences.dart';
import 'package:boilerplate/models/vehicle/vehicle.dart';
import 'package:boilerplate/routes.dart';
import 'package:boilerplate/stores/register/register_store.dart';
import 'package:boilerplate/stores/user/user_form_store.dart';
import 'package:boilerplate/stores/user/user_store.dart';
import 'package:flutter/material.dart';
import 'package:mobx/mobx.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:webview_flutter/webview_flutter.dart';

const String kNavigationExamplePage = '''
<!DOCTYPE html><html>
<head><title>Navigation Delegate Example</title></head>
<body>
<p>
The navigation delegate is set to block navigation to the youtube website.
</p>
<ul>
<ul><a href="https://www.youtube.com/">https://www.youtube.com/</a></ul>
<ul><a href="https://www.google.com/">https://www.google.com/</a></ul>
</ul>
</body>
</html>
''';

class Browser extends StatefulWidget {
  final UserFormStore? userFormStore;
  const Browser({this.userFormStore = null});
  @override
  _BrowserState createState() => _BrowserState();
}

class _BrowserState extends State<Browser> {
  final Completer<WebViewController> _controller =
      Completer<WebViewController>();

  UserStore? _userStore;
  RegisterStore? _registerStore;

  @override
  void initState() {
    super.initState();
    if (Platform.isAndroid) WebView.platform = SurfaceAndroidWebView();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _userStore = Provider.of<UserStore>(context);
    _registerStore = Provider.of<RegisterStore>(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          iconTheme: IconThemeData(
            color: Colors.white, //change your color here
          ),
        ),
        // We're using a Builder here so we have a context that is below the Scaffold
        // to allow calling Scaffold.of(context) so we can show a snackbar.
        body: Builder(builder: (BuildContext context) {
          return WebView(
            initialUrl: _registerStore!.myinfo || _userStore!.myinfo
                ? Endpoints.myinfo
                : Endpoints.singpass,
            javascriptMode: JavascriptMode.unrestricted,
            onWebViewCreated: (WebViewController webViewController) {
              _controller.complete(webViewController);
            },
            javascriptChannels: <JavascriptChannel>{
              _toasterJavascriptChannel(context),
            },
            navigationDelegate: (NavigationRequest request) async {
              if (request.url.startsWith('intent')) {
                AndroidIntent intent = AndroidIntent(
                    data: Uri.encodeFull(
                        request.url.replaceAll("intent", "https")),
                    //data: 'https://play.google.com/store/apps/details?'
                    //  'id=sg.ndi.sp',
                    action: "action_view");
                intent.launch();
                /*
              if (await canLaunch(request.url)) {
                await launch(request.url);
              } else {
                throw 'Could not launch $request.url';
              }*/
                return NavigationDecision.prevent;
              } else if (request.url.startsWith(Endpoints.singpassSuccess)) {
                if (request.url.contains("?token=")) {
                  _userStore!.login(request.url.split("?token=")[1]);
                  Navigator.of(context).pushNamedAndRemoveUntil(
                      Routes.home, (Route<dynamic> route) => false);
                } else if (request.url.contains("?nric=")) {
                  // Redirect to register page
                  _registerStore!.redirect = true;
                  _registerStore!.nric = request.url.split("?nric=")[1];

                  Navigator.of(context).pop();
                } else if (_userStore!.myinfo) {
                  _userStore!.myinfo = false;
                  /*
                  * https://dev.carfren.com.sg/singpass/success?uinfin=S3100052A&
                  * name=TAN%20HENG%20HUAT&gender=F&dob=06/06/1998&nationality=SG&occupation=&
                  * phone=97399245&email=myinfotesting@gmail.com&
                  * address=102%20BEDOK%20NORTH%20AVENUE%204%20#09-09%20PEARL%20GARDEN%20&
                  * driving_class=2A,3A,3A&driving_validity=06/06/2018&
                  * vehicle_nos=SDF1235A&vehicle_types=Station%20Wagon/Jeep/Land%20Rover&
                  * vehicle_makes=KIA&vehicle_models=KIA%20SEDONA&
                  * vehicle_chassises=ZC11S1735800&vehicle_engines=M13A1837453&
                  * vehicle_manufactures=2013&vehicle_registrations=2013-05-19*/
                  var uri = Uri.dataFromString(
                      request.url); //converts string to a uri
                  Map<String, String> params = uri.queryParameters;
                  widget.userFormStore!.customer!.name =
                      params['name']!.replaceAll("%20", " ");
                  widget.userFormStore!.customer!.gender = params['gender'];
                  widget.userFormStore!.customer!.formatDob = params['dob']!;
                  widget.userFormStore!.customer!.formatNationality =
                      Strings.nationalityCodes[params['nationality']]!;
                  widget.userFormStore!.customer!.formatResidential =
                      params['nationality']! == 'SG' ? 'Singapore' : 'PR';
                  widget.userFormStore!.customer!.formatOccupation = 'Others';
                  for (var i = 0; i < Strings.occupationOptions.length; i++) {
                    if (Strings.occupationOptions[i] == params['occupation']) {
                      widget.userFormStore!.customer!.formatOccupation =
                          params['occupation']!;
                      break;
                    }
                  }

                  widget.userFormStore!.customer!.phone = params['phone']!;
                  widget.userFormStore!.customer!.email = params['email']!;

                  widget.userFormStore!.customer!.address =
                      params['address']!.replaceAll("%20", " ");
                  ;
                  widget.userFormStore!.customer!.drivingLicenseClass =
                      params['driving_class']!;
                  widget.userFormStore!.customer!.formatDrivingLicenseValidity =
                      params['driving_validity']!;
                  widget.userFormStore!.customer =
                      widget.userFormStore!.customer;

                  List<String> vehicleNos = params['vehicle_nos']!.split(",");
                  List<String> vehicleTypes =
                      params['vehicle_types']!.split(",");
                  List<String> vehicleMakes =
                      params['vehicle_makes']!.split(",");
                  List<String> vehicleModels =
                      params['vehicle_models']!.split(",");
                  List<String> vehicleChassises =
                      params['vehicle_chassises']!.split(",");
                  List<String> vehicleEngines =
                      params['vehicle_engines']!.split(",");
                  List<String> vehicleManufactures =
                      params['vehicle_manufactures']!.split(",");
                  List<String> vehicleRegistrations =
                      params['vehicle_registrations']!.split(",");
                  List<bool> exists = List<bool>.generate(
                      vehicleChassises.length, (int index) => false);

                  for (var i = 0;
                      i < widget.userFormStore!.vehicles!.length;
                      i++) {
                    for (var z = 0; z < vehicleChassises.length; z++) {
                      if (widget.userFormStore!.vehicles![i].chassisNo ==
                          vehicleChassises[z]) {
                        exists[z] = true;
                        widget.userFormStore!.vehicles![i].registrationNo =
                            vehicleNos[z];
                        widget.userFormStore!.vehicles![i].type =
                            vehicleTypes[z];
                        widget.userFormStore!.vehicles![i].make =
                            vehicleMakes[z].replaceAll("%20", " ");
                        widget.userFormStore!.vehicles![i].model =
                            vehicleModels[z].replaceAll("%20", " ");
                        widget.userFormStore!.vehicles![i].engineNo =
                            vehicleEngines[z];
                        widget.userFormStore!.vehicles![i].manufactureYear =
                            vehicleManufactures[z];
                        List<String> reg = vehicleRegistrations[z].split("-");
                        widget.userFormStore!.vehicles![i]
                                .formatRegistrationDate =
                            reg[2] + "/" + reg[1] + "/" + reg[0];
                      }
                    }
                  }

                  // ObservableList<Vehicle> vehicles =
                  //    widget.userFormStore!.vehicles!;
                  for (var i = 0; i < exists.length; i++) {
                    if (!exists[i]) {
                      List<String> reg = vehicleRegistrations[i].split("-");
                      Vehicle vehicle = Vehicle(
                        registrationNo: vehicleNos[i],
                        type: vehicleTypes[i],
                        make: vehicleMakes[i].replaceAll("%20", " "),
                        model: vehicleModels[i].replaceAll("%20", " "),
                        chassisNo: vehicleChassises[i],
                        engineNo: vehicleEngines[i],
                        manufactureYear: vehicleManufactures[i],
                        formatRegistrationDate:
                            reg[2] + "/" + reg[1] + "/" + reg[0],
                      );
                      widget.userFormStore!.vehicles!.add(vehicle);
                      widget.userFormStore!.hideVehicleList!.add(true);
                    }
                  }

                  // widget.userFormStore!.vehicles = vehicles;
                  Navigator.of(context).pop();
                } else {
                  _registerStore!.myinfo = false;
                  var uri = Uri.dataFromString(
                      request.url); //converts string to a uri
                  Map<String, String> params = uri.queryParameters;
                  _registerStore!.nric = params['uinfin']!;
                  _registerStore!.name = params['name']!.replaceAll("%20", " ");
                  _registerStore!.dob = params['dob']!;
                  _registerStore!.phone = params['phone']!;
                  _registerStore!.email = params['email']!;
                  Navigator.of(context).pop();
                }
                return NavigationDecision.prevent;
              }
              print('allowing navigation to $request');
              return NavigationDecision.navigate;
            },
            onPageStarted: (String url) {
              print('Page started loading: $url');
            },
            onPageFinished: (String url) {
              print('Page finished loading: $url');
            },
            gestureNavigationEnabled: true,
          );
        }));
  }

  JavascriptChannel _toasterJavascriptChannel(BuildContext context) {
    return JavascriptChannel(
        name: 'Toaster',
        onMessageReceived: (JavascriptMessage message) {
          // ignore: deprecated_member_use
          Scaffold.of(context).showSnackBar(
            SnackBar(content: Text(message.message)),
          );
        });
  }
}

enum MenuOptions {
  showUserAgent,
  listCookies,
  clearCookies,
  addToCache,
  listCache,
  clearCache,
  navigationDelegate,
}

class SampleMenu extends StatelessWidget {
  SampleMenu(this.controller);

  final Future<WebViewController> controller;
  final CookieManager cookieManager = CookieManager();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<WebViewController>(
      future: controller,
      builder:
          (BuildContext context, AsyncSnapshot<WebViewController> controller) {
        return PopupMenuButton<MenuOptions>(
          onSelected: (MenuOptions value) {
            switch (value) {
              case MenuOptions.showUserAgent:
                _onShowUserAgent(controller.data!, context);
                break;
              case MenuOptions.listCookies:
                _onListCookies(controller.data!, context);
                break;
              case MenuOptions.clearCookies:
                _onClearCookies(context);
                break;
              case MenuOptions.addToCache:
                _onAddToCache(controller.data!, context);
                break;
              case MenuOptions.listCache:
                _onListCache(controller.data!, context);
                break;
              case MenuOptions.clearCache:
                _onClearCache(controller.data!, context);
                break;
              case MenuOptions.navigationDelegate:
                _onNavigationDelegateExample(controller.data!, context);
                break;
            }
          },
          itemBuilder: (BuildContext context) => <PopupMenuItem<MenuOptions>>[
            PopupMenuItem<MenuOptions>(
              value: MenuOptions.showUserAgent,
              child: const Text('Show user agent'),
              enabled: controller.hasData,
            ),
            const PopupMenuItem<MenuOptions>(
              value: MenuOptions.listCookies,
              child: Text('List cookies'),
            ),
            const PopupMenuItem<MenuOptions>(
              value: MenuOptions.clearCookies,
              child: Text('Clear cookies'),
            ),
            const PopupMenuItem<MenuOptions>(
              value: MenuOptions.addToCache,
              child: Text('Add to cache'),
            ),
            const PopupMenuItem<MenuOptions>(
              value: MenuOptions.listCache,
              child: Text('List cache'),
            ),
            const PopupMenuItem<MenuOptions>(
              value: MenuOptions.clearCache,
              child: Text('Clear cache'),
            ),
            const PopupMenuItem<MenuOptions>(
              value: MenuOptions.navigationDelegate,
              child: Text('Navigation Delegate example'),
            ),
          ],
        );
      },
    );
  }

  void _onShowUserAgent(
      WebViewController controller, BuildContext context) async {
    // Send a message with the user agent string to the Toaster JavaScript channel we registered
    // with the WebView.
    await controller.evaluateJavascript(
        'Toaster.postMessage("User Agent: " + navigator.userAgent);');
  }

  void _onListCookies(
      WebViewController controller, BuildContext context) async {
    final String cookies =
        await controller.evaluateJavascript('document.cookie');
    // ignore: deprecated_member_use
    Scaffold.of(context).showSnackBar(SnackBar(
      content: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          const Text('Cookies:'),
          _getCookieList(cookies),
        ],
      ),
    ));
  }

  void _onAddToCache(WebViewController controller, BuildContext context) async {
    await controller.evaluateJavascript(
        'caches.open("test_caches_entry"); localStorage["test_localStorage"] = "dummy_entry";');
    // ignore: deprecated_member_use
    Scaffold.of(context).showSnackBar(const SnackBar(
      content: Text('Added a test entry to cache.'),
    ));
  }

  void _onListCache(WebViewController controller, BuildContext context) async {
    await controller.evaluateJavascript('caches.keys()'
        '.then((cacheKeys) => JSON.stringify({"cacheKeys" : cacheKeys, "localStorage" : localStorage}))'
        '.then((caches) => Toaster.postMessage(caches))');
  }

  void _onClearCache(WebViewController controller, BuildContext context) async {
    await controller.clearCache();
    // ignore: deprecated_member_use
    Scaffold.of(context).showSnackBar(const SnackBar(
      content: Text("Cache cleared."),
    ));
  }

  void _onClearCookies(BuildContext context) async {
    final bool hadCookies = await cookieManager.clearCookies();
    String message = 'There were cookies. Now, they are gone!';
    if (!hadCookies) {
      message = 'There are no cookies.';
    }
    // ignore: deprecated_member_use
    Scaffold.of(context).showSnackBar(SnackBar(
      content: Text(message),
    ));
  }

  void _onNavigationDelegateExample(
      WebViewController controller, BuildContext context) async {
    final String contentBase64 =
        base64Encode(const Utf8Encoder().convert(kNavigationExamplePage));
    await controller.loadUrl('data:text/html;base64,$contentBase64');
  }

  Widget _getCookieList(String cookies) {
    if (cookies == null || cookies == '""') {
      return Container();
    }
    final List<String> cookieList = cookies.split(';');
    final Iterable<Text> cookieWidgets =
        cookieList.map((String cookie) => Text(cookie));
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      mainAxisSize: MainAxisSize.min,
      children: cookieWidgets.toList(),
    );
  }
}
