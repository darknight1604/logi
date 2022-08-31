import 'package:logi/core/base_services/base_query.dart';

class QueryEqualTo extends BaseQuery {
  final dynamic isEqualTo;
  QueryEqualTo({
    required this.isEqualTo,
    required String field,
  }) : super(field);
}
