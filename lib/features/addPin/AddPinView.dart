import 'package:camera/camera.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:memz_clone/components/button/Button.dart';
import 'package:memz_clone/components/location/CurrentLocation.dart';
import 'package:memz_clone/components/scaffold/CommonScaffold.dart';
import 'package:memz_clone/features/addPin/AddCaptionView.dart';
import 'package:memz_clone/features/addPin/AddPinTile.dart';

import '../../components/scaffold/CommonAppBar.dart';
import '../../components/scaffold/PullToRefresh.dart';

class AddPinView extends StatefulWidget {
  @override
  AddPinViewState createState() => AddPinViewState();
}

class AddPinViewState extends State<AddPinView> {
  User? user = FirebaseAuth.instance.currentUser;

  LatLng? currentLocation;
  late bool isLoading = true;
  String? picPath;

  @override
  initState() {
    getCurrenLocation();
    super.initState();
  }

  void getCurrenLocation() {
    setState(() {
      isLoading = true;
    });
    Future.delayed(Duration.zero, () async {
      Position position = await determinePosition();
      setState(() {
        currentLocation = LatLng(position.latitude, position.longitude);
        isLoading = false;
      });
    });
  }

  final captionController = TextEditingController();

  getImageFromGallery() async {
    final ImagePicker _picker = ImagePicker();
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);

    if (image != null) {
      setState(() {
        picPath = image.path;
      });
    }
  }

  getImageFromCamera() async {
    final ImagePicker _picker = ImagePicker();
    final XFile? image = await _picker.pickImage(source: ImageSource.camera);

    if (image != null) {
      setState(() {
        picPath = image.path;
      });
    }
  }

  void onPicChange(String? path) {
    print("picChange ${path}");
    setState(() {
      picPath = path;
    });
  }

  @override
  void dispose() {
    captionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: CommonScaffold(
        appBar: CommonAppBar(
          title: 'Drop a Pin',
          rightWidget: Button(
            label: 'Next',
            size: ButtonSize.xsmall,
            type: ButtonType.secondary,
            onTap: () {
              if (user?.uid != null && currentLocation != null) {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => AddCaptionView(
                      creatorId: user!.uid,
                      location: currentLocation!,
                      imgUrls: picPath != null ? [picPath!] : null,
                    ),
                  ),
                );
              }
            },
          ),
        ),
        title: 'Drop a Pin',
        body: PullToRefresh(
            onRefresh: getCurrenLocation,
            body: ListView(children: [
              AddPinTile(
                location: currentLocation,
                isLoading: isLoading,
                onPicChange: onPicChange,
                picPath: picPath,
              ),
            ])),
      ),
    );
  }
}
