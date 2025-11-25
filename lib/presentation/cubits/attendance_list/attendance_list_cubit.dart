import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import '../../../domain/entities/attendance_status.dart';
import '../../../domain/usecases/get_attendances_usecase.dart';
import '../../../domain/usecases/delete_attendance_usecase.dart';
import '../../../domain/usecases/toggle_attendance_status_usecase.dart';
import 'attendance_list_state.dart';

@injectable
class AttendanceListCubit extends Cubit<AttendanceListState> {
  final GetAttendancesUseCase _getAttendancesUseCase;
  final DeleteAttendanceUseCase _deleteAttendanceUseCase;
  final ToggleAttendanceStatusUseCase _toggleAttendanceStatusUseCase;

  AttendanceListCubit(
    this._getAttendancesUseCase,
    this._deleteAttendanceUseCase,
    this._toggleAttendanceStatusUseCase,
  ) : super(AttendanceListInitial());

  Future<void> loadAttendances({AttendanceStatus? statusFilter}) async {
    try {
      emit(AttendanceListLoading());
      final attendances =
          await _getAttendancesUseCase(statusFilter: statusFilter);
      emit(AttendanceListLoaded(attendances, currentFilter: statusFilter));
    } catch (e) {
      emit(AttendanceListError('Erro ao carregar atendimentos: $e'));
    }
  }

  Future<void> deleteAttendance(int id) async {
    try {
      await _deleteAttendanceUseCase(id);
      final currentState = state;
      if (currentState is AttendanceListLoaded) {
        await loadAttendances(statusFilter: currentState.currentFilter);
      }
    } catch (e) {
      emit(AttendanceListError('Erro ao excluir atendimento: $e'));
    }
  }

  Future<void> toggleAttendanceStatus(int id, bool isActive) async {
    try {
      await _toggleAttendanceStatusUseCase(id, isActive);
      final currentState = state;
      if (currentState is AttendanceListLoaded) {
        await loadAttendances(statusFilter: currentState.currentFilter);
      }
    } catch (e) {
      emit(AttendanceListError('Erro ao alterar status: $e'));
    }
  }
}
