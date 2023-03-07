import 'package:dasboard/constants/app_colors.dart';
import 'package:dasboard/models/comment.dart';
import 'package:dasboard/models/post.dart';
import 'package:dasboard/services/api_services.dart';
import 'package:dasboard/ui/dashboard/icon_with_label.dart';
import 'package:dasboard/ui/dashboard/post_comment.dart';
import 'package:dasboard/ui/user_post/user_post_screen.dart';
import 'package:dasboard/utils/widgetFunctions.dart';
import 'package:flutter/material.dart';

class PostTable extends StatelessWidget {
  const PostTable({
    Key? key,
    required this.data,
  }) : super(key: key);

  final DataTableSource data;

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => true,
      child: SizedBox(
        width: MediaQuery.of(context).size.width,
        child: PaginatedDataTable(
          key: key,
          showCheckboxColumn: false,
          // headingRowColor: MaterialStateColor.resolveWith(
          //     (states) => AppColors.greyLite),
          header: const Text('Posts'),
          columnSpacing: 50,
          columns: const [
            DataColumn(
              label: Text(
                'Title',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
            DataColumn(
              label: Text('Description',
                  style: TextStyle(fontWeight: FontWeight.bold)),
            ),
            DataColumn(
              label: Text('User ID',
                  style: TextStyle(fontWeight: FontWeight.bold)),
            ),
            DataColumn(
                label: Text(
              'Comments',
              style: TextStyle(fontWeight: FontWeight.bold),
            )),
          ],

          source: data,
          rowsPerPage: 20,
        ),
      ),
    );
  }
}

class MyDataPage extends DataTableSource {
  MyDataPage({
    required this.context,
    required this.posts,
  });
  final BuildContext context;
  List<Post> posts = [];
  @override
  DataRow? getRow(int index) {
    return DataRow(cells: [
      DataCell(
        Text(posts[index].title.toString()),
      ),
      DataCell(
        Row(
          children: [
            Text(
              posts[index].body ?? "",
              overflow: TextOverflow.ellipsis,
              maxLines: 2,
            ),
            Tooltip(
              message: posts[index].body,
              child: Icon(
                Icons.info_outline,
                color: AppColors.grey,
              ),
            ),
          ],
        ),
      ),
      DataCell(
        InkWell(
            onTap: () async {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => UserPostScreen(
                          userId: posts[index].userId.toString(),
                        )),
              );
            },
            child: Text(posts[index].userId.toString(),
                style: const TextStyle(
                    color: Colors.blue, decoration: TextDecoration.underline))),
      ),
      DataCell(
        InkWell(
            child: const Icon(Icons.comment),
            onTap: () async {
              // Call API to fetch comments
              List<Comment> comments =
                  await APIService().getComments(posts[index].id.toString());

              showDialog(
                barrierDismissible: true,
                context: context,
                useSafeArea: true,
                builder: (BuildContext context) {
                  return Center(
                    child: SizedBox(
                      height: 600,
                      width: 800,
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
                                        onTap: () =>
                                            ScaffoldMessenger.of(context)
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
                                      child: Icon(Icons.close,
                                          color: AppColors.grey)),
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
                                    posts[1].title ?? '',
                                    style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 24),
                                  ),
                                  addVerticalSpace(15),
                                  Text(posts[1].body ?? ''),
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
                                        parent:
                                            AlwaysScrollableScrollPhysics()),
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
                    ),
                  );
                },
              );
            }),
      ),
    ]);
  }

  @override
  bool get isRowCountApproximate => false;

  @override
  int get rowCount => posts.length;

  @override
  int get selectedRowCount => 0;
}
