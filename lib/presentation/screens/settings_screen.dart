import 'package:bloc_tiberiu/logic/settings/cubit/settings_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Settings',
        ),
      ),
      body: BlocConsumer<SettingsCubit, SettingsState>(
        listener: (context, state) {
          ScaffoldMessenger.of(context).removeCurrentSnackBar();
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(
                'APP : ${state.appNotifications.toString().toUpperCase()}'
                '\nEMAIL : ${state.emailNotifications.toString().toUpperCase()}',
              ),
            ),
          );
        },
        builder: (context, state) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SwitchListTile(
                title: const Text('App notifications'),
                value: state.appNotifications,
                onChanged: ((newValue) {
                  context.read<SettingsCubit>().toggleAppNotifications(newValue);
                }),
              ),
              SwitchListTile(
                title: const Text('Email notifications'),
                value: state.emailNotifications,
                onChanged: ((newValue) {
                  context.read<SettingsCubit>().toggleEmailNotifications(newValue);
                }),
              ),
            ],
          );
        },
      ),
    );
  }
}
