import 'package:injectable/injectable.dart';
import '../../data/datasources/database_helper.dart';

@module
abstract class InjectionModule {
  @singleton
  DatabaseHelper get databaseHelper => DatabaseHelper.instance;
}
