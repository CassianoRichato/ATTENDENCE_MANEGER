import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import '../../../domain/entities/attendance.dart';
import '../../../domain/entities/attendance_status.dart';
import '../../../domain/usecases/create_attendance_usecase.dart';
import '../../../domain/usecases/update_attendance_usecase.dart';
import '../../../domain/usecases/get_attendance_by_id_usecase.dart';
import 'attendance_form_state.dart';

@injectable
class AttendanceFormCubit extends Cubit<AttendanceFormState> {
  final CreateAttendanceUseCase _createAttendanceUseCase;
  final UpdateAttendanceUseCase _updateAttendanceUseCase;
  final GetAttendanceByIdUseCase _getAttendanceByIdUseCase;

  AttendanceFormCubit(
    this._createAttendanceUseCase,
    this._updateAttendanceUseCase,
    this._getAttendanceByIdUseCase,
  ) : super(AttendanceFormInitial());

  Future<void> loadAttendance(int id) async {
    try {
      emit(AttendanceFormLoading());
      final attendance = await _getAttendanceByIdUseCase(id);
      if (attendance != null) {
        emit(AttendanceFormSuccess(attendance));
      } else {
        emit(AttendanceFormError('Atendimento não encontrado'));
      }
    } catch (e) {
      emit(AttendanceFormError('Erro ao carregar atendimento: $e'));
    }
  }

  Future<void> saveAttendance({
    int? id,
    required String title,
    String? description,
  }) async {
    try {
      emit(AttendanceFormLoading());

      final attendance = Attendance(
        id: id,
        title: title,
        description: description,
        status: AttendanceStatus.pending,
        createdAt: id == null ? DateTime.now() : DateTime.now(),
        updatedAt: id != null ? DateTime.now() : null,
      );

      if (id == null) {
        await _createAttendanceUseCase(attendance);
      } else {
        await _updateAttendanceUseCase(attendance);
      }

      emit(AttendanceFormSuccess(attendance));
    } catch (e) {
      emit(AttendanceFormError('Erro ao salvar atendimento: $e'));
    }
  }
}
