import '../entities/checklist.dart';

class SubmitChecklistUseCase {
  Future<void> call(Checklist checklist) async {
    _validateChecklist(checklist);

    await Future.delayed(const Duration(seconds: 1));
  }

  void _validateChecklist(Checklist checklist) {
    final uncheckedItems = checklist.items.where((item) => !item.checked).toList();

    if (uncheckedItems.isNotEmpty) {
      throw Exception('Checklist is not fully checked');
    }
  }
}