import 'package:injectable/injectable.dart';
import '../repositories/attendance_repository.dart';

@injectable
class ToggleAttendanceStatusUseCase {
  final AttendanceRepository repository;

  ToggleAttendanceStatusUseCase(this.repository);

  Future<void> call(int id, bool isActive) {
    return repository.toggleAttendanceStatus(id, isActive);
  }
}
