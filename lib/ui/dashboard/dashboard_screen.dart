import 'dart:developer';

import 'package:dasboard/constants/app_colors.dart';
import 'package:dasboard/models/comment.dart';
import 'package:dasboard/services/api_services.dart';
import 'package:dasboard/ui/dashboard/post_comment.dart';
import 'package:dasboard/ui/dashboard/summary_card.dart';
import 'package:dasboard/utils/widgetFunctions.dart';
import 'package:flutter/material.dart';

import '../../models/post.dart';
import '../../utils/widgets/loading.dart';
import 'icon_with_label.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({Key? key}) : super(key: key);

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      body: getPost(context),
      drawer: Drawer(
        child: ListView(
          children: const [
            DrawerHeader(child: Text('Pathverse')),
            ListTile(title: Text('Homepage')),
          ],
        ),
      ),
      appBar: AppBar(),
    );
  }

  FutureBuilder getPost(BuildContext context) {
    var futureBuilder = FutureBuilder(
      future: APIService().getPosts(),
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

  Widget buildBody(BuildContext context, List<Post> posts) {
    final DataTableSource data = MyDataPage(context: context, posts: posts);

    // PaginatedDataTable.defaultRowsPerPage provides value as 10
    final key = GlobalKey<PaginatedDataTableState>();

    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Home Page',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            addVerticalSpace(10),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: const [
                SummaryCard(
                  label: 'Posts',
                  count: '100',
                ),
                SummaryCard(
                  label: 'Users',
                  count: '50',
                ),
                SummaryCard(
                  label: 'Comments',
                  count: '500',
                ),
              ],
            ),
            addVerticalSpace(10),
            buildPaginatedDataTable(context, key, data),
          ],
        ),
      ),
    );
  }

  SizedBox buildPaginatedDataTable(BuildContext context,
      GlobalKey<PaginatedDataTableState> key, DataTableSource data) {
    return SizedBox(
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
            label:
                Text('User ID', style: TextStyle(fontWeight: FontWeight.bold)),
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
                                      const IconWithLabel(
                                        label: 'Copy Link',
                                        icon: Icons.link,
                                      ),
                                      addHorizontalSpace(10),
                                      const IconWithLabel(
                                        label: 'Delete Post',
                                        icon: Icons.delete_sweep_outlined,
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
  // TODO: implement isRowCountApproximate
  bool get isRowCountApproximate => false;

  @override
  // TODO: implement rowCount
  int get rowCount => posts.length;

  @override
  // TODO: implement selectedRowCount
  int get selectedRowCount => 0;
}
