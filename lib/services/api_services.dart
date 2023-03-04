import 'package:dasboard/services/base_api_services.dart';
import 'package:dio/dio.dart';

import '../models/comment.dart';
import '../models/post.dart';

class APIService {
  static const String getPostUrl = 'posts';
  static const String getUserPostUrl = 'users/<userID>/posts';
  static const String getPostCommentsUrl = 'posts/<postId>/comments';

  Dio getClient(url) => Dio(BaseOptions(baseUrl: url));

  Future<List<Post>> getPosts() async {
    final response = await BaseApiService().get(getPostUrl);
    return (response.data as List).map((e) => Post.fromJson(e)).toList();
  }

  Future<List<Comment>> getComments(String postId) async {
    final response = await BaseApiService()
        .get(getPostCommentsUrl.replaceAll('<postId>', postId));
    return (response.data as List).map((e) => Comment.fromJson(e)).toList();
  }
}
