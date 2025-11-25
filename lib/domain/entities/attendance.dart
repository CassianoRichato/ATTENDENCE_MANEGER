import 'package:equatable/equatable.dart';
import 'attendance_status.dart';

class Attendance extends Equatable {
  final int? id;
  final String title;
  final String? description;
  final AttendanceStatus status;
  final DateTime createdAt;
  final DateTime? updatedAt;
  final DateTime? finishedAt;
  final String? imagePath;
  final String? observations;
  final bool isActive;

  const Attendance({
    this.id,
    required this.title,
    this.description,
    required this.status,
    required this.createdAt,
    this.updatedAt,
    this.finishedAt,
    this.imagePath,
    this.observations,
    this.isActive = true,
  });

  Attendance copyWith({
    int? id,
    String? title,
    String? description,
    AttendanceStatus? status,
    DateTime? createdAt,
    DateTime? updatedAt,
    DateTime? finishedAt,
    String? imagePath,
    String? observations,
    bool? isActive,
  }) {
    return Attendance(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      status: status ?? this.status,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      finishedAt: finishedAt ?? this.finishedAt,
      imagePath: imagePath ?? this.imagePath,
      observations: observations ?? this.observations,
      isActive: isActive ?? this.isActive,
    );
  }

  @override
  List<Object?> get props => [
        id,
        title,
        description,
        status,
        createdAt,
        updatedAt,
        finishedAt,
        imagePath,
        observations,
        isActive,
      ];
}
