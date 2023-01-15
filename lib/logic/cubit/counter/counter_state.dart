// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:equatable/equatable.dart';

class CounterState extends Equatable {
  final int counterValue;
  final bool wasIncremented;

  const CounterState({
    required this.counterValue,
    required this.wasIncremented,
  });

  @override
  List<Object?> get props => [counterValue, wasIncremented];

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'counterValue': counterValue,
      'wasIncremented': wasIncremented,
    };
  }

  factory CounterState.fromMap(Map<String, dynamic> map) {
    return CounterState(
      counterValue: map['counterValue'] as int,
      wasIncremented: map['wasIncremented'] as bool,
    );
  }

  @override
  String toString() {
    return 'CounterState($counterValue,$wasIncremented)';
  }
}
