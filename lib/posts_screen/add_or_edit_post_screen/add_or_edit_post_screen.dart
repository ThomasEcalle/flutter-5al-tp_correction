import 'package:correction_flutter_tp_al/posts_screen/add_or_edit_post_screen/add_or_edit_post_bloc/add_or_edit_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../shared/core/models/post.dart';

class AddOrEditPostScreen extends StatefulWidget {
  static const String routeName = '/add-or-edit-post';

  static void navigate(BuildContext context, {Post? post}) {
    Navigator.of(context).pushNamed(routeName, arguments: post);
  }

  final Post? post;

  const AddOrEditPostScreen({
    super.key,
    this.post,
  });

  @override
  State<AddOrEditPostScreen> createState() => _AddOrEditPostScreenState();
}

class _AddOrEditPostScreenState extends State<AddOrEditPostScreen> {
  Post? get _post => widget.post;

  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _titleController.text = _post?.title ?? '';
    _descriptionController.text = _post?.description ?? '';
    _titleController.addListener(() => setState(() {}));
    _descriptionController.addListener(() => setState(() {}));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.post == null ? 'Ajout de post' : 'Modification de post',
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(
          vertical: 10,
          horizontal: 20,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: _titleController,
              decoration: const InputDecoration(
                labelText: 'Titre',
              ),
            ),
            const SizedBox(height: 10),
            TextField(
              controller: _descriptionController,
              decoration: const InputDecoration(
                labelText: 'Description',
              ),
            ),
            const SizedBox(height: 40),
            BlocConsumer<AddOrEditBloc, AddOrEditState>(
              listener: _onAddOrEditPostBlocListener,
              builder: (context, state) {
                final editing = state.status == AddOrdEditStatus.editingPost;
                final adding = state.status == AddOrdEditStatus.addingPost;
                final loading = editing || adding;

                return _buildButton(context, loading: loading);
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildButton(BuildContext context, {bool loading = false}) {
    if (loading) return const CircularProgressIndicator();
    return ElevatedButton(
      onPressed: _isButtonEnabled ? () => _onValidate(context) : null,
      child: const Text('Valider'),
    );
  }

  void _onValidate(BuildContext context) {
    if (!_isButtonEnabled) return;
    final title = _titleController.text;
    final description = _descriptionController.text;
    final isEditingPost = _post != null;

    final post = switch (isEditingPost) {
      true => _post?.copyWith(title: title, description: description),
      false => Post(title: title, description: description),
    };

    if (post == null) return;

    final event = switch (isEditingPost) {
      true => EditPost(post),
      false => AddPost(post),
    };

    context.read<AddOrEditBloc>().add(event);
  }

  void _onAddOrEditPostBlocListener(
    BuildContext context,
    AddOrEditState state,
  ) {
    final message = switch (state.status) {
      AddOrdEditStatus.successAddingPost => 'Post ajouté avec succès',
      AddOrdEditStatus.successEditingPost => 'Post modifié avec succès',
      AddOrdEditStatus.errorAddingPost =>
        'Erreur lors de l\'ajout du post : ${state.exception?.title}',
      AddOrdEditStatus.errorEditingPost =>
        'Erreur lors de la modification du post : ${state.exception?.title}',
      _ => null,
    };

    if (message == null) return;
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(message),
    ));
  }

  bool get _isButtonEnabled {
    final titleIsEmpty = _titleController.text.isEmpty;
    final descriptionIsEmpty = _descriptionController.text.isEmpty;
    return !titleIsEmpty && !descriptionIsEmpty;
  }
}
