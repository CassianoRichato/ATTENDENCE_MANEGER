import 'package:injectable/injectable.dart';
import 'package:sqflite/sqflite.dart';
import '../models/attendance_model.dart';
import 'database_helper.dart';
import '../../domain/entities/attendance_status.dart';

@injectable
class LocalDataSource {
  final DatabaseHelper _dbHelper;

  LocalDataSource(this._dbHelper);

  Future<List<AttendanceModel>> getAttendances(
      {AttendanceStatus? statusFilter}) async {
    final db = await _dbHelper.database;

    String? whereClause;
    List<dynamic>? whereArgs;

    if (statusFilter != null) {
      whereClause = 'status = ?';
      whereArgs = [statusFilter.name];
    }

    final maps = await db.query(
      DatabaseHelper.tableAttendances,
      where: whereClause,
      whereArgs: whereArgs,
      orderBy: 'created_at DESC',
    );

    return maps.map((map) => AttendanceModel.fromMap(map)).toList();
  }

  Future<AttendanceModel?> getAttendanceById(int id) async {
    final db = await _dbHelper.database;

    final maps = await db.query(
      DatabaseHelper.tableAttendances,
      where: 'id = ?',
      whereArgs: [id],
      limit: 1,
    );

    if (maps.isEmpty) return null;
    return AttendanceModel.fromMap(maps.first);
  }

  Future<int> insertAttendance(AttendanceModel attendance) async {
    final db = await _dbHelper.database;
    return await db.insert(
      DatabaseHelper.tableAttendances,
      attendance.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<void> updateAttendance(AttendanceModel attendance) async {
    final db = await _dbHelper.database;
    await db.update(
      DatabaseHelper.tableAttendances,
      attendance.toMap(),
      where: 'id = ?',
      whereArgs: [attendance.id],
    );
  }

  Future<void> deleteAttendance(int id) async {
    final db = await _dbHelper.database;
    await db.update(
      DatabaseHelper.tableAttendances,
      {'is_active': 0},
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  Future<void> toggleAttendanceStatus(int id, bool isActive) async {
    final db = await _dbHelper.database;
    await db.update(
      DatabaseHelper.tableAttendances,
      {'is_active': isActive ? 1 : 0},
      where: 'id = ?',
      whereArgs: [id],
    );
  }
}
