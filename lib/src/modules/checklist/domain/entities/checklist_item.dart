class ChecklistItem {
  final String id;
  final String description;
  final bool checked;
  final String? photoPath;
  final String? notes;

  const ChecklistItem({
    required this.id,
    required this.description,
    required this.checked,
    this.photoPath,
    this.notes,
  });

  ChecklistItem copyWith({
    bool? checked,
    String? photoPath,
    String? notes,
  }) {
    return ChecklistItem(
      id: id,
      description: description,
      checked: checked ?? this.checked,
      photoPath: photoPath ?? this.photoPath,
      notes: notes ?? this.notes,
    );
  }
}