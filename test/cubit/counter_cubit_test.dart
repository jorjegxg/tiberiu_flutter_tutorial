import 'package:bloc_test/bloc_test.dart';
import 'package:bloc_tiberiu/logic/cubit/counter_cubit.dart';
import 'package:bloc_tiberiu/logic/cubit/internet_cubit.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:test/expect.dart';
import 'package:test/scaffolding.dart';

void main() {
  group('CounterCubit', () {
    late CounterCubit counterCubit;

    setUp(() {
      counterCubit = CounterCubit(internetCubit: InternetCubit(connectivity: Connectivity()));
    });

    tearDown(() {
      counterCubit.close();
    });

    test('Initial value e 0', () {
      expect(
          counterCubit.state,
          CounterState(
            counterValue: 0,
            wasIncremented: false,
          ));
    });

    blocTest(
      'Ar trebui sa imi apara 1 si true dupa ce dau increment',
      build: () => counterCubit,
      act: (cubit) => cubit.increment(),
      expect: () => [
        CounterState(counterValue: 1, wasIncremented: true),
      ],
    );

    blocTest(
      'Ar trebui sa imi apara -1 si false dupa ce dau increment',
      build: () => counterCubit,
      act: (cubit) => cubit.decrement(),
      expect: () => [
        CounterState(counterValue: -1, wasIncremented: false),
      ],
    );
  });
}
