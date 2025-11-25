import 'package:injectable/injectable.dart';
import '../entities/attendance.dart';
import '../entities/attendance_status.dart';
import '../repositories/attendance_repository.dart';

@injectable
class FinishAttendanceUseCase {
  final AttendanceRepository repository;

  FinishAttendanceUseCase(this.repository);

  Future<void> call(
    Attendance attendance,
    String? imagePath,
    String? observations,
  ) async {
    if (imagePath == null || imagePath.isEmpty) {
      throw Exception('É necessário uma foto para finalizar o atendimento');
    }

    final updatedAttendance = attendance.copyWith(
      status: AttendanceStatus.finished,
      finishedAt: DateTime.now(),
      imagePath: imagePath,
      observations: observations,
      updatedAt: DateTime.now(),
    );

    await repository.updateAttendance(updatedAttendance);
  }
}
