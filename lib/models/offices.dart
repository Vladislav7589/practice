class OfficesList {
  List<Offices>? offices;


  OfficesList({this.offices});

  OfficesList.fromJson(Map<String, dynamic> json) {
    if (json['offices'] != null) {
      offices = <Offices>[];
      json['offices'].forEach((v) {
        offices!.add(new Offices.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.offices != null) {
      data['offices'] = this.offices!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Offices {
  String? address;
  String? id;
  String? image;
  double? lat;
  double? lng;
  String? name;
  String? phone;
  String? region;

  Offices(
      {this.address,
        this.id,
        this.image,
        this.lat,
        this.lng,
        this.name,
        this.phone,
        this.region});

  Offices.fromJson(Map<String, dynamic> json) {
    address = json['address'];
    id = json['id'];
    image = json['image'];
    lat = json['lat'];
    lng = json['lng'];
    name = json['name'];
    phone = json['phone'];
    region = json['region'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['address'] = this.address;
    data['id'] = this.id;
    data['image'] = this.image;
    data['lat'] = this.lat;
    data['lng'] = this.lng;
    data['name'] = this.name;
    data['phone'] = this.phone;
    data['region'] = this.region;
    return data;
  }
}


