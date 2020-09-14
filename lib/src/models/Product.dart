class Product {
  int id;
  String sku;
  String name;
  String cpu;
  String gpu;
  String os;
  String ram;
  String storage;
  String newFeature;
  String display;
  String displayResolution;
  String displayScreen;
  String camera;
  String video;
  String wifi;
  String bluetooth;
  String ports;
  String size;
  String weight;
  String material;
  String batteryCapacity;
  String description;
  int sold;
  double ratingAvg;
  int ratingCount;
  int categoryId;
  int brandId;
  List<dynamic> images;
  int price;
  int discountPrice;

  Product.fromJson(Map<String, dynamic> json) {
    if (json == null) return;
    id = json['id'];
    name = json['name'];
    cpu = json['cpu'];
    gpu = json['gpu'];
    os = json['os'];
    ram = json['ram'];
    storage = json['storage'];
    newFeature = json['new_feature'];
    display = json['display'];
    displayResolution = json['display_resolution'];
    displayScreen = json['display_screen'];
    camera = json['camera'];
    video = json['video'];
    wifi = json['wifi'];
    bluetooth = json['bluetooth'];
    ports = json['ports'];
    size = json['size'];
    weight = json['weight'];
    material = json['material'];
    batteryCapacity = json['battery_capacity'];
    description = json['description'];
    sold = json['sold'];
    ratingAvg = json['rating_avg'];
    ratingCount = json['rating_count'];
    categoryId = json['category_id'];
    brandId = json['brand_id'];
    images = json['images'];
    price = json['price'];
    discountPrice = json['discount_price'];
  }

  static List<Product> listFromJson(List<dynamic> json) {
    return json == null
        ? List<Product>()
        : json.map((value) => Product.fromJson(value)).toList();
  }
}
