
import 'package:task33_complete_from_my_frien/models/category_details_response.dart';
import 'package:task33_complete_from_my_frien/models/favorite_response.dart';
class HomeResponse {
 HomeResponse({
 bool? status,
 String? message,
 Data? data,
 }) {
 _status = status;
 _message = message;
 _data = data;
 }
 HomeResponse.fromJson(dynamic json) {
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
 List<Banners>? banners,
 List<Products>? products,
 String? ad,
 }) {
 _banners = banners;
 _products = products;
 _ad = ad;
 }
 Data.fromJson(dynamic json) {
 if (json['banners'] != null) {
 _banners = [];
 json['banners'].forEach((v) {
 _banners?.add(Banners.fromJson(v));
 });
 }
 if (json['products'] != null) {
 _products = [];
 json['products'].forEach((v) {
 _products?.add(Products.fromJson(v));
 });
 }
 _ad = json['ad'];
 }
 List<Banners>? _banners;
 List<Products>? _products;
 String? _ad;
 List<Banners> get banners => _banners ?? [];
 List<Products> get products => _products ?? [];
 String get ad => _ad ?? '';
 Map<String, dynamic> toJson() {
 final map = <String, dynamic>{};
 if (_banners != null) {
 map['banners'] = _banners?.map((v) => v.toJson()).toList();
 }
 if (_products != null) {
 map['products'] = _products?.map((v) => v.toJson()).toList();
 }
 map['ad'] = _ad;
 return map;
 }
}
class Products {
 Products({
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
 Products.fromDataListCategoryDetails(DataListCategoryDetails data){
 _id = data.id;
 _price = data.price;
 _oldPrice = data.oldPrice;
 _discount = data.discount;
 _image = data.image;
 _name = data.name;
 _description = data.description;
 _images = data.images;
 _inFavorites = data.inFavorites;
 _inCart = data.inCart;
 }
 Products.fromDataListFavorite(DataListFavorite data){
 _id = data.product.id;
 _price = data.product.price;
 _oldPrice = data.product.oldPrice;
 _discount = data.product.discount;
 _image = data.product.image;
 _name = data.product.name;
 _description = data.product.description;
 _inFavorites = true;
 }
 Products.fromJson(dynamic json) {
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

 num get price => _price ?? 
-
1
;
 num get oldPrice => _oldPrice ?? 
-
1
;
 num get discount => _discount ?? 
-
1
;
 String get image => _image ?? ''
;
 String get name => _name ?? ''
;
 String get description => _description ?? ''
;
 List<String> get images => _images ?? []
;
 bool get inFavorites => _inFavorites ?? false;
 bool get inCart => _inCart ?? false;
 Map<String, dynamic> toJson() {
 final map = <String, dynamic>{}
;
 map['id'] = _id
;
 map['price'] = _price
;
 map['old_price'] = _oldPrice
;
 map['discount'] = _discount
;
 map['image'] = _image
;
 map['name'] = _name
;
 map['description'] = _description
;
 map['images'] = _images
;
 map['in_favorites'] = _inFavorites
;
 map['in_cart'] = _inCart
;
 return map
;
 
}
}
class Banners {
 Banners({
 num? id
,
 String? image
,
 String? category
,
 String? product
,
 }) {
 _id = id
;
 _image = image
;
 _category = category
;
 _product = product
;
 
}
 Banners.fromJson
(dynamic json) {
 _id = json['id'
]
;
 _image = json['image'
]
;
 _category = json['category'
]
;
 _product = json['product'
]
;
 
}
 num? _id
;
 String? _image
;
 String? _category
;
 String? _product
;
 num get id => _id??
-
1
;
 String get image => _image??''
;
 String get category => _category??''
;

 String get product => _product??'';
 Map<String, dynamic> toJson() {
 final map = <String, dynamic>{};
 map['id'] = _id;
 map['image'] = _image;
 map['category'] = _category;
 map['product'] = _product;
 return map;
 }
}
