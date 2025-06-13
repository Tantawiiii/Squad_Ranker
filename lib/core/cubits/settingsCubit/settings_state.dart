abstract class SettingsState {}

class SettingsInitial extends SettingsState {}

class SettingsNotificationPermissionGranted extends SettingsState {}

class SettingsPrivacyPolicyOpened extends SettingsState {}

class SettingsAppShared extends SettingsState {}

class SettingsError extends SettingsState {
  final String message;
  SettingsError(this.message);
}
