import 'dart:convert';

class WebSocketMessages {
  static String fetchPresets = jsonEncode({
    "MessageName": "http",
    "Parameters": {
      "Url": "/remote/presets",
      "Verb": "GET",
    }
  });

  static String registerPreset(String name) {
    return jsonEncode({
      "MessageName": "preset.register",
      "Parameters": {"PresetName": name}
    });
  }

  static String unRegisterPreset(String name) {
    return jsonEncode({
      "MessageName": "preset.unregister",
      "Parameters": {"PresetName": name}
    });
  }
}
