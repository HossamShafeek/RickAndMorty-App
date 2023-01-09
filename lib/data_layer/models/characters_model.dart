class CharacterModel {
  int? id;
  String? name;
  String? status;
  String? species;
  String? gender;
  String? image;
  String? url;
  String? created;
  OriginModel? origin;
  LocationModel? location;
  List<String>? episode;
  CharacterModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    status = json['status'];
    species = json['species'];
    gender = json['gender'];
    image = json['image'];
    url = json['url'];
    created = json['created'];
    origin = OriginModel.fromJson(json['origin']);
    location = LocationModel.fromJson(json['location']);
    episode = json['episode'].cast<String>();
  }
}

class OriginModel {
  String? name;
  String? url;

  OriginModel.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    url = json['url'];
  }
}

class LocationModel {
  String? name;
  String? url;

  LocationModel.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    url = json['url'];
  }
}
