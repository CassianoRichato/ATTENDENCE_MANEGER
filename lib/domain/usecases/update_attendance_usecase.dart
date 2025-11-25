import 'package:injectable/injectable.dart';
import '../entities/attendance.dart';
import '../repositories/attendance_repository.dart';

@injectable
class UpdateAttendanceUseCase {
  final AttendanceRepository repository;

  UpdateAttendanceUseCase(this.repository);

  Future<void> call(Attendance attendance) {
    return repository.updateAttendance(attendance);
  }
}
