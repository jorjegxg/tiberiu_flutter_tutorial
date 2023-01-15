import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:bloc_tiberiu/constants/enums.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:equatable/equatable.dart';

part 'internet_state.dart';

class InternetCubit extends Cubit<InternetState> {
  final Connectivity connectivity;
  late StreamSubscription connectivityStreamSubscription;

  InternetCubit({required this.connectivity}) : super(InternetLoading()) {
     monitorInternetConnection();
  }

  void monitorInternetConnection() {
     connectivityStreamSubscription = connectivity.onConnectivityChanged.listen((
     ConnectivityResult connectivityResult,
        ) {
     if (connectivityResult == ConnectivityResult.wifi) {
       emitInternetConnected(ConnectionType.wifi);
     } else if (connectivityResult == ConnectivityResult.mobile) {
       emitInternetConnected(ConnectionType.mobile);
     } else if (connectivityResult == ConnectivityResult.none) {
       emitInternetDisonnected();
     }
        });
  }

  void emitInternetConnected(
    ConnectionType connectionType,
  ) =>
      emit(
        InternetConnected(
          connectionType: connectionType,
        ),
      );

  void emitInternetDisonnected() => emit(
        InternetDisconnected(),
      );
  @override
  Future<void> close() {
    connectivityStreamSubscription.cancel();
    return super.close();
  }
}
