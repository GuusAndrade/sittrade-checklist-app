import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sittrade_checklist_app/src/modules/checklist/domain/usecases/submit_checklist_usecase.dart';

import 'checklist_event.dart';
import 'checklist_state.dart';
import '../../domain/entities/checklist.dart';
import '../../domain/entities/checklist_item.dart';

class ChecklistBloc extends Bloc<ChecklistEvent, ChecklistState> {
  final SubmitChecklistUseCase submitChecklistUseCase;

  ChecklistBloc({SubmitChecklistUseCase? submitChecklistUseCase})
    : submitChecklistUseCase =
          submitChecklistUseCase ?? SubmitChecklistUseCase(),
      super(const ChecklistInitial()) {
    on<LoadChecklist>(_onLoadChecklist);
    on<ToggleChecklistItem>(_onToggleItem);
    on<AddPhotoToItem>(_onAddPhoto);
    on<SubmitChecklist>(_onSubmitChecklist);
  }

  Future<void> _onLoadChecklist(
    LoadChecklist event,
    Emitter<ChecklistState> emit,
  ) async {
    emit(const ChecklistLoading());

    await Future.delayed(const Duration(milliseconds: 500));

    final checklist = Checklist(
      id: '1',
      title: 'Checklist de Execução',
      items: [
        ChecklistItem(
          id: '1',
          description: 'Verificar material faltante',
          checked: false,
        ),
        ChecklistItem(
          id: '2',
          description: 'Organizar gôndola',
          checked: false,
        ),
      ],
    );

    emit(ChecklistLoaded(checklist));
  }

  void _onToggleItem(ToggleChecklistItem event, Emitter<ChecklistState> emit) {
    final currentState = state;

    if (currentState is! ChecklistLoaded) return;

    final updatedItems = currentState.checklist.items.map((item) {
      if (item.id == event.itemId) {
        return item.copyWith(checked: !item.checked);
      }
      return item;
    }).toList();

    emit(
      ChecklistLoaded(
        Checklist(
          id: currentState.checklist.id,
          title: currentState.checklist.title,
          items: updatedItems,
        ),
      ),
    );
  }

  void _onAddPhoto(AddPhotoToItem event, Emitter<ChecklistState> emit) {
    final currentState = state;

    if (currentState is! ChecklistLoaded) return;

    final updatedItems = currentState.checklist.items.map((item) {
      if (item.id == event.itemId) {
        return item.copyWith(photoPath: event.photoPath);
      }
      return item;
    }).toList();

    emit(
      ChecklistLoaded(
        Checklist(
          id: currentState.checklist.id,
          title: currentState.checklist.title,
          items: updatedItems,
        ),
      ),
    );
  }

  Future<void> _onSubmitChecklist(
    SubmitChecklist event,
    Emitter<ChecklistState> emit,
  ) async {
    final currentState = state;

    if (currentState is! ChecklistLoaded) return;

    emit(const ChecklistLoading());

    try {
      await submitChecklistUseCase(currentState.checklist);

      emit(const ChecklistSubmitted());
    } catch (e) {
      emit(ChecklistError(e.toString()));
      return;
    }
  }
}
