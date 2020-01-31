// Autogenerated from Dartle, do not edit directly.
import 'package:flutter/services.dart';

class SearchReply {
  String result;
  Map _toMap() {
    Map dartleMap = Map();
    dartleMap["result"] = result;
    return dartleMap;
  }
  static SearchReply _fromMap(Map dartleMap) {
    var result = SearchReply();
    result.result = dartleMap["result"];
    return result;
  }
}

class Nested {
  SearchRequest request;
  Map _toMap() {
    Map dartleMap = Map();
    dartleMap["request"] = request._toMap();
    return dartleMap;
  }
  static Nested _fromMap(Map dartleMap) {
    var result = Nested();
    result.request = SearchRequest._fromMap(dartleMap["request"]);
    return result;
  }
}

class SearchRequest {
  String query;
  Map _toMap() {
    Map dartleMap = Map();
    dartleMap["query"] = query;
    return dartleMap;
  }
  static SearchRequest _fromMap(Map dartleMap) {
    var result = SearchRequest();
    result.query = dartleMap["query"];
    return result;
  }
}

class NestedApi {
  Future<SearchReply> search(Nested arg) async {
    Map requestMap = arg._toMap();
    BasicMessageChannel channel =
        BasicMessageChannel('dev.flutter.dartle.NestedApi.search', StandardMessageCodec());
    Map replyMap = await channel.send(requestMap);
    return SearchReply._fromMap(replyMap);
  }
}

class Api {
  Future<SearchReply> search(SearchRequest arg) async {
    Map requestMap = arg._toMap();
    BasicMessageChannel channel =
        BasicMessageChannel('dev.flutter.dartle.Api.search', StandardMessageCodec());
    Map replyMap = await channel.send(requestMap);
    return SearchReply._fromMap(replyMap);
  }
}

