import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:manager/src/commons/utils/pagination_navigator.dart';
import 'package:manager/src/commons/widgets/pagination/pagination.dart';

mixin PaginationController<T> on AutoDisposeAsyncNotifier<Pagination<T>> {
  int page = 1;
  int limit = 10;
  String? searchValue;

  Uri get location {
    final params = Map<String, String>.from(Uri.base.queryParameters)
      ..update('page', (_) => page.toString(), ifAbsent: () => page.toString())
      ..update('limit', (_) => limit.toString(),
          ifAbsent: () => limit.toString());

    if (searchValue == null) {
      params.remove('search');
    } else {
      params.update('search', (_) => searchValue!,
          ifAbsent: () => searchValue!);
    }

    return Uri(path: Uri.base.path, queryParameters: params);
  }

  Future<Pagination<T>> paginate(PageSchema schema);

  Future<void> search(BuildContext context, String value) async {
    searchValue = value;
    page = 1;

    context.go(location.toString());

    state = AsyncLoading<Pagination<T>>().copyWithPrevious(state);
    state = await AsyncValue.guard<Pagination<T>>(() async {
      return paginate(PageSchema(
        page: page,
        limit: limit,
        search: searchValue,
      ));
    });
  }

  Future<void> previousPage(BuildContext context) async {
    page--;

    context.go(location.toString());
    state = AsyncLoading<Pagination<T>>().copyWithPrevious(state);
    state = await AsyncValue.guard<Pagination<T>>(() async {
      return paginate(PageSchema(
        page: page,
        limit: limit,
        search: searchValue,
      ));
    });
  }

  Future<void> nextPage(BuildContext context) async {
    page++;
    context.go(location.toString());

    state = AsyncLoading<Pagination<T>>().copyWithPrevious(state);
    state = await AsyncValue.guard<Pagination<T>>(() async {
      return paginate(PageSchema(
        page: page,
        limit: limit,
        search: searchValue,
      ));
    });
  }
}
