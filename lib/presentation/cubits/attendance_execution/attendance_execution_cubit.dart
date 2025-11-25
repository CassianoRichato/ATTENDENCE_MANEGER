import 'dart:io';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:image_picker/image_picker.dart';
import '../../../domain/entities/attendance.dart';
import '../../../domain/usecases/get_attendance_by_id_usecase.dart';
import '../../../domain/usecases/finish_attendance_usecase.dart';
import '../../../data/datasources/image_storage_service.dart';
import 'attendance_execution_state.dart';

@injectable
class AttendanceExecutionCubit extends Cubit<AttendanceExecutionState> {
  final GetAttendanceByIdUseCase _getAttendanceByIdUseCase;
  final FinishAttendanceUseCase _finishAttendanceUseCase;
  final ImageStorageService _imageStorageService;
  final ImagePicker _imagePicker = ImagePicker();

  AttendanceExecutionCubit(
    this._getAttendanceByIdUseCase,
    this._finishAttendanceUseCase,
    this._imageStorageService,
  ) : super(AttendanceExecutionInitial());

  Future<void> loadAttendance(int id) async {
    try {
      emit(AttendanceExecutionLoading());
      final attendance = await _getAttendanceByIdUseCase(id);
      if (attendance != null) {
        emit(AttendanceExecutionLoaded(attendance));
      } else {
        emit(AttendanceExecutionError('Atendimento não encontrado'));
      }
    } catch (e) {
      emit(AttendanceExecutionError('Erro ao carregar atendimento: $e'));
    }
  }

  Future<void> captureImage() async {
    try {
      final currentState = state;
      if (currentState is! AttendanceExecutionLoaded) return;

      final XFile? image = await _imagePicker.pickImage(
        source: ImageSource.camera,
        maxWidth: 1920,
        maxHeight: 1080,
        imageQuality: 85,
      );

      if (image != null) {
        final imagePath =
            await _imageStorageService.saveImage(File(image.path));
        emit(AttendanceExecutionLoaded(
          currentState.attendance,
          capturedImagePath: imagePath,
        ));
      }
    } catch (e) {
      emit(AttendanceExecutionError('Erro ao capturar imagem: $e'));
    }
  }

  Future<void> pickImageFromGallery() async {
    try {
      final currentState = state;
      if (currentState is! AttendanceExecutionLoaded) return;

      final XFile? image = await _imagePicker.pickImage(
        source: ImageSource.gallery,
        maxWidth: 1920,
        maxHeight: 1080,
        imageQuality: 85,
      );

      if (image != null) {
        final imagePath =
            await _imageStorageService.saveImage(File(image.path));
        emit(AttendanceExecutionLoaded(
          currentState.attendance,
          capturedImagePath: imagePath,
        ));
      }
    } catch (e) {
      emit(AttendanceExecutionError('Erro ao selecionar imagem: $e'));
    }
  }

  Future<void> finishAttendance(String? observations) async {
    try {
      final currentState = state;
      if (currentState is! AttendanceExecutionLoaded) return;

      emit(AttendanceExecutionLoading());

      await _finishAttendanceUseCase(
        currentState.attendance,
        currentState.capturedImagePath,
        observations,
      );

      emit(AttendanceExecutionSuccess());
    } catch (e) {
      emit(AttendanceExecutionError('Erro ao finalizar atendimento: $e'));
    }
  }
}
