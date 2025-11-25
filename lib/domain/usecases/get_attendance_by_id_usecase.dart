import 'package:injectable/injectable.dart';
import '../entities/attendance.dart';
import '../repositories/attendance_repository.dart';

@injectable
class GetAttendanceByIdUseCase {
  final AttendanceRepository repository;

  GetAttendanceByIdUseCase(this.repository);

  Future<Attendance?> call(int id) {
    return repository.getAttendanceById(id);
  }
}
