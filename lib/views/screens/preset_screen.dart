import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:remote_control_test/controller/preset_controller.dart';
import 'package:remote_control_test/models/preset_event_response.dart';
import 'package:remote_control_test/models/preset_info_response.dart';
import 'package:remote_control_test/utilities/toast.dart';
import 'package:remote_control_test/views/widgets/preset_event_widget.dart';
import 'package:remote_control_test/views/widgets/preset_list_widget.dart';

class PresetScreen extends StatefulWidget {
  const PresetScreen({super.key});

  @override
  State<PresetScreen> createState() => _PresetScreenState();
}

class _PresetScreenState extends State<PresetScreen> {
  late PresetController controller;

  @override
  void initState() {
    super.initState();
    controller = Provider.of<PresetController>(context, listen: false);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      //Fetches list of Remote Control Presets available in the engine.
      controller.fetchAllPresets();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Center(
            child: InkWell(
          onTap: () {
            Navigator.pop(context);
          },
          child: const Icon(
            Icons.arrow_back,
            color: Colors.white,
          ),
        )),
        backgroundColor: const Color(0xff414141),
        title: const Text("Presets"),
        centerTitle: false,
      ),
      body: StreamBuilder(
        stream: controller.channel.stream,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done ||
              snapshot.connectionState == ConnectionState.none) {
            controller.setConnectionState(ConnectionState.none);
            //Returns to connection screen once WebSocket connection is closed
            showErrorToast(msg: snapshot.error.toString());
            Navigator.pop(context);
          }

          WidgetsBinding.instance.addPostFrameCallback((_) {
            //sets connection state
            controller.setConnectionState(snapshot.connectionState);
          });

          if (snapshot.hasData) {
            Map<String, dynamic> jsonData =
                json.decode(utf8.decode(snapshot.data));
            //Assuming successful http response always have requestId
            if (jsonData["RequestId"] != null) {
              PresetInfoResponseModel model = PresetInfoResponseModel.fromJson(
                  json.decode(utf8.decode(snapshot.data)));
              WidgetsBinding.instance.addPostFrameCallback((_) {
                controller.setPresetList(model.responseBody.presets);
              });
            } else if (jsonData["ChangedFields"] != null) {
              PresetEventResponseModel model =
                  PresetEventResponseModel.fromJson(
                      json.decode(utf8.decode(snapshot.data)));
              WidgetsBinding.instance.addPostFrameCallback((_) {
                controller.setPresetEvents(model);
              });
            } else {
              showErrorToast();
            }
          }

          return Column(children: [
            Container(
              color: Colors.black,
              height: 5,
            ),
            Expanded(
                child: SizedBox(
              child: Row(children: [
                Consumer<PresetController>(
                  builder: ((context, presetController, child) {
                    return Expanded(
                        child: Container(
                      padding: const EdgeInsets.all(12),
                      color: const Color(0xff2f2f2f),
                      child: presetController.connectionState ==
                              ConnectionState.waiting
                          ? const Center(child: CircularProgressIndicator())
                          : Column(children: [
                              ElevatedButton(
                                  onPressed: () {
                                    presetController.fetchAllPresets();
                                  },
                                  child: const Padding(
                                    padding:
                                        EdgeInsets.symmetric(horizontal: 50),
                                    child: Text("Refresh"),
                                  )),
                              const SizedBox(
                                height: 10,
                              ),
                              const Expanded(child: PresetListWidget())
                            ]),
                    ));
                  }),
                ),
                Container(
                  color: Colors.black,
                  width: 5,
                ),
                Expanded(
                    child: Container(
                        padding: const EdgeInsets.all(12),
                        color: const Color(0xff2f2f2f),
                        child: const PresetEventWidget()))
              ]),
            ))
          ]);
        },
      ),
    );
  }
}
