import 'dart:developer';

import 'package:bloc_tiberiu/logic/internet/internet_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../constants/enums.dart';
import '../../logic/cubit/counter/counter_cubit.dart';
import '../../logic/cubit/counter/counter_state.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({
    Key? key,
    required this.title,
    required this.color,
  }) : super(key: key);

  final String title;
  final Color color;

  @override
  HomeScreenState createState() => HomeScreenState();
}

class HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
    log('Sunt in pagina nr 1');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: widget.color,
        title: Text(widget.title),
        actions: [
          IconButton(
            onPressed: (() {
              Navigator.of(context).pushNamed('/settings-page');
            }),
            icon: const Icon(
              Icons.settings,
            ),
          )
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Builder(builder: (context) {
              final counterBlocaValue = context.select(
                (CounterCubit counterCubit) => counterCubit.state.counterValue,
              );
              return Text(
                '$counterBlocaValue',
                style: Theme.of(context).textTheme.bodyText1,
              );
            }),

            // Builder(builder: (context) {
            //   final counterState = context.watch<CounterCubit>();
            //   final internetState = context.watch<InternetCubit>();
            //   return Text(
            //     'Counter : ${counterState.state} ' '\nInternet : ${internetState.state}',
            //     style: Theme.of(context).textTheme.headline5,
            //   );
            // }),
            BlocConsumer<InternetCubit, InternetState>(
              listener: (context, state) {
                if (state is InternetConnected && state.connectionType == ConnectionType.wifi) {
                  ScaffoldMessenger.of(context).removeCurrentSnackBar();
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('WI-FI'),
                    ),
                  );
                } else if (state is InternetConnected && state.connectionType == ConnectionType.mobile) {
                  ScaffoldMessenger.of(context).removeCurrentSnackBar();
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Mobile'),
                    ),
                  );
                } else if (state is InternetDisconnected) {
                  ScaffoldMessenger.of(context).removeCurrentSnackBar();
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Disconnected'),
                    ),
                  );
                }
              },
              builder: (context, state) {
                if (state is InternetConnected && state.connectionType == ConnectionType.wifi) {
                  return const Text('WI-FI');
                } else if (state is InternetConnected && state.connectionType == ConnectionType.mobile) {
                  return const Text('MOBILE');
                } else if (state is InternetDisconnected) {
                  return const Text('DISCONNECTED');
                }
                return const Text(
                  'Nimic',
                );
              },
            ),
            BlocConsumer<CounterCubit, CounterState>(
              listener: (context, state) {
                if (state.wasIncremented == true) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Incremented!'),
                      duration: Duration(milliseconds: 300),
                    ),
                  );
                } else if (state.wasIncremented == false) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Decremented!'),
                      duration: Duration(milliseconds: 300),
                    ),
                  );
                }
              },
              builder: (context, state) {
                if (state.counterValue < 0) {
                  return Text(
                    'BRR, NEGATIVE ${state.counterValue}',
                    style: Theme.of(context).textTheme.headline4,
                  );
                } else if (state.counterValue % 2 == 0) {
                  return Text(
                    'YAAAY ${state.counterValue}',
                    style: Theme.of(context).textTheme.headline4,
                  );
                } else if (state.counterValue == 5) {
                  return Text(
                    'HMM, NUMBER 5',
                    style: Theme.of(context).textTheme.headline4,
                  );
                } else {
                  return Text(
                    state.counterValue.toString(),
                    style: Theme.of(context).textTheme.headline4,
                  );
                }
              },
            ),
            const SizedBox(
              height: 24,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                FloatingActionButton(
                  heroTag: Text(widget.title),
                  onPressed: () {
                    BlocProvider.of<CounterCubit>(context).decrement();
                  },
                  tooltip: 'Decrement',
                  child: const Icon(Icons.remove),
                ),
                FloatingActionButton(
                  heroTag: Text('${widget.title} 2nd'),
                  onPressed: () {
                    BlocProvider.of<CounterCubit>(context).increment();
                  },
                  tooltip: 'Increment',
                  child: const Icon(Icons.add),
                ),
              ],
            ),
            const SizedBox(
              height: 24,
            ),
            MaterialButton(
              color: Colors.redAccent,
              child: const Text(
                'Go to Second Screen',
                style: TextStyle(color: Colors.white),
              ),
              onPressed: () {
                log('Spre 2');
                Navigator.of(context).pushNamed(
                  '/second',
                );
              },
            ),
            const SizedBox(
              height: 24,
            ),
            MaterialButton(
              color: Colors.greenAccent,
              child: const Text(
                'Go to Third Screen',
                style: TextStyle(color: Colors.white),
              ),
              onPressed: () {
                log('Spre 3');
                Navigator.of(context).pushNamed(
                  '/third',
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
