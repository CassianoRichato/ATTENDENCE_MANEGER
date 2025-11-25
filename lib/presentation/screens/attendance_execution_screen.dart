import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import '../../core/injection/injection.dart';
import '../cubits/attendance_execution/attendance_execution_cubit.dart';
import '../cubits/attendance_execution/attendance_execution_state.dart';

class AttendanceExecutionScreen extends StatefulWidget {
  final int attendanceId;

  const AttendanceExecutionScreen({super.key, required this.attendanceId});

  @override
  State<AttendanceExecutionScreen> createState() =>
      _AttendanceExecutionScreenState();
}

class _AttendanceExecutionScreenState extends State<AttendanceExecutionScreen> {
  final _observationsController = TextEditingController();

  @override
  void dispose() {
    _observationsController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => getIt<AttendanceExecutionCubit>()
        ..loadAttendance(widget.attendanceId),
      child: BlocConsumer<AttendanceExecutionCubit, AttendanceExecutionState>(
        listener: (context, state) {
          if (state is AttendanceExecutionSuccess) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                  content: Text('Atendimento finalizado com sucesso!')),
            );
            Navigator.pop(context, true);
          } else if (state is AttendanceExecutionError) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.message),
                backgroundColor: Colors.red,
              ),
            );
          }
        },
        builder: (context, state) {
          if (state is AttendanceExecutionLoading) {
            return const Scaffold(
              body: Center(child: CircularProgressIndicator()),
            );
          }

          if (state is AttendanceExecutionLoaded) {
            return Scaffold(
              appBar: AppBar(
                title: const Text('Realizar Atendimento'),
                backgroundColor: Theme.of(context).colorScheme.primaryContainer,
              ),
              body: ListView(
                padding: const EdgeInsets.all(16),
                children: [
                  _buildAttendanceInfo(state),
                  const SizedBox(height: 24),
                  _buildImageSection(context, state),
                  const SizedBox(height: 24),
                  _buildObservationsSection(),
                  const SizedBox(height: 24),
                  _buildFinishButton(context, state),
                ],
              ),
            );
          }

          return const Scaffold(
            body: Center(child: Text('Erro ao carregar atendimento')),
          );
        },
      ),
    );
  }

  Widget _buildAttendanceInfo(AttendanceExecutionLoaded state) {
    final attendance = state.attendance;
    final dateFormat = DateFormat('dd/MM/yyyy HH:mm');

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(
                  Icons.assignment,
                  color: Theme.of(context).colorScheme.primary,
                  size: 32,
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        attendance.title,
                        style: Theme.of(context).textTheme.titleLarge?.copyWith(
                              fontWeight: FontWeight.bold,
                            ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        'Criado em: ${dateFormat.format(attendance.createdAt)}',
                        style: Theme.of(context).textTheme.bodySmall,
                      ),
                    ],
                  ),
                ),
              ],
            ),
            if (attendance.description != null) ...[
              const Divider(height: 24),
              Text(
                'Descrição',
                style: Theme.of(context).textTheme.titleSmall?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
              ),
              const SizedBox(height: 8),
              Text(attendance.description!),
            ],
            const Divider(height: 24),
            Row(
              children: [
                const Icon(Icons.flag, size: 20),
                const SizedBox(width: 8),
                Text(
                  'Status: ${attendance.status.displayName}',
                  style: Theme.of(context).textTheme.titleSmall,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildImageSection(
      BuildContext context, AttendanceExecutionLoaded state) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Foto do Atendimento',
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                ),
                if (state.capturedImagePath != null)
                  IconButton(
                    icon: const Icon(Icons.delete_outline, color: Colors.red),
                    onPressed: () => _removeImage(context),
                  ),
              ],
            ),
            const SizedBox(height: 16),
            if (state.capturedImagePath != null)
              ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: Image.file(
                  File(state.capturedImagePath!),
                  width: double.infinity,
                  height: 300,
                  fit: BoxFit.cover,
                ),
              )
            else
              Container(
                width: double.infinity,
                height: 200,
                decoration: BoxDecoration(
                  color: Colors.grey[200],
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: Colors.grey[400]!),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.image_outlined,
                        size: 64, color: Colors.grey[400]),
                    const SizedBox(height: 8),
                    Text(
                      'Nenhuma foto capturada',
                      style: TextStyle(color: Colors.grey[600]),
                    ),
                  ],
                ),
              ),
            const SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: OutlinedButton.icon(
                    onPressed: () =>
                        context.read<AttendanceExecutionCubit>().captureImage(),
                    icon: const Icon(Icons.camera_alt),
                    label: const Text('Tirar Foto'),
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: OutlinedButton.icon(
                    onPressed: () => context
                        .read<AttendanceExecutionCubit>()
                        .pickImageFromGallery(),
                    icon: const Icon(Icons.photo_library),
                    label: const Text('Galeria'),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildObservationsSection() {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Observações',
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
            ),
            const SizedBox(height: 16),
            TextFormField(
              controller: _observationsController,
              decoration: const InputDecoration(
                hintText: 'Adicione observações sobre o atendimento...',
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.note),
              ),
              maxLines: 6,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFinishButton(
      BuildContext context, AttendanceExecutionLoaded state) {
    final canFinish = state.capturedImagePath != null;

    return ElevatedButton.icon(
      onPressed: canFinish ? () => _finishAttendance(context) : null,
      icon: const Icon(Icons.check_circle),
      label: const Text('Finalizar Atendimento'),
      style: ElevatedButton.styleFrom(
        padding: const EdgeInsets.all(16),
        backgroundColor: canFinish ? Colors.green : null,
        foregroundColor: canFinish ? Colors.white : null,
      ),
    );
  }

  void _removeImage(BuildContext context) {
    final currentState = context.read<AttendanceExecutionCubit>().state;
    if (currentState is AttendanceExecutionLoaded) {
      context.read<AttendanceExecutionCubit>().emit(
            AttendanceExecutionLoaded(currentState.attendance),
          );
    }
  }

  Future<void> _finishAttendance(BuildContext context) async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Finalizar Atendimento'),
        content: const Text(
          'Deseja finalizar este atendimento? Esta ação não poderá ser desfeita.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text('Cancelar'),
          ),
          ElevatedButton(
            onPressed: () => Navigator.pop(context, true),
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.green,
              foregroundColor: Colors.white,
            ),
            child: const Text('Finalizar'),
          ),
        ],
      ),
    );

    if (confirmed == true && context.mounted) {
      final observations = _observationsController.text.trim().isEmpty
          ? null
          : _observationsController.text.trim();

      context.read<AttendanceExecutionCubit>().finishAttendance(observations);
    }
  }
}
