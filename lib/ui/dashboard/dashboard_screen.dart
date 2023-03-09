import 'dart:developer';

import 'package:collapsible_sidebar/collapsible_sidebar.dart';
import 'package:collapsible_sidebar/collapsible_sidebar/collapsible_item.dart';
import 'package:dasboard/constants/app_colors.dart';
import 'package:dasboard/constants/assets_path.dart';
import 'package:dasboard/models/comment.dart';
import 'package:dasboard/services/api_services.dart';
import 'package:dasboard/ui/dashboard/post_table.dart';
import 'package:dasboard/ui/dashboard/summary_card.dart';
import 'package:dasboard/ui/user_post/user_post_screen.dart';
import 'package:dasboard/utils/widgetFunctions.dart';
import 'package:flutter/material.dart';

import '../../models/post.dart';
import '../../utils/widgets/loading.dart';
import '../../utils/widgets/post_widgets/post_detail_widget.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({Key? key, required this.dashboardNo})
      : super(key: key);
  final int dashboardNo;
  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  late List<CollapsibleItem> _items;
  late String _headline;
  final AssetImage _avatarImg = const AssetImage(AssetsPath.appLogo);
  @override
  void initState() {
    super.initState();
    _items = _generateItems;
    _headline = _items.firstWhere((item) => item.isSelected).text;
  }

  List<CollapsibleItem> get _generateItems {
    return [
      CollapsibleItem(
        text: 'Dashboard',
        icon: Icons.assessment,
        onPressed: () => setState(() => _headline = 'DashBoard'),
        isSelected: true,
      ),
      CollapsibleItem(
          text: 'Logout',
          icon: Icons.logout,
          onPressed: () {
            Navigator.pop(context);
          }),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => true,
      child: CollapsibleSidebar(
        isCollapsed: true,
        items: _items,
        iconSize: 40,
        collapseOnBodyTap: true,
        avatarImg: _avatarImg,
        title: 'Pathverse',
        onTitleTap: () {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Title Tap'),
            ),
          );
        },
        backgroundColor: Colors.black,
        selectedTextColor: AppColors.orange,
        selectedIconColor: AppColors.orange,
        textStyle: const TextStyle(
          decoration: TextDecoration.none,
          fontSize: 15,
          fontStyle: FontStyle.normal,
        ),
        titleStyle: const TextStyle(
            decoration: TextDecoration.none,
            fontSize: 20,
            fontStyle: FontStyle.normal,
            fontWeight: FontWeight.bold),
        curve: Curves.ease,
        borderRadius: 0,
        bottomPadding: 0,
        screenPadding: 0,
        topPadding: 0,
        height: double.infinity,
        toggleTitleStyle: const TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.bold,
          decoration: TextDecoration.none,
        ),
        sidebarBoxShadow: [
          BoxShadow(
            color: AppColors.orange,
            blurRadius: 2,
            spreadRadius: 0.01,
            offset: const Offset(7, 0),
          ),
        ],
        body: Scaffold(
          backgroundColor: AppColors.black,
          body: getPost(context),
        ),
      ),
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

    return SizedBox(
      height: double.infinity,
      width: double.infinity,
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('Dashboard',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),

              addVerticalSpace(10),
              Wrap(
                alignment: WrapAlignment.end,
                children: const [
                  SummaryCard(
                    label: 'Total Posts',
                    count: '100',
                    icon: Icons.post_add,
                  ),
                  SummaryCard(
                    label: 'Total Users',
                    count: '50',
                    icon: Icons.person,
                  ),
                  SummaryCard(
                    label: 'Total Comments',
                    count: '500',
                    icon: Icons.comment,
                  ),
                ],
              ),
              addVerticalSpace(10),

              /// List of Posts
              if (widget.dashboardNo == 2) ...[
                PostTable(data: data),
              ],

              if (widget.dashboardNo == 1) ...[
                Text('  Post Updates',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.normal,
                      color: AppColors.white,
                    )),
                ListView.builder(
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
              ],
            ],
          ),
        ),
      ),
    );
  }

  Widget buildPost(BuildContext context, Post post) {
    return Card(
      elevation: 5,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10),
        child: Row(
          children: [
            InkWell(
              onTap: () async {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => UserPostScreen(
                            userId: post.userId.toString(),
                          )),
                );
              },
              child: CircleAvatar(
                radius: 35,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(45),
                  child: Image.asset(
                    AssetsPath.femaleUser,
                  ),
                ),
              ),
            ),
            addHorizontalSpace(10),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Text(
                      post.title ?? "",
                      style: const TextStyle(
                          fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                    // const Spacer(),
                    // const Text('6 hours ago'),
                  ],
                ),
                addVerticalSpace(10),
                Text(post.body ?? ""),
                addVerticalSpace(10),
              ],
            ),
            const Spacer(),
            Row(
              children: [
                Container(
                    height: 40,
                    width: 35,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        color: Colors.black12),
                    child: const Icon(Icons.share)),
                addHorizontalSpace(20),
                Container(
                    height: 40,
                    width: 130,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        color: Colors.black12),
                    child: InkWell(
                      onTap: () async {
                        // Call API to fetch comments
                        List<Comment> comments =
                            await APIService().getComments(post.id.toString());

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
                                    post: post, comments: comments),
                              ),
                            );
                          },
                        );
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Icon(Icons.comment),
                          addHorizontalSpace(5),
                          const Text(
                            'Comment',
                          ),
                        ],
                      ),
                    )),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
