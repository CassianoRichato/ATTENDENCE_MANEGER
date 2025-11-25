import 'package:equatable/equatable.dart';
import '../../../domain/entities/attendance.dart';

abstract class AttendanceExecutionState extends Equatable {
  @override
  List<Object?> get props => [];
}

class AttendanceExecutionInitial extends AttendanceExecutionState {}

class AttendanceExecutionLoading extends AttendanceExecutionState {}

class AttendanceExecutionLoaded extends AttendanceExecutionState {
  final Attendance attendance;
  final String? capturedImagePath;
  final String? observations;

  AttendanceExecutionLoaded(
    this.attendance, {
    this.capturedImagePath,
    this.observations,
  });

  @override
  List<Object?> get props => [attendance, capturedImagePath, observations];
}

class AttendanceExecutionSuccess extends AttendanceExecutionState {}

class AttendanceExecutionError extends AttendanceExecutionState {
  final String message;

  AttendanceExecutionError(this.message);

  @override
  List<Object?> get props => [message];
}
