class CartResponse {
  CartResponse({
    bool? status,
    dynamic message,
    Data? data,
  }) {
    _status = status;
    _message = message;
    _data = data;
  }
  CartResponse.fromJson(dynamic json) {
    _status = json['status'];
    _message = json['message'];
    _data = json['data'] != null ? Data.fromJson(json['data']) : null;
  }
  bool? _status;
  String? _message;
  Data? _data;
  bool get status => _status ?? false;
  String get message => _message ?? '';
  Data get data => _data ?? Data();
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['status'] = _status;
    map['message'] = _message;
    if (_data != null) {
      map['data'] = _data?.toJson();
    }
    return map;
  }
}

class Data {
  Data({
    List<CartItems>? cartItems,
    num? subTotal,
    num? total,
  }) {
    _cartItems = cartItems;
    _subTotal = subTotal;
    _total = total;
  }
  Data.fromJson(dynamic json) {
    if (json['cart_items'] != null) {
      _cartItems = [];
      json['cart_items'].forEach((v) {
        _cartItems?.add(CartItems.fromJson(v));
      });
    }
    _subTotal = json['sub_total'];
    _total = json['total'];
  }
  List<CartItems>? _cartItems;
  num? _subTotal;
  num? _total;
  List<CartItems> get cartItems => _cartItems ?? [];
  num get subTotal => _subTotal ?? -1;
  num get total => _total ?? -1;
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (_cartItems != null) {
      map['cart_items'] = _cartItems?.map((v) => v.toJson()).toList();
    }
    map['sub_total'] = _subTotal;
    map['total'] = _total;
    return map;
  }
}

class CartItems {
  CartItems({
    num? id,
    num? quantity,
    Product? product,
  }) {
    _id = id;
    _quantity = quantity;
    _product = product;
  }
  CartItems.fromJson(dynamic json) {
    _id = json['id'];
    _quantity = json['quantity'];
    _product =
        json['product'] != null ? Product.fromJson(json['product']) : null;
  }
  num? _id;
  num? _quantity;
  Product? _product;
  num get id => _id ?? -1;
  num get quantity => _quantity ?? -1;
  Product get product => _product ?? Product();
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['quantity'] = _quantity;
    if (_product != null) {
      map['product'] = _product?.toJson();
    }
    return map;
  }
}

class Product {
  Product({
    num? id,
    num? price,
    num? oldPrice,
    num? discount,
    String? image,
    String? name,
    String? description,
    List<String>? images,
    bool? inFavorites,
    bool? inCart,
  }) {
    _id = id;
    _price = price;
    _oldPrice = oldPrice;
    _discount = discount;
    _image = image;
    _name = name;
    _description = description;
    _images = images;
    _inFavorites = inFavorites;
    _inCart = inCart;
  }
  Product.fromJson(dynamic json) {
    _id = json['id'];
    _price = json['price'];
    _oldPrice = json['old_price'];
    _discount = json['discount'];
    _image = json['image'];
    _name = json['name'];
    _description = json['description'];
    _images = json['images'] != null ? json['images'].cast<String>() : [];
    _inFavorites = json['in_favorites'];
    _inCart = json['in_cart'];
  }
  num? _id;
  num? _price;
  num? _oldPrice;
  num? _discount;
  String? _image;
  String? _name;
  String? _description;
  List<String>? _images;
  bool? _inFavorites;
  bool? _inCart;
  num get id => _id ?? -1;
  num get price => _price ?? -1;
  num get oldPrice => _oldPrice ?? -1;
  num get discount => _discount ?? -1;
  String get image => _image ?? '';
  String get name => _name ?? '';
  String get description => _description ?? '';

  List<String> get images => _images ?? [];
  bool get inFavorites => _inFavorites ?? false;
  bool get inCart => _inCart ?? false;
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['price'] = _price;
    map['old_price'] = _oldPrice;
    map['discount'] = _discount;
    map['image'] = _image;
    map['name'] = _name;
    map['description'] = _description;
    map['images'] = _images;
    map['in_favorites'] = _inFavorites;
    map['in_cart'] = _inCart;
    return map;
  }
}
