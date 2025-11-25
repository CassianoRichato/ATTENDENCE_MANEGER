enum AttendanceStatus {
  pending,
  inProgress,
  finished;

  String get displayName {
    switch (this) {
      case AttendanceStatus.pending:
        return 'Pendente';
      case AttendanceStatus.inProgress:
        return 'Em Andamento';
      case AttendanceStatus.finished:
        return 'Finalizado';
    }
  }
}
