import 'package:equatable/equatable.dart';

abstract class ChecklistEvent extends Equatable {
  const ChecklistEvent();

  @override
  List<Object?> get props => [];
}

class LoadChecklist extends ChecklistEvent {
  const LoadChecklist();
}

class ToggleChecklistItem extends ChecklistEvent {
  final String itemId;

  const ToggleChecklistItem(this.itemId);

  @override
  List<Object?> get props => [itemId]; 
}

class AddPhotoToItem extends ChecklistEvent {
  final String itemId;
  final String photoPath;

  const AddPhotoToItem({
    required this.itemId,
    required this.photoPath,
  });

  @override
  List<Object?> get props => [itemId, photoPath];
}

class SubmitChecklist extends ChecklistEvent {
  const SubmitChecklist();
}