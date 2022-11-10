import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:remote_control_test/controller/preset_controller.dart';
import 'package:remote_control_test/views/screens/preset_screen.dart';

class ConnectionScreen extends StatelessWidget {
  ConnectionScreen({super.key});

  final TextEditingController controller =
      TextEditingController(text: "ws://127.0.0.1:30020"); //Default IP address
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xff414141),
        title: const Text("Flutter Remote Control Test"),
        centerTitle: false,
      ),
      backgroundColor: const Color(0xff2f2f2f),
      body: Center(
        child: ConstrainedBox(
          constraints: BoxConstraints.tightFor(width: size.width * 0.3),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Form(
                key: _formKey,
                child: TextFormField(
                  controller: controller,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Enter socket port url';
                    }
                    return null;
                  },
                  decoration: const InputDecoration(
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey, width: 0.0),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey, width: 0.0),
                    ),
                  ),
                  style: const TextStyle(color: Colors.white),
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              Consumer<PresetController>(
                builder: ((context, presetController, child) {
                  return ElevatedButton(
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          presetController
                              .clearAllData(); //Clears all previous data
                          presetController.establishConnection(controller.text);

                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: ((context) =>
                                      const PresetScreen())));
                        }
                      },
                      child: const Padding(
                        padding: EdgeInsets.symmetric(horizontal: 50),
                        child: Text("Connect"),
                      ));
                }),
              )
            ],
          ),
        ),
      ),
    );
  }
}
