import 'package:injectable/injectable.dart';
import '../entities/attendance.dart';
import '../entities/attendance_status.dart';
import '../repositories/attendance_repository.dart';

@injectable
class GetAttendancesUseCase {
  final AttendanceRepository repository;

  GetAttendancesUseCase(this.repository);

  Future<List<Attendance>> call({AttendanceStatus? statusFilter}) {
    return repository.getAttendances(statusFilter: statusFilter);
  }
}
