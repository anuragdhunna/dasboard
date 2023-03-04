class Comment {
  final int? postId;
  final int? id;
  final String? name;
  final String? email;
  final String? body;

  Comment({
    this.postId,
    this.id,
    this.name,
    this.email,
    this.body,
  });

  Comment.fromJson(Map<String, dynamic> json)
      : postId = json['postId'] as int?,
        id = json['id'] as int?,
        name = json['name'] as String?,
        email = json['email'] as String?,
        body = json['body'] as String?;

  Map<String, dynamic> toJson() =>
      {'postId': postId, 'id': id, 'name': name, 'email': email, 'body': body};
}
