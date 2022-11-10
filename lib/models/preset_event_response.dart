class PresetEventResponseModel {
  PresetEventResponseModel({
    required this.type,
    required this.presetName,
    required this.presetId,
  });

  late final String type;
  late final String presetName;
  late final String presetId;

  PresetEventResponseModel.fromJson(Map<String, dynamic> json) {
    type = json['Type'];
    presetName = json['PresetName'];
    presetId = json['PresetId'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};

    data['Type'] = type;
    data['PresetName'] = presetName;
    data['PresetId'] = presetId;
    return data;
  }
}
