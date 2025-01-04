import 'package:correction_flutter_tp_al/posts_screen/add_or_edit_post_screen/add_or_edit_post_screen.dart';
import 'package:correction_flutter_tp_al/posts_screen/posts_bloc/posts_bloc.dart';
import 'package:correction_flutter_tp_al/posts_screen/widgets/post_list_item.dart';
import 'package:correction_flutter_tp_al/shared/core/exceptions/app_exception.dart';
import 'package:correction_flutter_tp_al/shared/core/models/post.dart';
import 'package:correction_flutter_tp_al/shared/widgets/error_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PostsScreen extends StatefulWidget {
  const PostsScreen({super.key});

  @override
  State<PostsScreen> createState() => _PostsScreenState();
}

class _PostsScreenState extends State<PostsScreen> {
  @override
  void initState() {
    super.initState();
    _getPosts();
  }

  void _getPosts() {
    context.read<PostsBloc>().add(const GetPosts());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Posts'),
      ),
      body: BlocBuilder<PostsBloc, PostsState>(
        builder: (context, state) {
          return switch (state.status) {
            PostsStatus.loading => _buildLoading(context),
            PostsStatus.error => _buildError(context, state.exception),
            PostsStatus.success => _buildPosts(context, state.posts),
          };
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _onAddPostTap(context),
        child: const Icon(Icons.add),
      ),
    );
  }

  Widget _buildLoading(BuildContext context) {
    return const Center(
      child: CircularProgressIndicator(),
    );
  }

  Widget _buildError(BuildContext context, AppException? exception) {
    return Center(
      child: ErrorView(
        error: exception,
      ),
    );
  }

  Widget _buildEmpty(BuildContext context) {
    return const Center(
      child: Text('No posts found'),
    );
  }

  Widget _buildPosts(BuildContext context, List<Post> posts) {
    if (posts.isEmpty) return _buildEmpty(context);
    return ListView.separated(
      itemCount: posts.length,
      separatorBuilder: (context, index) => const Divider(),
      itemBuilder: (context, index) {
        final post = posts[index];
        return PostListItem(
          post: post,
          onTap: () => _onPostTap(context, post),
        );
      },
    );
  }

  void _onAddPostTap(BuildContext context) {
    AddOrEditPostScreen.navigate(context);
  }

  void _onPostTap(BuildContext context, Post post) {
    AddOrEditPostScreen.navigate(context, post: post);
  }
}
