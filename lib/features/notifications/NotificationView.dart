import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:memz_clone/api/notifications/NotificationModel.dart';
import 'package:memz_clone/api/notifications/NotificationStore.dart';
import 'package:memz_clone/api/users/UserStore.dart';
import 'package:memz_clone/components/notification/NotificationTile.dart';
import 'package:memz_clone/components/scaffold/CommonScaffold.dart';
import 'package:memz_clone/components/scaffold/PullToRefresh.dart';

import '../../api/users/UserModel.dart';

import '../../styles/colors.dart';
import '../../styles/fonts.dart';

class NotificationView extends StatefulWidget {
  @override
  NotificationViewState createState() => NotificationViewState();
}

class NotificationViewState extends State<NotificationView> {
  UserModel? currentUser;
  List<Future<FollowRequestNotificationModel>> followRequests = [];
  final currentUserId = FirebaseAuth.instance.currentUser?.uid;

  @override
  void initState() {
    if (currentUserId != null) {
      UserStore.getUserById(id: currentUserId).then((value) {
        setState(() {
          currentUser = value;
        });
      });

      getNotifs();
    }
    super.initState();
  }

  getNotifs() {
    if (currentUserId != null) {
      NotificationStore.getFollowRequestsNotifications(userId: currentUserId!)
          .then((value) {
        setState(() {
          followRequests = value;
        });
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return CommonScaffold(
      title: 'Notifications',
      body: PullToRefresh(
        onRefresh: () {
          getNotifs();
        },
        body: followRequests.length > 0
            ? ListView(
                children: [
                  ...followRequests.map(
                    (requestFuture) =>
                        FutureBuilder<FollowRequestNotificationModel>(
                      future: requestFuture,
                      builder: (
                        BuildContext context,
                        AsyncSnapshot<FollowRequestNotificationModel>
                            notificationData,
                      ) {
                        if (notificationData.hasData) {
                          return NotificationTile(
                            notificationData: notificationData.data!,
                          );
                        }
                        return const SizedBox();
                      },
                    ),
                  )
                ],
              )
            : Column(children: [
                Text('All caught up!',
                    style: SubHeading.SH14.copyWith(color: MColors.grayV5))
              ]),
      ),
    );
  }
}
