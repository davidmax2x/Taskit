package io.flutter.plugins;

import androidx.annotation.Keep;
import androidx.annotation.NonNull;
import io.flutter.Log;

import io.flutter.embedding.engine.FlutterEngine;

/**
 * Generated file. Do not edit.
 * This file is generated by the Flutter tool based on the
 * plugins that support the Android platform.
 */
@Keep
public final class GeneratedPluginRegistrant {
  private static final String TAG = "GeneratedPluginRegistrant";
  public static void registerWith(@NonNull FlutterEngine flutterEngine) {
    try {
      flutterEngine.getPlugins().add(new com.jrai.flutter_keyboard_visibility_temp_fork.FlutterKeyboardVisibilityTempForkPlugin());
    } catch (Exception e) {
      Log.e(TAG, "Error registering plugin flutter_keyboard_visibility_temp_fork, com.jrai.flutter_keyboard_visibility_temp_fork.FlutterKeyboardVisibilityTempForkPlugin", e);
    }
    try {
      flutterEngine.getPlugins().add(new dev.flutterquill.quill_native_bridge.QuillNativeBridgePlugin());
    } catch (Exception e) {
      Log.e(TAG, "Error registering plugin quill_native_bridge_android, dev.flutterquill.quill_native_bridge.QuillNativeBridgePlugin", e);
    }
    try {
      flutterEngine.getPlugins().add(new io.flutter.plugins.urllauncher.UrlLauncherPlugin());
    } catch (Exception e) {
      Log.e(TAG, "Error registering plugin url_launcher_android, io.flutter.plugins.urllauncher.UrlLauncherPlugin", e);
    }
  }
}
