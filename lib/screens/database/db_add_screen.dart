import 'package:flutter/material.dart';
import 'package:memz_clone/widgets/database/crud/db_add_item_form.dart';

import '../../../res/custom_colors.dart';
import '../../../widgets/app_bar_title.dart';

class DbAddScreen extends StatelessWidget {
  DbAddScreen({Key? key}) : super(key: key);

  final FocusNode _titleFocusNode = FocusNode();
  final FocusNode _descriptionFocusNode = FocusNode();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        _titleFocusNode.unfocus();
        _descriptionFocusNode.unfocus();
      },
      child: Scaffold(
        backgroundColor: Palette.firebaseNavy,
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Palette.firebaseNavy,
          title: const AppBarTitle(
            sectionName: 'CRUD',
          ),
        ),
        body: SafeArea(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.only(
                left: 16.0,
                right: 16.0,
                bottom: 20.0,
              ),
              child: DbAddItemForm(
                titleFocusNode: _titleFocusNode,
                descriptionFocusNode: _descriptionFocusNode,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
