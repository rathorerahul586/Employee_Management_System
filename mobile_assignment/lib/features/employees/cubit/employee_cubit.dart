import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import '../data/employee_model.dart';
import '../data/employee_repository.dart';

class EmployeeCubit extends Cubit<EmployeeState> {
  final EmployeeRepository repository;

  EmployeeCubit({required this.repository}) : super(EmployeeInitial());

  Future<void> fetchDepartments() async {
    emit(EmployeeLoading());
    try {
      final data = await repository.getDepartments();
      emit(EmployeeLoaded(data));
    } catch (e) {
      emit(EmployeeError("Failed to fetch data: $e"));
    }
  }
}

abstract class EmployeeState extends Equatable {
  const EmployeeState();

  @override
  List<Object> get props => [];
}

class EmployeeInitial extends EmployeeState {}

class EmployeeLoading extends EmployeeState {}

class EmployeeLoaded extends EmployeeState {
  final List<Department> departments;

  const EmployeeLoaded(this.departments);

  @override
  List<Object> get props => [departments];
}

class EmployeeError extends EmployeeState {
  final String message;

  const EmployeeError(this.message);
}
