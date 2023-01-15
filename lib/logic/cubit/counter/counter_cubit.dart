import 'dart:async';

import 'package:bloc_tiberiu/logic/cubit/counter/counter_state.dart';
import 'package:bloc_tiberiu/logic/internet/internet_cubit.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';

class CounterCubit extends Cubit<CounterState> with HydratedMixin {
  InternetCubit internetCubit;
  late StreamSubscription internetStreamSubscription;

  CounterCubit({required this.internetCubit})
      : super(const CounterState(
          counterValue: 0,
          wasIncremented: false,
        ));

  void increment() => emit(CounterState(
        counterValue: state.counterValue + 1,
        wasIncremented: true,
      ));

  void decrement() => emit(CounterState(
        counterValue: state.counterValue - 1,
        wasIncremented: false,
      ));

  @override
  fromJson(Map<String, dynamic> json) {
    return CounterState.fromMap(json);
  }

  @override
  Map<String, dynamic> toJson(CounterState state) {
    return state.toMap();
  }
}
