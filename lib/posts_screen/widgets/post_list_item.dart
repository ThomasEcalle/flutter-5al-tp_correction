import 'package:correction_flutter_tp_al/shared/core/models/post.dart';
import 'package:flutter/material.dart';

class PostListItem extends StatelessWidget {
  const PostListItem({
    super.key,
    required this.post,
    this.onTap,
  });

  final Post post;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(post.title ?? ''),
      subtitle: Text(post.description ?? ''),
      onTap: onTap,
    );
  }
}
