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

  Attendance? _loadedAttendance;

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
        _loadedAttendance = attendance;
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

      Attendance attendance;

      if (id == null) {
        attendance = Attendance(
          title: title,
          description: description,
          status: AttendanceStatus.pending,
          createdAt: DateTime.now(),
        );
        await _createAttendanceUseCase(attendance);
      } else {
        if (_loadedAttendance == null) {
          emit(AttendanceFormError('Erro: atendimento não carregado'));
          return;
        }

        attendance = _loadedAttendance!.copyWith(
          title: title,
          description: description,
          updatedAt: DateTime.now(),
        );
        await _updateAttendanceUseCase(attendance);
      }

      emit(AttendanceFormSuccess(attendance));
    } catch (e) {
      emit(AttendanceFormError('Erro ao salvar atendimento: $e'));
    }
  }
}
