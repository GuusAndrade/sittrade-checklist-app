import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sittrade_checklist_app/src/modules/checklist/domain/entities/checklist.dart';
import 'package:sittrade_checklist_app/src/modules/checklist/domain/entities/checklist_item.dart';

import '../bloc/checklist_bloc.dart';
import '../bloc/checklist_event.dart';
import '../bloc/checklist_state.dart';

class ChecklistPage extends StatelessWidget {
  const ChecklistPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ChecklistBloc()..add(const LoadChecklist()),
      child: BlocListener<ChecklistBloc, ChecklistState>(
        listener: (context, state) {
          if (state is ChecklistSubmitted) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('Checklist successfully submitted!'),
                backgroundColor: Colors.green,
              ),
            );
          }

          if (state is ChecklistError) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text('Erro: ${state.message}'),
                backgroundColor: Colors.red,
              ),
            );
          }
        },
        child: Scaffold(
          appBar: AppBar(title: const Text('Checklist SitTrade')),
          body: const _ChecklistBody(),
        ),
      ),
    );
  }
}

class _ChecklistBody extends StatelessWidget {
  const _ChecklistBody();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ChecklistBloc, ChecklistState>(
      builder: (context, state) {
        if (state is ChecklistLoading) {
          return const Center(child: CircularProgressIndicator());
        }

        if (state is ChecklistLoaded) {
          return _ChecklistList(checklist: state.checklist);
        }

        return const Center(child: Text('No checklist loaded'));
      },
    );
  }
}

class ChecklistItemTile extends StatelessWidget {
  final ChecklistItem item;

  const ChecklistItemTile({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        leading: Checkbox(
          value: item.checked,
          onChanged: (_) {
            context.read<ChecklistBloc>().add(ToggleChecklistItem(item.id));
          },
        ),
        title: Text(item.description),
        subtitle: item.photoPath != null ? const Text('Photo attached') : null,
        trailing: IconButton(
          icon: const Icon(Icons.camera_alt),
          onPressed: () {
            _onAddPhoto(context);
          },
        ),
      ),
    );
  }

  void _onAddPhoto(BuildContext context) {
    context.read<ChecklistBloc>().add(
      AddPhotoToItem(itemId: item.id, photoPath: 'fake/path/photo.jpg'),
    );
  }
}

class _ChecklistList extends StatelessWidget {
  final Checklist checklist;

  const _ChecklistList({required this.checklist});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(20),
          child: Text(
            checklist.title,
            style: Theme.of(context).textTheme.titleLarge,
          ),
        ),
        Expanded(
          child: ListView.builder(
            itemCount: checklist.items.length,
            itemBuilder: (context, index) {
              final item = checklist.items[index];

              return ChecklistItemTile(item: item);
            },
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(20),
          child: ElevatedButton(
            onPressed: () {
              context.read<ChecklistBloc>().add(const SubmitChecklist());
            },
            child: const Text('Enviar Checklist'),
          ),
        ),
      ],
    );
  }
}
