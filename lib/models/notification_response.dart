class NotificationResponse {
  NotificationResponse({
    bool? status,
    String? message,
    Data? data,
  }) {
    _status = status;
    _message = message;
    _data = data;
  }
  NotificationResponse.fromJson(dynamic json) {
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
    num? currentPage,
    List<DataList>? data,
    String? firstPageUrl,
    num? from,
    num? lastPage,
    String? lastPageUrl,
    String? nextPageUrl,
    String? path,
    num? perPage,
    String? prevPageUrl,
    num? to,
    num? total,
  }) {
    _currentPage = currentPage;
    _data = data;
    _firstPageUrl = firstPageUrl;
    _from = from;
    _lastPage = lastPage;
    _lastPageUrl = lastPageUrl;
    _nextPageUrl = nextPageUrl;
    _path = path;
    _perPage = perPage;
    _prevPageUrl = prevPageUrl;
    _to = to;
    _total = total;
  }
  Data.fromJson(dynamic json) {
    _currentPage = json['current_page'];
    if (json['data'] != null) {
      _data = [];

      json['data'].forEach((v) {
        _data?.add(DataList.fromJson(v));
      });
    }
    _firstPageUrl = json['first_page_url'];
    _from = json['from'];
    _lastPage = json['last_page'];
    _lastPageUrl = json['last_page_url'];
    _nextPageUrl = json['next_page_url'];
    _path = json['path'];
    _perPage = json['per_page'];
    _prevPageUrl = json['prev_page_url'];
    _to = json['to'];
    _total = json['total'];
  }
  num? _currentPage;
  List<DataList>? _data;
  String? _firstPageUrl;
  num? _from;
  num? _lastPage;
  String? _lastPageUrl;
  String? _nextPageUrl;
  String? _path;
  num? _perPage;
  String? _prevPageUrl;
  num? _to;
  num? _total;
  num get currentPage => _currentPage ?? -1;
  List<DataList> get data => _data ?? [];
  String get firstPageUrl => _firstPageUrl ?? '';
  num get from => _from ?? -1;
  num get lastPage => _lastPage ?? -1;
  String get lastPageUrl => _lastPageUrl ?? '';
  String get nextPageUrl => _nextPageUrl ?? '';
  String get path => _path ?? '';
  num get perPage => _perPage ?? -1;
  String get prevPageUrl => _prevPageUrl ?? '';
  num get to => _to ?? -1;
  num get total => _total ?? -1;
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['current_page'] = _currentPage;
    if (_data != null) {
      map['data'] = _data?.map((v) => v.toJson()).toList();
    }
    map['first_page_url'] = _firstPageUrl;
    map['from'] = _from;
    map['last_page'] = _lastPage;
    map['last_page_url'] = _lastPageUrl;
    map['next_page_url'] = _nextPageUrl;
    map['path'] = _path;

    map['per_page'] = _perPage;
    map['prev_page_url'] = _prevPageUrl;
    map['to'] = _to;
    map['total'] = _total;
    return map;
  }
}

class DataList {
  DataList({
    num? id,
    String? title,
    String? message,
  }) {
    _id = id;
    _title = title;
    _message = message;
  }
  DataList.fromJson(dynamic json) {
    _id = json['id'];
    _title = json['title'];
    _message = json['message'];
  }
  num? _id;
  String? _title;
  String? _message;
  num get id => _id ?? -1;
  String get title => _title ?? '';
  String get message => _message ?? '';
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['title'] = _title;
    map['message'] = _message;
    return map;
  }
}
