import 'package:dasboard/constants/app_colors.dart';
import 'package:dasboard/constants/assets_path.dart';
import 'package:dasboard/models/comment.dart';
import 'package:dasboard/utils/widgetFunctions.dart';
import 'package:flutter/material.dart';

class PostComment extends StatelessWidget {
  const PostComment({
    Key? key,
    required this.comment,
  }) : super(key: key);
  final Comment comment;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CircleAvatar(
            radius: 35,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(45),
              child: Image.asset(
                AssetsPath.femaleUser,
              ),
            ),
          ),
          addHorizontalSpace(5),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Text(comment.name ?? '',
                      style: const TextStyle(
                        fontWeight: FontWeight.w700,
                        fontSize: 14,
                      )),
                  addHorizontalSpace(5),
                  Text(
                    'Jan 12, 2023 at 5:23 PM',
                    style: TextStyle(
                      color: AppColors.grey,
                      fontSize: 12,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              ),
              addVerticalSpace(3),
              Text(
                comment.body ?? '',
              ),
            ],
          ),
          const Spacer(),
          const Icon(Icons.more_vert_rounded),
        ],
      ),
    );
  }
}
