class PresetInfoResponseModel {
  PresetInfoResponseModel(
      {required this.responseCode, required this.responseBody});

  late final dynamic responseCode;
  late final dynamic responseId;
  late final ResponseBody responseBody;

  PresetInfoResponseModel.fromJson(Map<String, dynamic> json) {
    responseCode = json['ResponseCode'];
    responseBody = ResponseBody.fromjson(json['ResponseBody']);
    responseId = json['RequestId'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['ResponseCode'] = responseCode;
    data['ReponseBody'] = responseBody;
    data['RequestId'] = responseId;
    return data;
  }
}

class ResponseBody {
  late final List<Presets> presets;
  ResponseBody({required this.presets});

  ResponseBody.fromjson(Map<String, dynamic> json) {
    presets =
        List.from(json['Presets']).map((e) => Presets.fromJson(e)).toList();
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['Presets'] = presets.map((e) => e.toJson()).toList();
    return data;
  }
}

class Presets {
  Presets({
    required this.name,
    required this.path,
  });
  late final String name;
  late final String path;

  Presets.fromJson(Map<String, dynamic> json) {
    name = json['Name'];
    path = json['Path'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['Name'] = name;
    data['Path'] = path;
    return data;
  }
}
