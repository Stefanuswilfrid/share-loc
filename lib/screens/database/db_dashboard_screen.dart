import 'package:flutter/material.dart';
import 'package:memz_clone/screens/database/db_add_screen.dart';
import 'package:memz_clone/widgets/app_bar_title.dart';
import 'package:memz_clone/widgets/database/crud/db_item_list.dart';

import '../../../res/custom_colors.dart';

class DbDashboardScreen extends StatefulWidget {
  const DbDashboardScreen({Key? key}) : super(key: key);

  @override
  _DbDashboardScreenState createState() => _DbDashboardScreenState();
}

class _DbDashboardScreenState extends State<DbDashboardScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Palette.firebaseNavy,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Palette.firebaseNavy,
        title: const AppBarTitle(
          sectionName: 'CRUD',
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => DbAddScreen(),
            ),
          );
        },
        backgroundColor: Palette.firebaseOrange,
        child: const Icon(
          Icons.add,
          color: Colors.white,
          size: 32,
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(
            left: 16.0,
            right: 16.0,
            bottom: 20.0,
          ),
          child: DbItemList(),
        ),
      ),
    );
  }
}
