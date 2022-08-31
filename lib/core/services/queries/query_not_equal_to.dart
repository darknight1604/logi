import 'package:logi/core/base_services/base_query.dart';

class QueryNotEqualTo extends BaseQuery {
  final dynamic isNotEqualTo;
  QueryNotEqualTo({
    required this.isNotEqualTo,
    required String field,
  }) : super(field);
}
