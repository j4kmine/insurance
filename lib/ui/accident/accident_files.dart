import 'package:boilerplate/constants/colors.dart';
import 'package:boilerplate/constants/strings.dart';
import 'package:boilerplate/data/network/constants/endpoints.dart';
import 'package:boilerplate/stores/accident/accident_form_store.dart';
import 'package:boilerplate/stores/accident/accident_store.dart';
import 'package:boilerplate/stores/motor/motor_form_store.dart';
import 'package:boilerplate/stores/motor/motor_store.dart';
import 'package:boilerplate/ui/motor/motor_status.dart';
import 'package:boilerplate/utils/device/device_utils.dart';
import 'package:boilerplate/utils/locale/app_localization.dart';
import 'package:boilerplate/widgets/app_bar_widget.dart';
import 'package:boilerplate/widgets/body_widget.dart';
import 'package:boilerplate/widgets/error_store_widget.dart';
import 'package:boilerplate/widgets/file_page_widget.dart';
import 'package:boilerplate/widgets/file_widget.dart';
import 'package:boilerplate/widgets/primary_button_widget.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

class AccidentFilesScreen extends StatefulWidget {
  @override
  _AccidentFilesScreenState createState() => _AccidentFilesScreenState();
}

class _AccidentFilesScreenState extends State<AccidentFilesScreen> {
  //stores:---------------------------------------------------------------------
  AccidentStore? _accidentStore;
  final picker = ImagePicker();

  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _accidentStore = Provider.of<AccidentStore>(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBarWidget(text: _accidentStore!.photoTitle),
        body: _buildBody());
  }

  Widget _buildBody() {
    return BodyWidget(
        firstWidget: Container(),
        secondWidget: _buildMainContent(),
        thirdWidget: _buildButtons());
  }

  Widget _buildMainContent() {
    return Observer(
      builder: (context) {
        return _buildPhotoDetails();
      },
    );
  }

  Widget _buildPhotoDetails() {
    List<String> fp = getFiles();
    return FilePageWidget(
        files: fp,
        title:
            AppLocalizations.of(context)!.translate('upload_assessment_report'),
        onRemoved: (index) async {
          fp.removeAt(index);
          reset(fp);
        });
  }

  void reset(List<String> fp) {
    if (_accidentStore!.fileIndex == 0) {
      _accidentStore!.accidentSceneFiles = fp;
    } else if (_accidentStore!.fileIndex == 1) {
      _accidentStore!.vehicleCarPlateFiles = fp;
    } else if (_accidentStore!.fileIndex == 2) {
      _accidentStore!.closeRangeDamageFiles = fp;
    } else if (_accidentStore!.fileIndex == 3) {
      _accidentStore!.longRangeDamageFiles = fp;
    } else if (_accidentStore!.fileIndex == 4) {
      _accidentStore!.otherDrivingLicenseFiles = fp;
    } else if (_accidentStore!.fileIndex == 5) {
      _accidentStore!.otherVehicleCarPlateFiles = fp;
    } else if (_accidentStore!.fileIndex == 6) {
      _accidentStore!.otherCloseRangeDamageFiles = fp;
    } else if (_accidentStore!.fileIndex == 7) {
      _accidentStore!.otherLongRangeDamageFiles = fp;
    }
  }

  List<String> getFiles() {
    List<String> fp = _accidentStore!.accidentSceneFiles;
    if (_accidentStore!.fileIndex == 1) {
      fp = _accidentStore!.vehicleCarPlateFiles;
    } else if (_accidentStore!.fileIndex == 2) {
      fp = _accidentStore!.closeRangeDamageFiles;
    } else if (_accidentStore!.fileIndex == 3) {
      fp = _accidentStore!.longRangeDamageFiles;
    } else if (_accidentStore!.fileIndex == 4) {
      fp = _accidentStore!.otherDrivingLicenseFiles;
    } else if (_accidentStore!.fileIndex == 5) {
      fp = _accidentStore!.otherVehicleCarPlateFiles;
    } else if (_accidentStore!.fileIndex == 6) {
      fp = _accidentStore!.otherCloseRangeDamageFiles;
    } else if (_accidentStore!.fileIndex == 7) {
      fp = _accidentStore!.otherLongRangeDamageFiles;
    }
    return fp;
  }

  Widget _buildButtons() {
    List<String> fp = getFiles();
    return Observer(builder: (context) {
      return Positioned(
          top: MediaQuery.of(context).size.height - 200,
          left: 20,
          width: MediaQuery.of(context).size.width - 40,
          height: 45,
          child: Row(children: [
            Expanded(
              child: PrimaryButtonWidget(
                  img: Icon(Icons.attach_file,
                      color: AppColors.secondaryColor, size: 18),
                  onPressed: () async {
                    FilePickerResult? result = await FilePicker.platform
                        .pickFiles(
                            allowMultiple: true,
                            type: FileType.custom,
                            allowedExtensions: ['jpg', 'jpeg', 'png', 'pdf']);
                    for (var i = 0; i < result!.paths.length; i++) {
                      fp.add(result.paths[i]!);
                    }
                    reset(fp);
                  },
                  textColor: AppColors.secondaryColor,
                  borderColor: AppColors.secondaryColor,
                  buttonText:
                      AppLocalizations.of(context)!.translate("upload_files"),
                  buttonColor: Colors.transparent),
            ),
            SizedBox(width: 10),
            Expanded(
                child: PrimaryButtonWidget(
                    img: Icon(Icons.camera_alt_outlined,
                        color: Colors.white, size: 18),
                    onPressed: () async {
                      final pickedFile =
                          await picker.pickImage(source: ImageSource.camera);
                      fp.add(pickedFile!.path);
                      reset(fp);
                    },
                    buttonText: AppLocalizations.of(context)!.translate("take"
                        "_photos"),
                    buttonColor: AppColors.secondaryColor))
          ]));
    });
  }
}
