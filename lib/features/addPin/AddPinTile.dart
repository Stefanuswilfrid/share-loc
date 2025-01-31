import 'dart:io';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:memz_clone/components/map/CurrentLocationMap.dart';
import 'package:memz_clone/components/shimmer/ShimmerBox.dart';
import 'package:memz_clone/styles/colors.dart';
import 'package:memz_clone/styles/fonts.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'image_picker_web.dart'
    if (dart.library.io) 'image_picker_mobile.dart'; // Conditional import

import '../../components/button/Button.dart';

class AddPinTile extends StatelessWidget {
  final Function(String? filePath) onPicChange;
  final LatLng? location;
  final bool? isLoading;
  final String? picPath;

  AddPinTile({
    required this.onPicChange,
    this.location,
    this.isLoading,
    this.picPath,
  });

  Future<void> _pickImageFromGallery() async {
    final path = await getImageFromGallery();
    print("patj ${path}");
    onPicChange(path);
  }

  Future<void> _pickImageFromCamera() async {
    final path = await getImageFromCamera();
    print("patj ${path}");

    onPicChange(path);
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: AlignmentDirectional.topEnd,
      children: [
        Container(
          alignment: Alignment.bottomRight,
          clipBehavior: Clip.hardEdge,
          width: MediaQuery.of(context).size.width,
          height: 500,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            color: MColors.grayV9,
            image: picPath != null
                ? DecorationImage(
                    fit: BoxFit.cover,
                    image: kIsWeb
                        ? NetworkImage(picPath!)
                        : FileImage(File(picPath!)) as ImageProvider,
                  )
                : null,
          ),
          child: picPath == null
              ? Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text('Add a picture', style: SubHeading.SH18),
                    const SizedBox(height: 8),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Button(
                          width: 130,
                          label: 'Camera',
                          onTap: _pickImageFromCamera,
                          type: ButtonType.primary,
                          size: ButtonSize.small,
                        ),
                        const SizedBox(width: 8),
                        Button(
                          width: 130,
                          label: 'Camera Roll',
                          onTap: _pickImageFromGallery,
                          type: ButtonType.primary,
                          size: ButtonSize.small,
                        ),
                      ],
                    ),
                    const SizedBox(height: 120),
                  ],
                )
              : Padding(
                  padding: const EdgeInsets.all(8),
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(25),
                      color: MColors.white,
                    ),
                    child: IconButton(
                      visualDensity: VisualDensity.compact,
                      icon: const Icon(
                        Icons.close_rounded,
                        color: MColors.black,
                        size: 22,
                      ),
                      onPressed: () {
                        onPicChange(null);
                      },
                    ),
                  ),
                ),
        ),
        Padding(
          padding: const EdgeInsets.all(5),
          child: location != null && isLoading != true
              ? Container(
                  height: 200,
                  width: 150,
                  clipBehavior: Clip.hardEdge,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: CurrentLocationMap(
                    location: location,
                    isLoading: isLoading,
                  ),
                )
              : ShimmerBox(
                  height: 200,
                  width: 150,
                  radius: 15,
                ),
        ),
      ],
    );
  }
}
