import 'package:equatable/equatable.dart';
import '../../../domain/entities/attendance.dart';

abstract class AttendanceFormState extends Equatable {
  @override
  List<Object?> get props => [];
}

class AttendanceFormInitial extends AttendanceFormState {}

class AttendanceFormLoading extends AttendanceFormState {}

class AttendanceFormLoaded extends AttendanceFormState {
  final Attendance attendance;

  AttendanceFormLoaded(this.attendance);

  @override
  List<Object?> get props => [attendance];
}

class AttendanceFormSuccess extends AttendanceFormState {
  final Attendance attendance;

  AttendanceFormSuccess(this.attendance);

  @override
  List<Object?> get props => [attendance];
}

class AttendanceFormError extends AttendanceFormState {
  final String message;

  AttendanceFormError(this.message);

  @override
  List<Object?> get props => [message];
}
