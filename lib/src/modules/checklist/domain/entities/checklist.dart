import 'checklist_item.dart';

class Checklist {
  final String id;
  final String title;
  final List<ChecklistItem> items;

  const Checklist({
    required this.id,
    required this.title,
    required this.items,
  });

  Checklist copyWith({
    String? id,
    String? title,
    List<ChecklistItem>? items,
  }) {
    return Checklist(
      id: id ?? this.id,
      title: title ?? this.title,
      items: items ?? this.items,
    );
  }
}