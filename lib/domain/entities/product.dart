class Product {
  String? id;
  String? image;
  String? name;
  String? storeName;
  String? price;
  String? type;
  String? description;
  String? facebook;
  String? instagram;
  String? phoneNumber;

  Product({
    required this.id,
    required this.image,
    required this.name,
    required this.storeName,
    required this.price,
    required this.type,
    required this.description,
    required this.facebook,
    required this.instagram,
    required this.phoneNumber,
  });

  // Getters
  String? get getName => name;

  String? get getstoreName => storeName;

  String? get getPrice => price;

  String? get getType => type;

  Product copyWith({
    String? id,
    String? image,
    String? name,
    String? storeName,
    String? price,
    String? type,
    String? description,
    String? facebook,
    String? instagram,
    String? phoneNumber,
  }) {
    return Product(
      id: id ?? this.id,
      image: image ?? this.image,
      name: name ?? this.name,
      storeName: storeName ?? this.storeName,
      price: price ?? this.price,
      type: type ?? this.type,
      description: description ?? this.description,
      facebook: facebook ?? this.facebook,
      instagram: instagram ?? this.instagram,
      phoneNumber: phoneNumber ?? this.phoneNumber,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'storeName': storeName,
      'price': price,
      'type': type,
      'description': description,
      'facebook': facebook,
      'instagram': instagram,
      'phoneNumber': phoneNumber,
    };
  }

  Product.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    image = json['image'];
    name = json['name'];
    storeName = json['storeName'];
    price = json['price'];
    type = json['type'];
    description = json['description'];
    facebook = json['facebook'];
    instagram = json['instagram'];
    phoneNumber = json['phoneNumber'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['image'] = image;
    data['name'] = name;
    data['storeName'] = storeName;
    data['price'] = price;
    data['type'] = type;
    data['description'] = description;
    data['facebook'] = facebook;
    data['instagram'] = instagram;
    data['phoneNumber'] = phoneNumber;
    return data;
  }
}
