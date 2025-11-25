import '../../domain/entities/attendance.dart';
import '../../domain/entities/attendance_status.dart';

class AttendanceModel extends Attendance {
  const AttendanceModel({
    super.id,
    required super.title,
    super.description,
    required super.status,
    required super.createdAt,
    super.updatedAt,
    super.finishedAt,
    super.imagePath,
    super.observations,
    super.isActive = true,
  });

  factory AttendanceModel.fromMap(Map<String, dynamic> map) {
    return AttendanceModel(
      id: map['id'] as int?,
      title: map['title'] as String,
      description: map['description'] as String?,
      status: AttendanceStatus.values.firstWhere(
        (e) => e.name == map['status'],
        orElse: () => AttendanceStatus.pending,
      ),
      createdAt: DateTime.parse(map['created_at'] as String),
      updatedAt: map['updated_at'] != null
          ? DateTime.parse(map['updated_at'] as String)
          : null,
      finishedAt: map['finished_at'] != null
          ? DateTime.parse(map['finished_at'] as String)
          : null,
      imagePath: map['image_path'] as String?,
      observations: map['observations'] as String?,
      isActive: map['is_active'] == 1,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'status': status.name,
      'created_at': createdAt.toIso8601String(),
      'updated_at': updatedAt?.toIso8601String(),
      'finished_at': finishedAt?.toIso8601String(),
      'image_path': imagePath,
      'observations': observations,
      'is_active': isActive ? 1 : 0,
    };
  }

  factory AttendanceModel.fromEntity(Attendance attendance) {
    return AttendanceModel(
      id: attendance.id,
      title: attendance.title,
      description: attendance.description,
      status: attendance.status,
      createdAt: attendance.createdAt,
      updatedAt: attendance.updatedAt,
      finishedAt: attendance.finishedAt,
      imagePath: attendance.imagePath,
      observations: attendance.observations,
      isActive: attendance.isActive,
    );
  }
}
