import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../core/injection/injection.dart';
import '../../domain/entities/attendance_status.dart';
import '../cubits/attendance_list/attendance_list_cubit.dart';
import '../cubits/attendance_list/attendance_list_state.dart';
import '../widgets/attendance_card.dart';
import '../widgets/status_filter_chip.dart';
import 'attendance_form_screen.dart';
import 'attendance_execution_screen.dart';

class AttendanceListScreen extends StatelessWidget {
  const AttendanceListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => getIt<AttendanceListCubit>()..loadAttendances(),
      child: const AttendanceListView(),
    );
  }
}

class AttendanceListView extends StatelessWidget {
  const AttendanceListView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Gestão de Atendimentos'),
        backgroundColor: Theme.of(context).colorScheme.primaryContainer,
      ),
      body: Column(
        children: [
          _buildFilterChips(context),
          Expanded(child: _buildAttendanceList()),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _navigateToForm(context),
        child: const Icon(Icons.add),
      ),
    );
  }

  Widget _buildFilterChips(BuildContext context) {
    return BlocBuilder<AttendanceListCubit, AttendanceListState>(
      builder: (context, state) {
        final currentFilter =
            state is AttendanceListLoaded ? state.currentFilter : null;

        return SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          padding: const EdgeInsets.all(16),
          child: Row(
            children: [
              StatusFilterChip(
                label: 'Todos',
                isSelected: currentFilter == null,
                onTap: () =>
                    context.read<AttendanceListCubit>().loadAttendances(),
              ),
              const SizedBox(width: 8),
              StatusFilterChip(
                label: AttendanceStatus.pending.displayName,
                isSelected: currentFilter == AttendanceStatus.pending,
                onTap: () => context
                    .read<AttendanceListCubit>()
                    .loadAttendances(statusFilter: AttendanceStatus.pending),
              ),
              const SizedBox(width: 8),
              StatusFilterChip(
                label: AttendanceStatus.inProgress.displayName,
                isSelected: currentFilter == AttendanceStatus.inProgress,
                onTap: () => context
                    .read<AttendanceListCubit>()
                    .loadAttendances(statusFilter: AttendanceStatus.inProgress),
              ),
              const SizedBox(width: 8),
              StatusFilterChip(
                label: AttendanceStatus.finished.displayName,
                isSelected: currentFilter == AttendanceStatus.finished,
                onTap: () => context
                    .read<AttendanceListCubit>()
                    .loadAttendances(statusFilter: AttendanceStatus.finished),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildAttendanceList() {
    return BlocBuilder<AttendanceListCubit, AttendanceListState>(
      builder: (context, state) {
        if (state is AttendanceListLoading) {
          return const Center(child: CircularProgressIndicator());
        }

        if (state is AttendanceListError) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(Icons.error_outline, size: 64, color: Colors.red),
                const SizedBox(height: 16),
                Text(state.message, textAlign: TextAlign.center),
                const SizedBox(height: 16),
                ElevatedButton(
                  onPressed: () =>
                      context.read<AttendanceListCubit>().loadAttendances(),
                  child: const Text('Tentar Novamente'),
                ),
              ],
            ),
          );
        }

        if (state is AttendanceListLoaded) {
          if (state.attendances.isEmpty) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.inbox_outlined, size: 64, color: Colors.grey[400]),
                  const SizedBox(height: 16),
                  Text(
                    'Nenhum atendimento encontrado',
                    style: TextStyle(color: Colors.grey[600]),
                  ),
                ],
              ),
            );
          }

          return ListView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: state.attendances.length,
            itemBuilder: (context, index) {
              final attendance = state.attendances[index];
              return AttendanceCard(
                attendance: attendance,
                onTap: () => _navigateToExecution(context, attendance.id!),
                onEdit: () =>
                    _navigateToForm(context, attendanceId: attendance.id),
                onDelete: () => _showDeleteDialog(context, attendance.id!),
                onToggleStatus: (isActive) => context
                    .read<AttendanceListCubit>()
                    .toggleAttendanceStatus(attendance.id!, isActive),
              );
            },
          );
        }

        return const SizedBox.shrink();
      },
    );
  }

  Future<void> _navigateToForm(BuildContext context,
      {int? attendanceId}) async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => AttendanceFormScreen(attendanceId: attendanceId),
      ),
    );

    if (result == true && context.mounted) {
      context.read<AttendanceListCubit>().loadAttendances();
    }
  }

  Future<void> _navigateToExecution(
      BuildContext context, int attendanceId) async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => AttendanceExecutionScreen(attendanceId: attendanceId),
      ),
    );

    if (result == true && context.mounted) {
      context.read<AttendanceListCubit>().loadAttendances();
    }
  }

  Future<void> _showDeleteDialog(BuildContext context, int attendanceId) async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Excluir Atendimento'),
        content: const Text('Deseja realmente excluir este atendimento?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text('Cancelar'),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context, true),
            style: TextButton.styleFrom(foregroundColor: Colors.red),
            child: const Text('Excluir'),
          ),
        ],
      ),
    );

    if (confirmed == true && context.mounted) {
      context.read<AttendanceListCubit>().deleteAttendance(attendanceId);
    }
  }
}
