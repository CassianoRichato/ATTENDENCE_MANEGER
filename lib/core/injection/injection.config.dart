// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format width=80

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:attendance_manager/core/injection/injection_module.dart'
    as _i95;
import 'package:attendance_manager/data/datasources/database_helper.dart'
    as _i142;
import 'package:attendance_manager/data/datasources/image_storage_service.dart'
    as _i330;
import 'package:attendance_manager/data/datasources/local_data_source.dart'
    as _i10;
import 'package:attendance_manager/data/repositories/attendance_repository_impl.dart'
    as _i53;
import 'package:attendance_manager/domain/repositories/attendance_repository.dart'
    as _i227;
import 'package:attendance_manager/domain/usecases/create_attendance_usecase.dart'
    as _i380;
import 'package:attendance_manager/domain/usecases/delete_attendance_usecase.dart'
    as _i908;
import 'package:attendance_manager/domain/usecases/finish_attendance_usecase.dart'
    as _i621;
import 'package:attendance_manager/domain/usecases/get_attendance_by_id_usecase.dart'
    as _i606;
import 'package:attendance_manager/domain/usecases/get_attendances_usecase.dart'
    as _i375;
import 'package:attendance_manager/domain/usecases/start_attendance_usecase.dart'
    as _i618;
import 'package:attendance_manager/domain/usecases/toggle_attendance_status_usecase.dart'
    as _i483;
import 'package:attendance_manager/domain/usecases/update_attendance_usecase.dart'
    as _i272;
import 'package:attendance_manager/presentation/cubits/attendance_execution/attendance_execution_cubit.dart'
    as _i111;
import 'package:attendance_manager/presentation/cubits/attendance_form/attendance_form_cubit.dart'
    as _i282;
import 'package:attendance_manager/presentation/cubits/attendance_list/attendance_list_cubit.dart'
    as _i270;
import 'package:get_it/get_it.dart' as _i174;
import 'package:injectable/injectable.dart' as _i526;

extension GetItInjectableX on _i174.GetIt {
// initializes the registration of main-scope dependencies inside of GetIt
  _i174.GetIt init({
    String? environment,
    _i526.EnvironmentFilter? environmentFilter,
  }) {
    final gh = _i526.GetItHelper(
      this,
      environment,
      environmentFilter,
    );
    final injectionModule = _$InjectionModule();
    gh.factory<_i330.ImageStorageService>(() => _i330.ImageStorageService());
    gh.singleton<_i142.DatabaseHelper>(() => injectionModule.databaseHelper);
    gh.factory<_i10.LocalDataSource>(
        () => _i10.LocalDataSource(gh<_i142.DatabaseHelper>()));
    gh.factory<_i227.AttendanceRepository>(
        () => _i53.AttendanceRepositoryImpl(gh<_i10.LocalDataSource>()));
    gh.factory<_i380.CreateAttendanceUseCase>(
        () => _i380.CreateAttendanceUseCase(gh<_i227.AttendanceRepository>()));
    gh.factory<_i908.DeleteAttendanceUseCase>(
        () => _i908.DeleteAttendanceUseCase(gh<_i227.AttendanceRepository>()));
    gh.factory<_i621.FinishAttendanceUseCase>(
        () => _i621.FinishAttendanceUseCase(gh<_i227.AttendanceRepository>()));
    gh.factory<_i606.GetAttendanceByIdUseCase>(
        () => _i606.GetAttendanceByIdUseCase(gh<_i227.AttendanceRepository>()));
    gh.factory<_i375.GetAttendancesUseCase>(
        () => _i375.GetAttendancesUseCase(gh<_i227.AttendanceRepository>()));
    gh.factory<_i618.StartAttendanceUseCase>(
        () => _i618.StartAttendanceUseCase(gh<_i227.AttendanceRepository>()));
    gh.factory<_i483.ToggleAttendanceStatusUseCase>(() =>
        _i483.ToggleAttendanceStatusUseCase(gh<_i227.AttendanceRepository>()));
    gh.factory<_i272.UpdateAttendanceUseCase>(
        () => _i272.UpdateAttendanceUseCase(gh<_i227.AttendanceRepository>()));
    gh.factory<_i270.AttendanceListCubit>(() => _i270.AttendanceListCubit(
          gh<_i375.GetAttendancesUseCase>(),
          gh<_i908.DeleteAttendanceUseCase>(),
          gh<_i483.ToggleAttendanceStatusUseCase>(),
        ));
    gh.factory<_i111.AttendanceExecutionCubit>(
        () => _i111.AttendanceExecutionCubit(
              gh<_i606.GetAttendanceByIdUseCase>(),
              gh<_i621.FinishAttendanceUseCase>(),
              gh<_i618.StartAttendanceUseCase>(),
              gh<_i330.ImageStorageService>(),
            ));
    gh.factory<_i282.AttendanceFormCubit>(() => _i282.AttendanceFormCubit(
          gh<_i380.CreateAttendanceUseCase>(),
          gh<_i272.UpdateAttendanceUseCase>(),
          gh<_i606.GetAttendanceByIdUseCase>(),
        ));
    return this;
  }
}

class _$InjectionModule extends _i95.InjectionModule {}
