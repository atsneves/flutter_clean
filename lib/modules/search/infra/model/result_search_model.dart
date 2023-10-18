import 'dart:convert';

import 'package:movies_clean/modules/search/domain/entities/result_search.dart';

class ResultSearchModel extends ResultSearch {
  final String title;
  final String content;
  final String img;

  ResultSearchModel(this.title, this.content, this.img)
      : super(title, content, img);

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    result.addAll({'login': title});
    result.addAll({'node_id': content});
    result.addAll({'avatar_url': img});

    return result;
  }

  factory ResultSearchModel.fromMap(Map<String, dynamic> map) {
    return ResultSearchModel(
      map['login'] ?? 'a',
      map['node_id'] ?? 'b',
      map['avatar_url'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory ResultSearchModel.fromJson(String source) =>
      ResultSearchModel.fromMap(json.decode(source));
}
