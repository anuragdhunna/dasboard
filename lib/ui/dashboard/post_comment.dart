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
          Align(
            alignment: Alignment.topCenter,
            child: SizedBox(
                height: 50,
                width: 50,
                child: Image.asset(AssetsPath.femaleUser)),
          ),
          addHorizontalSpace(5),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Text(comment.name ?? '',
                      style: TextStyle(
                        color: AppColors.grey,
                        fontWeight: FontWeight.w500,
                        fontSize: 14,
                      )),
                  addHorizontalSpace(5),
                  Text(
                    'Jan 12, 2023 at 5:23 PM',
                    style: TextStyle(color: AppColors.grey, fontSize: 12),
                  ),
                ],
              ),
              addVerticalSpace(3),
              Text(
                comment.body ?? '',
                // maxLines: 3,
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
