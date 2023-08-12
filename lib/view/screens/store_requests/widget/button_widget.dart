/*import 'package:flutter/material.dart';
//import 'package:get/get.dart';
import 'package:sixam_mart_store/controller/request_controller.dart';
import 'package:sixam_mart_store/data/model/body/request_model.dart';
//import 'package:sixam_mart/view/base/custom_button.dart';

class FollowButton extends StatefulWidget {
  final User user;
  final FollowController controller;

  FollowButton({required this.user, required this.controller});

  @override
  _FollowButtonState createState() => _FollowButtonState();
}

class _FollowButtonState extends State<FollowButton> {
  bool isFollowing = false;

  @override
  void initState() {
    super.initState();
    isFollowing = widget.controller.isFollowingUser(widget.user); // Check if the user is already followed
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 30,
      child: ElevatedButton(
        onPressed: () {
          setState(() {
            isFollowing = !isFollowing;
            if (isFollowing) {
              widget.controller.followUser(widget.user);
            } else {
              widget.controller.unfollowUser(widget.user);
            }
          });
        },
        style: ElevatedButton.styleFrom(
                        primary: Theme.of(context).primaryColor,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(6),
                        ),
        ),
        child: Text(
          isFollowing ? 'Follow' : 'Confirm',
          style: TextStyle(
            color: isFollowing ? Colors.white : Colors.white,
          ),
        ),
      ),
    );
    /*return CustomButton(
                            buttonText: isFollowing ? 'Follow'.tr : 'Confirm'.tr,
                            onPressed: () {
        setState(() {
          isFollowing = !isFollowing;
          if (isFollowing) {
            widget.controller.followUser(widget.user);
          } else {
            widget.controller.unfollowUser(widget.user);
          }
        });
      },
    );*/
  }
}*/