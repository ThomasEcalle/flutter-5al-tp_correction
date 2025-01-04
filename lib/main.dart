import 'package:correction_flutter_tp_al/posts_screen/add_or_edit_post_screen/add_or_edit_post_bloc/add_or_edit_bloc.dart';
import 'package:correction_flutter_tp_al/posts_screen/posts_bloc/posts_bloc.dart';
import 'package:correction_flutter_tp_al/shared/core/services/posts_repository/posts_data_source/fake_posts_data_source.dart';
import 'package:correction_flutter_tp_al/shared/core/services/posts_repository/posts_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'posts_screen/add_or_edit_post_screen/add_or_edit_post_screen.dart';
import 'posts_screen/posts_screen.dart';
import 'shared/core/models/post.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return RepositoryProvider(
      create: (context) => PostsRepository(
        postsDataSource: FakePostsDataSource(),
      ),
      child: BlocProvider(
        create: (context) => PostsBloc(
          postsRepository: context.read<PostsRepository>(),
        ),
        child: MaterialApp(
          routes: {
            '/': (context) => const PostsScreen(),
          },
          onGenerateRoute: (settings) {
            Widget screen = Container(color: Colors.red);

            final arguments = settings.arguments;

            switch (settings.name) {
              case AddOrEditPostScreen.routeName:
                if (arguments is Post?) {
                  screen = BlocProvider(
                    create: (context) => AddOrEditBloc(
                      postsRepository: context.read<PostsRepository>(),
                    ),
                    child: AddOrEditPostScreen(post: arguments),
                  );
                }
                break;
            }

            return MaterialPageRoute(builder: (context) => screen);
          },
        ),
      ),
    );
  }
}
