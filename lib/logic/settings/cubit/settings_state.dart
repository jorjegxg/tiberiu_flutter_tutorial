part of 'settings_cubit.dart';

class SettingsState extends Equatable {
  SettingsState({
    required this.appNotifications,
    required this.emailNotifications,
  });

  bool appNotifications;
  bool emailNotifications;

  SettingsState copyWith({
    bool? appNotifications,
    bool? emailNotifications,
  }) {
    return SettingsState(
      appNotifications: appNotifications ?? this.appNotifications,
      emailNotifications: emailNotifications ?? this.emailNotifications,
    );
  }

  @override
  List<Object> get props => [appNotifications, emailNotifications];

  @override
  String toString() => 'SettingsState(appNotifications: $appNotifications,'
      ' emailNotifications: $emailNotifications)';
}
