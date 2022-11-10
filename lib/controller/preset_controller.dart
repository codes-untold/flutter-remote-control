import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:remote_control_test/models/preset_event_response.dart';
import 'package:remote_control_test/models/preset_info_response.dart';
import 'package:remote_control_test/utilities/websocket_messages.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

class PresetController extends ChangeNotifier {
  //previously selected preset index
  int? preSelectedPresetIndex;
  //currently selected preset index
  int? selectedPresetIndex;

  ConnectionState connectionState = ConnectionState.none;
  late WebSocketChannel channel;
  List<Presets> presetList = [];
  List<PresetEventResponseModel> presetEvents = [];

  void establishConnection(String socketUrl) {
    try {
      channel = WebSocketChannel.connect(Uri.parse(socketUrl));
    } catch (e) {
      log(e.toString());
    }
  }

//Registers currently selected preset
//Unregisters previously selected Preset
  void registerPreset() {
    try {
      channel.sink.add(WebSocketMessages.registerPreset(
          presetList[selectedPresetIndex!].name));
      if (preSelectedPresetIndex != null) {
        channel.sink.add(WebSocketMessages.unRegisterPreset(
            presetList[preSelectedPresetIndex!].name));
      }
    } catch (e) {
      log(e.toString());
    }
  }

  //fetches all presets available on the engine
  void fetchAllPresets() {
    setConnectionState(ConnectionState.waiting);
    channel.sink.add(WebSocketMessages.fetchPresets);
  }

  //Updates list of presets
  void setPresetList(List<Presets> list) {
    presetList.clear();
    presetList.addAll(list);
    notifyListeners();
  }

  //Updates list of preset events
  void setPresetEvents(PresetEventResponseModel event) {
    presetEvents.add(event);
    notifyListeners();
  }

  //Sets new index for currently selected preset
  void setSelectedPresetIndex(int index) {
    selectedPresetIndex = index;
    notifyListeners();
  }

  //Sets new index for previously selected preset
  void setPreSelectedPresetIndex(int? index) {
    preSelectedPresetIndex = index;
    notifyListeners();
  }

  //Sets connection state
  setConnectionState(ConnectionState state) {
    connectionState = state;
    notifyListeners();
  }

//Clears log of received preset events and presets lists.
  void clearAllData() {
    presetList.clear();
    presetEvents.clear();
    preSelectedPresetIndex = selectedPresetIndex = null;
  }
}
