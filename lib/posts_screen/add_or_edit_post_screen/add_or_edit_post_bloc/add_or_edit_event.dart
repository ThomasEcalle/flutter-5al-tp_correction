part of 'add_or_edit_bloc.dart';

@immutable
sealed class AddOrEditEvent {
  const AddOrEditEvent();
}

class AddPost extends AddOrEditEvent {
  final Post post;

  const AddPost(this.post);
}

class EditPost extends AddOrEditEvent {
  final Post post;

  const EditPost(this.post);
}
