import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../domain/entities/attendance.dart';
import '../../domain/entities/attendance_status.dart';

class AttendanceCard extends StatelessWidget {
  final Attendance attendance;
  final VoidCallback onTap;
  final VoidCallback onEdit;
  final VoidCallback onDelete;
  final Function(bool) onToggleStatus;

  const AttendanceCard({
    super.key,
    required this.attendance,
    required this.onTap,
    required this.onEdit,
    required this.onDelete,
    required this.onToggleStatus,
  });

  @override
  Widget build(BuildContext context) {
    final dateFormat = DateFormat('dd/MM/yyyy HH:mm');

    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Expanded(
                    child: Text(
                      attendance.title,
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                    ),
                  ),
                  _buildStatusChip(context),
                ],
              ),
              if (attendance.description != null) ...[
                const SizedBox(height: 8),
                Text(
                  attendance.description!,
                  style: Theme.of(context).textTheme.bodyMedium,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
              const SizedBox(height: 12),
              Row(
                children: [
                  Icon(Icons.calendar_today, size: 16, color: Colors.grey[600]),
                  const SizedBox(width: 4),
                  Text(
                    dateFormat.format(attendance.createdAt),
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
                  const Spacer(),
                  _buildActionButtons(context),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildStatusChip(BuildContext context) {
    Color backgroundColor;
    Color textColor;

    switch (attendance.status) {
      case AttendanceStatus.pending:
        backgroundColor = Colors.orange[100]!;
        textColor = Colors.orange[900]!;
        break;
      case AttendanceStatus.inProgress:
        backgroundColor = Colors.blue[100]!;
        textColor = Colors.blue[900]!;
        break;
      case AttendanceStatus.finished:
        backgroundColor = Colors.green[100]!;
        textColor = Colors.green[900]!;
        break;
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Text(
        attendance.status.displayName,
        style: TextStyle(
          color: textColor,
          fontSize: 12,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  Widget _buildActionButtons(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        IconButton(
          icon: const Icon(Icons.edit_outlined),
          iconSize: 20,
          onPressed: onEdit,
          tooltip: 'Editar',
        ),
        IconButton(
          icon: const Icon(Icons.delete_outline),
          iconSize: 20,
          color: Colors.red,
          onPressed: onDelete,
          tooltip: 'Excluir',
        ),
        Switch(
          value: attendance.isActive,
          onChanged: onToggleStatus,
          materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
        ),
      ],
    );
  }
}
