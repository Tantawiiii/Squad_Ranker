import 'dart:io';
import 'package:app_settings/app_settings.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:share_plus/share_plus.dart';
import 'package:url_launcher/url_launcher_string.dart';

import 'settings_state.dart';

class SettingsCubit extends Cubit<SettingsState> {
  SettingsCubit() : super(SettingsInitial());

  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  Future<void> requestNotificationPermissions(
      [String from = 'settings']) async {
    try {
      if (Platform.isIOS) {
        await flutterLocalNotificationsPlugin
            .resolvePlatformSpecificImplementation<
                IOSFlutterLocalNotificationsPlugin>()
            ?.requestPermissions(alert: true, badge: true, sound: true);
      } else {
        await flutterLocalNotificationsPlugin
            .resolvePlatformSpecificImplementation<
                AndroidFlutterLocalNotificationsPlugin>()
            ?.requestNotificationsPermission();
      }

      if (from == 'settings') {
        await AppSettings.openAppSettings();
      }

      emit(SettingsNotificationPermissionGranted());
    } catch (e) {
      emit(SettingsError('Failed to request notification permissions: $e'));
    }
  }

  Future<void> launchPrivacyPolicy() async {
    try {
      await launchUrlString('https://www.google.com');
      emit(SettingsPrivacyPolicyOpened());
    } catch (e) {
      emit(SettingsError('Failed to launch privacy policy: $e'));
    }
  }

  Future<void> shareApp() async {
    try {
      // ignore: deprecated_member_use
      await Share.share(
        "https://appdynamiclinka.page.link/76UZ",
        subject: 'Look what I made!',
      );
      emit(SettingsAppShared());
    } catch (e) {
      emit(SettingsError('Failed to share app: $e'));
    }
  }
}
