import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sittrade_checklist_app/src/modules/checklist/domain/entities/checklist.dart';

import '../bloc/checklist_bloc.dart';
import '../bloc/checklist_event.dart';
import '../bloc/checklist_state.dart';

class ChecklistPage extends StatelessWidget {
  const ChecklistPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ChecklistBloc()..add(const LoadChecklist()),
      child: Scaffold(
        appBar: AppBar(title: const Text('Checklist SitTrade')),
        body: const _ChecklistBody(),
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

class _ChecklistList extends StatelessWidget {
  final Checklist checklist;

  const _ChecklistList({
    required this.checklist,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(16),
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

              return CheckboxListTile(
                title: Text(item.description),
                value: item.checked,
                onChanged: (_) {
                  context
                    .read<ChecklistBloc>()
                    .add(ToggleChecklistItem(item.id));
                },
              );
            },
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(16),
          child: ElevatedButton(
            onPressed: () {
              context
                .read<ChecklistBloc>()
                .add(const SubmitChecklist());
            },
            child: const Text('Enviar Checklist'),
          )
        )
      ],
    );
  }
}
