import 'package:equatable/equatable.dart';
import '../../../domain/entities/attendance.dart';
import '../../../domain/entities/attendance_status.dart';

abstract class AttendanceListState extends Equatable {
  @override
  List<Object?> get props => [];
}

class AttendanceListInitial extends AttendanceListState {}

class AttendanceListLoading extends AttendanceListState {}

class AttendanceListLoaded extends AttendanceListState {
  final List<Attendance> attendances;
  final AttendanceStatus? currentFilter;

  AttendanceListLoaded(this.attendances, {this.currentFilter});

  @override
  List<Object?> get props => [attendances, currentFilter];
}

class AttendanceListError extends AttendanceListState {
  final String message;

  AttendanceListError(this.message);

  @override
  List<Object?> get props => [message];
}
