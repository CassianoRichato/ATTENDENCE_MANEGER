import '../entities/attendance.dart';
import '../entities/attendance_status.dart';

abstract class AttendanceRepository {
  Future<List<Attendance>> getAttendances({AttendanceStatus? statusFilter});
  Future<Attendance?> getAttendanceById(int id);
  Future<int> createAttendance(Attendance attendance);
  Future<void> updateAttendance(Attendance attendance);
  Future<void> deleteAttendance(int id);
  Future<void> toggleAttendanceStatus(int id, bool isActive);
}
