import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:remote_control_test/controller/preset_controller.dart';

class PresetEventWidget extends StatelessWidget {
  const PresetEventWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<PresetController>(
      builder: ((context, presetController, child) {
        return ListView.builder(
            itemCount: presetController.presetEvents.length,
            itemBuilder: ((context, index) => Container(
                decoration: BoxDecoration(
                    border: Border(
                        bottom: BorderSide(
                            color: presetController.presetEvents.length - 1 ==
                                    index
                                ? Colors.transparent
                                : Colors.white,
                            width: 0.2))),
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      presetController.presetEvents[index].presetName,
                      style: const TextStyle(color: Colors.white),
                    ),
                    Text(
                      presetController.presetEvents[index].type,
                      style: const TextStyle(color: Colors.white),
                    ),
                  ],
                ))));
      }),
    );
  }
}
