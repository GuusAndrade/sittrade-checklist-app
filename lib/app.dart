import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sittrade_checklist_app/src/modules/checklist/presentation/bloc/checklist_event.dart';

import 'src/modules/checklist/presentation/bloc/checklist_bloc.dart';
import 'src/modules/checklist/presentation/pages/checklist_page.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'SitTrade Checklist',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: BlocProvider(
        create: (_) => ChecklistBloc()..add(const LoadChecklist()),
        child: const ChecklistPage(),
      ),
    );
  }
}
