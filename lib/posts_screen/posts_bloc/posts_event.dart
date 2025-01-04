part of 'posts_bloc.dart';

@immutable
sealed class PostsEvent {
  const PostsEvent._();
}

class GetPosts extends PostsEvent {
  const GetPosts() : super._();
}
