//
// Generated file. Do not edit.
//

// ignore_for_file: directives_ordering
// ignore_for_file: lines_longer_than_80_chars
// ignore_for_file: depend_on_referenced_packages

import 'package:audio_session/audio_session_web.dart';
import 'package:file_picker/_internal/file_picker_web.dart';
import 'package:flutter_sound_web/flutter_sound_web.dart';
import 'package:fluttertoast/fluttertoast_web.dart';
import 'package:just_audio_web/just_audio_web.dart';
import 'package:uni_links_web/uni_links_web.dart';
import 'package:url_launcher_web/url_launcher_web.dart';
import 'package:wakelock_web/wakelock_web.dart';

import 'package:flutter_web_plugins/flutter_web_plugins.dart';

// ignore: public_member_api_docs
void registerPlugins(Registrar registrar) {
  AudioSessionWeb.registerWith(registrar);
  FilePickerWeb.registerWith(registrar);
  FlutterSoundPlugin.registerWith(registrar);
  FluttertoastWebPlugin.registerWith(registrar);
  JustAudioPlugin.registerWith(registrar);
  UniLinksPlugin.registerWith(registrar);
  UrlLauncherPlugin.registerWith(registrar);
  WakelockWeb.registerWith(registrar);
  registrar.registerMessageHandler();
}
