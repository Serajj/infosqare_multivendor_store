import 'package:flutter/material.dart';
import 'package:sixam_mart_store/view/screens/design/design_controller.dart';

import 'package:sixam_mart_store/view/screens/design/design_model.dart';

class FollowScreen extends StatefulWidget {
  @override
  _FollowScreenState createState() => _FollowScreenState();
}

class _FollowScreenState extends State<FollowScreen> {
  final FollowController _controller = FollowController();
  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _controller.fetchUsers(); // Fetch the user list when the screen initializes
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const Icon(Icons.arrow_back_ios),
        title: const Text('Requests'),
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: ValueListenableBuilder<List<User>>(
        valueListenable: _controller.users,
        builder: (context, users, _) {
          return Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 20, right: 20, top: 20, bottom: 10),
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    color: Color.fromARGB(31, 187, 183, 183),
                  ),
                  child: TextField(
                            controller: _searchController,
                            decoration: InputDecoration(
                  hintText: 'Search',
                  iconColor: Color.fromARGB(255, 2, 110, 5),
                  prefixIcon: IconButton(
                    icon: Icon(Icons.search, color: Theme.of(context).primaryColor.withOpacity(0.5),),
                    onPressed: () {
                      // Perform the search here
                    },
                  ),
                  border: InputBorder.none,
                            ),
                          ),
                ),
              ),
              Expanded(
                child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: users.length,
                  itemBuilder: (context, index) {
                    final user = users[index];
                    return Container(
                      //height: 30,
                  padding: const EdgeInsets.only(left: 12, right: 12, top: 7, bottom: 5),
                      child: ListTile(
                        leading: CircleAvatar(
                          backgroundImage: NetworkImage(user.profileImage),
                        ),
                        title: Text(user.name),
                        subtitle: Text(user.username),
                        trailing: FollowButton(user: user, controller: _controller),
                      ),
                    );
                  },
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}

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
    return ElevatedButton(
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
      child: Text(
        isFollowing ? ' Follow ' : ' Confirm ',
        style: TextStyle(
          color: isFollowing ? Colors.white : Colors.white,
        ),
      ),
      style: ButtonStyle(backgroundColor: MaterialStateProperty.all(Theme.of(context).primaryColor.withOpacity(0.5),),
      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
    RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(10.0),
    )
  )),
    );
  }
}
