import 'dart:developer';

import 'package:dasboard/utils/widgetFunctions.dart';
import 'package:flutter/material.dart';

import '../../constants/app_colors.dart';
import '../../models/comment.dart';
import '../../models/post.dart';
import '../../services/api_services.dart';
import '../../utils/widgets/loading.dart';
import '../dashboard/icon_with_label.dart';
import '../dashboard/post_comment.dart';

class UserPostScreen extends StatefulWidget {
  const UserPostScreen({
    Key? key,
    required this.userId,
  }) : super(key: key);

  final String userId;

  @override
  State<UserPostScreen> createState() => _UserPostScreenState();
}

class _UserPostScreenState extends State<UserPostScreen> {
  late List<Comment> comments;
  late Post post;
  @override
  void initState() {
    super.initState();
    comments = [];
    post = Post();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => true,
      child: Scaffold(
        body: getUserPost(context),
      ),
    );
  }

  FutureBuilder getUserPost(BuildContext context) {
    var futureBuilder = FutureBuilder(
      future: apiCall(),
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        switch (snapshot.connectionState) {
          case ConnectionState.none:
          case ConnectionState.waiting:
            return const Loading();
          default:
            if (snapshot.hasError) {
              log('Error in API: ${snapshot.error}');
              return Container();
            } else {
              return buildBody(context, snapshot.data ?? []);
            }
        }
      },
    );
    return futureBuilder;
  }

  Future<List<Post>> apiCall() {
    return APIService().getUserPosts(widget.userId);
  }

  Widget buildBody(BuildContext context, List<Post> posts) {
    return Row(
      children: [
        buildPostList(context, posts),
        PostDetailsWidget(
          comments: comments,
          post: post,
        ),
      ],
    );
  }

  Widget buildPostList(
    BuildContext context,
    List<Post> posts,
  ) {
    return SizedBox(
      width: MediaQuery.of(context).size.width / 2,
      child: ListView.builder(
        scrollDirection: Axis.vertical,
        shrinkWrap: true,
        itemCount: posts.length,
        physics: const BouncingScrollPhysics(
            parent: AlwaysScrollableScrollPhysics()),
        itemBuilder: (context, item) {
          return buildPost(context, posts[item]);
          // return listTile(position);
        },
      ),
    );
  }

  Widget buildPost(BuildContext context, Post post) {
    return InkWell(
      onTap: () async {
        List<Comment> postComments =
            await APIService().getComments(post.id.toString());
        setState(() {
          comments = postComments;
          this.post = post;
        });
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            post.title!,
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
          addVerticalSpace(3),
          Text(
            post.body!,
          ),
          const Divider(),
        ],
      ),
    );
  }
}

class PostDetailsWidget extends StatelessWidget {
  const PostDetailsWidget({
    Key? key,
    required this.comments,
    required this.post,
  }) : super(key: key);

  final List<Comment> comments;
  final Post post;
  @override
  Widget build(BuildContext context) {
    return post.id == null
        ? Center(
            child: Text('Please Select a Post.',
                style: TextStyle(color: AppColors.black)))
        : SizedBox(
            width: MediaQuery.of(context).size.width / 2,
            child: Card(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  /// Header
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 18.0,
                      vertical: 10,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            IconWithLabel(
                              label: 'Copy Link',
                              icon: Icons.link,
                              onTap: () => ScaffoldMessenger.of(context)
                                  .showSnackBar(const SnackBar(
                                content: Text("Copied"),
                              )),
                            ),
                            addHorizontalSpace(10),
                            IconWithLabel(
                              label: 'Delete Post',
                              icon: Icons.delete_sweep_outlined,
                              onTap: () => Navigator.pop(context),
                            ),
                          ],
                        ),
                        const Spacer(),
                        InkWell(
                            onTap: () {
                              Navigator.pop(context);
                            },
                            child: Icon(Icons.close, color: AppColors.grey)),
                      ],
                    ),
                  ),
                  const Divider(height: 1),

                  /// Post Details
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 20.0,
                      vertical: 10,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          post.title ?? '',
                          style: const TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 24),
                        ),
                        addVerticalSpace(15),
                        Text(post.body ?? ''),
                      ],
                    ),
                  ),
                  const Divider(height: 1),

                  /// Comments
                  Expanded(
                    child: Container(
                      width: double.infinity,
                      color: AppColors.greyLite,
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: ListView.builder(
                          scrollDirection: Axis.vertical,
                          shrinkWrap: true,
                          itemCount: comments.length,
                          physics: const BouncingScrollPhysics(
                              parent: AlwaysScrollableScrollPhysics()),
                          itemBuilder: (context, item) {
                            return PostComment(
                              comment: comments[item],
                            );
                            // return listTile(position);
                          },
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
          );
  }
}
