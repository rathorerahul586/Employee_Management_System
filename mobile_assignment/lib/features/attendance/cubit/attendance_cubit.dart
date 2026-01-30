import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AttendanceCubit extends Cubit<AttendanceCubitState> {
  AttendanceCubit() : super(AttendanceCubitState(currentTime: DateTime.now())) {
    _startTimer();
  }

  Timer? _timer;

  void _startTimer() {
    // Update time every minute
    _timer = Timer.periodic(
      const Duration(minutes: 1),
      (timer) => emit(state.updateCurrentTime()),
    );
  }

  void punchInOut() {
    if (state.checkinsTime == null) {
      emit(state.copyWith(checkinsTime: DateTime.now()));
      return;
    }
    if (state.checkoutTime == null) {
      emit(state.copyWith(checkoutTime: DateTime.now()));
      return;
    }
    emit(AttendanceCubitState(currentTime: DateTime.now()));
  }

  Duration workingTime() {
    if (state.checkinsTime == null || state.checkoutTime == null) {
      return Duration.zero;
    }

    return state.checkoutTime!.difference(state.checkinsTime!);
  }

  @override
  Future<void> close() {
    _timer?.cancel();
    return super.close();
  }
}

// State
class AttendanceCubitState extends Equatable {
  final DateTime currentTime;
  final DateTime? checkinsTime;
  final DateTime? checkoutTime;

  const AttendanceCubitState({
    required this.currentTime,
    this.checkinsTime,
    this.checkoutTime,
  });

  @override
  List<Object?> get props => [currentTime, checkinsTime, checkoutTime];

  AttendanceCubitState copyWith({
    DateTime? checkinsTime,
    DateTime? checkoutTime,
  }) {
    return AttendanceCubitState(
      currentTime: DateTime.now(),
      checkinsTime: checkinsTime ?? this.checkinsTime,
      checkoutTime: checkoutTime ?? this.checkoutTime,
    );
  }

  AttendanceCubitState updateCurrentTime() {
    return AttendanceCubitState(
      currentTime: DateTime.now(),
      checkinsTime: checkinsTime,
      checkoutTime: checkoutTime,
    );
  }
}
