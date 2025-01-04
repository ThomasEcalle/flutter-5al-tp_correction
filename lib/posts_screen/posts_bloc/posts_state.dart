part of 'posts_bloc.dart';

enum PostsStatus {
  loading,
  success,
  error,
}

class PostsState {
  final PostsStatus status;
  final List<Post> posts;
  final AppException? exception;

  const PostsState({
    this.status = PostsStatus.loading,
    this.posts = const [],
    this.exception,
  });

  PostsState copyWith({
    PostsStatus? status,
    List<Post>? posts,
    AppException? exception,
  }) {
    return PostsState(
      status: status ?? this.status,
      posts: posts ?? this.posts,
      exception: exception,
    );
  }
}
