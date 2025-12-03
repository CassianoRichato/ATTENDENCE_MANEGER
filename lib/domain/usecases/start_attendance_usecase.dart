import 'package:injectable/injectable.dart';
import '../entities/attendance.dart';
import '../entities/attendance_status.dart';
import '../repositories/attendance_repository.dart';

@injectable
class StartAttendanceUseCase {
  final AttendanceRepository repository;

  StartAttendanceUseCase(this.repository);

  Future<void> call(Attendance attendance) async {
    final updatedAttendance = attendance.copyWith(
      status: AttendanceStatus.inProgress,
      updatedAt: DateTime.now(),
    );

    await repository.updateAttendance(updatedAttendance);
  }
}
