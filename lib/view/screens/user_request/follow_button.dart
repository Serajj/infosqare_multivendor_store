import 'package:flutter/material.dart';

import '../../../controller/customer_list_controller.dart';
import '../../../data/model/response/follower_model.dart';

class FollowButtonRequest extends StatefulWidget {
  final Follower follower;
  final CustomerListController controller;
  final int index;

  FollowButtonRequest(
      {required this.follower, required this.controller, required this.index});

  @override
  _FollowButtonRequestState createState() => _FollowButtonRequestState();
}

class _FollowButtonRequestState extends State<FollowButtonRequest> {
  int isFollowing = 0;

  @override
  void initState() {
    super.initState();
    setIsFollwed(); // Check if the user is already followed
  }

  setIsFollwed() {
    isFollowing = widget.follower.followedBy == 'store' ? 0 : 1;
  }

  @override
  Widget build(BuildContext context) {
    return isFollowing == 0
        ? InkWell(
            onTap: () async {
              int? userId = widget.follower.userId;
              if (isFollowing == 0) {
                await widget.controller
                    .unfollowUserForFollowerModel(userId, widget.index, true);
              } else {
                // await widget.controller.acceptReq(storeId, widget.index);
              }
            },
            child: Container(
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: Colors.red, // Border color
                    width: 2.0, // Border width
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Icon(
                    Icons.close,
                    color: Colors.red,
                  ),
                )),
          )
        : Container(
            width: 100,
            child: Row(
              children: [
                Container(
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: Colors.red, // Border color
                        width: 2.0, // Border width
                      ),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Icon(
                        Icons.close,
                        color: Colors.red,
                      ),
                    )),
                SizedBox(
                  width: 10,
                ),
                InkWell(
                  onTap: () async {
                    int? userId = widget.follower.userId;
                    await widget.controller
                        .acceptReq(userId, widget.index, true);
                  },
                  child: Container(
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: Theme.of(context).primaryColor, // Border color
                          width: 2.0, // Border width
                        ),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Icon(
                          Icons.check,
                          color: Theme.of(context).primaryColor,
                        ),
                      )),
                )
              ],
            ),
          );
  }
}

class FollowButtonAccept extends StatefulWidget {
  final Follower follower;
  final CustomerListController controller;
  final int index;

  FollowButtonAccept(
      {required this.follower, required this.controller, required this.index});

  @override
  _FollowButtonAcceptState createState() => _FollowButtonAcceptState();
}

class _FollowButtonAcceptState extends State<FollowButtonAccept> {
  int isFollowing = 0;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () async {
        int? storeId = widget.follower.userId;
        await widget.controller
            .unfollowUserForFollowerModel(storeId, widget.index, false);
      },
      style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all(
            Colors.red,
          ),
          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
              RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
          ))),
      child: Text(
        ' Remove ',
        style: TextStyle(
          color: Colors.white,
        ),
      ),
    );
  }
}
