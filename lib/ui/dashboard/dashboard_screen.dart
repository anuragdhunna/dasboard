import 'dart:developer';

import 'package:dasboard/constants/app_colors.dart';
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
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => true,
      child: Scaffold(
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

            /// List of Posts
            PostTable(data: data),
          ],
        ),
      ),
    );
  }
}
