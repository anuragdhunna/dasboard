import 'package:dasboard/constants/app_colors.dart';
import 'package:dasboard/models/comment.dart';
import 'package:dasboard/models/post.dart';
import 'package:dasboard/services/api_services.dart';
import 'package:dasboard/ui/user_post/user_post_screen.dart';
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
          columnSpacing: 30,
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
                Icons.info_outline_rounded,
                color: AppColors.orange,
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
            child: const Icon(Icons.comment, color: Colors.orange),
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
                      child: PostDetailWidget(
                          post: posts[index], comments: comments),
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
