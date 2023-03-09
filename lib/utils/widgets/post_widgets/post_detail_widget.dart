import 'package:dasboard/utils/widgetFunctions.dart';
import 'package:dasboard/utils/widgets/post_widgets/post_comment.dart';
import 'package:flutter/material.dart';

import '../../../constants/app_colors.dart';
import '../../../models/comment.dart';
import '../../../models/post.dart';
import '../../../ui/dashboard/icon_with_label.dart';

class PostDetailWidget extends StatelessWidget {
  const PostDetailWidget({
    Key? key,
    required this.post,
    required this.comments,
  }) : super(key: key);

  final Post post;
  final List<Comment> comments;

  @override
  Widget build(BuildContext context) {
    return Card(
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
            child: SizedBox(
              width: double.infinity,
              // color: AppColors.greyLite,
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
    );
  }
}
