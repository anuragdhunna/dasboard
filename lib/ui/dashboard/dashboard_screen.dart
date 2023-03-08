import 'dart:developer';

import 'package:collapsible_sidebar/collapsible_sidebar.dart';
import 'package:collapsible_sidebar/collapsible_sidebar/collapsible_item.dart';
import 'package:dasboard/constants/app_colors.dart';
import 'package:dasboard/constants/assets_path.dart';
import 'package:dasboard/services/api_services.dart';
import 'package:dasboard/ui/dashboard/post_table.dart';
import 'package:dasboard/ui/dashboard/summary_card.dart';
import 'package:dasboard/utils/widgetFunctions.dart';
import 'package:flutter/material.dart';

import '../../models/post.dart';
import '../../utils/widgets/loading.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({Key? key}) : super(key: key);

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
        onPressed: () => setState(() => _headline = 'Logout'),
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => true,
      child: CollapsibleSidebar(
        isCollapsed: MediaQuery.of(context).size.width <= 800,
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
        selectedTextColor: Colors.orange,
        selectedIconColor: Colors.orange,
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
        sidebarBoxShadow: const [
          BoxShadow(
            color: Colors.orange,
            blurRadius: 2,
            spreadRadius: 0.01,
            offset: Offset(3, 3),
          ),
          BoxShadow(
            color: Colors.orange,
            blurRadius: 10,
            spreadRadius: 0.01,
            offset: Offset(3, 3),
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

              /// List of Posts
              PostTable(data: data),
            ],
          ),
        ),
      ),
    );
  }
}
