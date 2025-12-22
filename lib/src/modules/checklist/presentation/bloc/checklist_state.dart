import 'package:equatable/equatable.dart';
import '../../domain/entities/checklist.dart';

abstract class ChecklistState extends Equatable {
  const ChecklistState();

  @override
  List<Object?> get props => [];
}

class ChecklistInitial extends ChecklistState {
  const ChecklistInitial();
}

class ChecklistLoading extends ChecklistState {
  const ChecklistLoading();
}

class ChecklistLoaded extends ChecklistState {
  final Checklist checklist;
  const ChecklistLoaded(this.checklist);

  @override
  List<Object?> get props => [checklist];
}

class ChecklistSubmitted extends ChecklistState {
  const ChecklistSubmitted();
}

class ChecklistInProgress extends ChecklistState {
  const ChecklistInProgress();
}

class ChecklistSuccess extends ChecklistState {
  const ChecklistSuccess();
}

class ChecklistError extends ChecklistState {
  final String message;
  const ChecklistError(this.message);

  @override
  List<Object?> get props => [message];
}