import 'package:injectable/injectable.dart';
import '../../domain/entities/attendance.dart';
import '../../domain/entities/attendance_status.dart';
import '../../domain/repositories/attendance_repository.dart';
import '../datasources/local_data_source.dart';
import '../models/attendance_model.dart';

@Injectable(as: AttendanceRepository)
class AttendanceRepositoryImpl implements AttendanceRepository {
  final LocalDataSource _localDataSource;

  AttendanceRepositoryImpl(this._localDataSource);

  @override
  Future<List<Attendance>> getAttendances(
      {AttendanceStatus? statusFilter}) async {
    return await _localDataSource.getAttendances(statusFilter: statusFilter);
  }

  @override
  Future<Attendance?> getAttendanceById(int id) async {
    return await _localDataSource.getAttendanceById(id);
  }

  @override
  Future<int> createAttendance(Attendance attendance) async {
    final model = AttendanceModel.fromEntity(attendance);
    return await _localDataSource.insertAttendance(model);
  }

  @override
  Future<void> updateAttendance(Attendance attendance) async {
    final model = AttendanceModel.fromEntity(attendance);
    await _localDataSource.updateAttendance(model);
  }

  @override
  Future<void> deleteAttendance(int id) async {
    await _localDataSource.deleteAttendance(id);
  }

  @override
  Future<void> toggleAttendanceStatus(int id, bool isActive) async {
    await _localDataSource.toggleAttendanceStatus(id, isActive);
  }
}
