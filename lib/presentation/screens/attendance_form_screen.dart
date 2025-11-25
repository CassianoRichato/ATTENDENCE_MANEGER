import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../core/injection/injection.dart';
import '../cubits/attendance_form/attendance_form_cubit.dart';
import '../cubits/attendance_form/attendance_form_state.dart';

class AttendanceFormScreen extends StatefulWidget {
  final int? attendanceId;

  const AttendanceFormScreen({super.key, this.attendanceId});

  @override
  State<AttendanceFormScreen> createState() => _AttendanceFormScreenState();
}

class _AttendanceFormScreenState extends State<AttendanceFormScreen> {
  final _formKey = GlobalKey<FormState>();
  final _titleController = TextEditingController();
  final _descriptionController = TextEditingController();

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) {
        final cubit = getIt<AttendanceFormCubit>();
        if (widget.attendanceId != null) {
          cubit.loadAttendance(widget.attendanceId!);
        }
        return cubit;
      },
      child: BlocConsumer<AttendanceFormCubit, AttendanceFormState>(
        listener: (context, state) {
          if (state is AttendanceFormSuccess) {
            if (widget.attendanceId == null) {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Atendimento salvo com sucesso!')),
              );
              Navigator.pop(context, true);
            } else {
              _titleController.text = state.attendance.title;
              _descriptionController.text = state.attendance.description ?? '';
            }
          } else if (state is AttendanceFormError) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(state.message)),
            );
          }
        },
        builder: (context, state) {
          if (state is AttendanceFormLoading && widget.attendanceId != null) {
            return const Scaffold(
              body: Center(child: CircularProgressIndicator()),
            );
          }

          return Scaffold(
            appBar: AppBar(
              title: Text(widget.attendanceId == null
                  ? 'Novo Atendimento'
                  : 'Editar Atendimento'),
              backgroundColor: Theme.of(context).colorScheme.primaryContainer,
            ),
            body: Form(
              key: _formKey,
              child: ListView(
                padding: const EdgeInsets.all(16),
                children: [
                  TextFormField(
                    controller: _titleController,
                    decoration: const InputDecoration(
                      labelText: 'Título',
                      border: OutlineInputBorder(),
                      prefixIcon: Icon(Icons.title),
                    ),
                    validator: (value) {
                      if (value == null || value.trim().isEmpty) {
                        return 'Por favor, insira um título';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 16),
                  TextFormField(
                    controller: _descriptionController,
                    decoration: const InputDecoration(
                      labelText: 'Descrição',
                      border: OutlineInputBorder(),
                      prefixIcon: Icon(Icons.description),
                    ),
                    maxLines: 5,
                  ),
                  const SizedBox(height: 24),
                  ElevatedButton.icon(
                    onPressed: state is AttendanceFormLoading
                        ? null
                        : () => _saveAttendance(context),
                    icon: const Icon(Icons.save),
                    label: Text(state is AttendanceFormLoading
                        ? 'Salvando...'
                        : 'Salvar'),
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.all(16),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  void _saveAttendance(BuildContext context) {
    if (_formKey.currentState!.validate()) {
      context.read<AttendanceFormCubit>().saveAttendance(
            id: widget.attendanceId,
            title: _titleController.text.trim(),
            description: _descriptionController.text.trim().isEmpty
                ? null
                : _descriptionController.text.trim(),
          );
    }
  }
}
