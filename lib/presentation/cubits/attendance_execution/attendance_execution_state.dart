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

  AttendanceExecutionLoaded(this.attendance, {this.capturedImagePath});

  @override
  List<Object?> get props => [attendance, capturedImagePath];
}

class AttendanceExecutionSuccess extends AttendanceExecutionState {}

class AttendanceExecutionError extends AttendanceExecutionState {
  final String message;

  AttendanceExecutionError(this.message);

  @override
  List<Object?> get props => [message];
}
