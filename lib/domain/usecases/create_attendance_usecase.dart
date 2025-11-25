import 'package:injectable/injectable.dart';
import '../entities/attendance.dart';
import '../repositories/attendance_repository.dart';

@injectable
class CreateAttendanceUseCase {
  final AttendanceRepository repository;

  CreateAttendanceUseCase(this.repository);

  Future<int> call(Attendance attendance) {
    return repository.createAttendance(attendance);
  }
}
