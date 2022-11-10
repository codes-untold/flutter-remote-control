import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:remote_control_test/controller/preset_controller.dart';

class PresetListWidget extends StatelessWidget {
  const PresetListWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<PresetController>(
      builder: ((context, presetController, child) {
        return ListView.builder(
            itemCount: presetController.presetList.length,
            itemBuilder: ((context, index) => InkWell(
                  onTap: () {
                    ///sets index for previously selected preset
                    presetController.setPreSelectedPresetIndex(
                        presetController.selectedPresetIndex);

                    //sets index for currently selected preset
                    presetController.setSelectedPresetIndex(index);

                    //registers preset for updates in the engine
                    presetController.registerPreset();
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      border: Border(
                          bottom: BorderSide(
                              color: presetController.presetList.length - 1 ==
                                      index
                                  ? Colors.transparent
                                  : Colors.white,
                              width: 0.2)),
                      color: presetController.selectedPresetIndex == index
                          ? const Color(0xff484848)
                          : const Color(0xff2f2f2f),
                    ),
                    padding: const EdgeInsets.all(20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          presetController.presetList[index].name,
                          style: TextStyle(
                              color:
                                  presetController.selectedPresetIndex == index
                                      ? Colors.blue
                                      : Colors.white),
                        ),
                        Icon(
                          Icons.arrow_forward_ios,
                          color: presetController.selectedPresetIndex == index
                              ? Colors.blue
                              : Colors.white,
                          size: 12,
                        )
                      ],
                    ),
                  ),
                )));
      }),
    );
  }
}
