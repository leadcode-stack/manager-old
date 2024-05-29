import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:manager/src/commons/utils/pagination_navigator.dart';

mixin PaginationController<T> on AutoDisposeAsyncNotifier<Pagination<T>> {
  Future<Pagination<T>> paginate(int page, int limit);

  Future<void> previousPage() async {
    state = AsyncLoading<Pagination<T>>().copyWithPrevious(state);
    state = await AsyncValue.guard<Pagination<T>>(() async {
      return paginate(state.requireValue.meta.currentPage - 1,
          state.requireValue.meta.perPage);
    });
  }

  Future<void> nextPage() async {
    state = AsyncLoading<Pagination<T>>().copyWithPrevious(state);
    state = await AsyncValue.guard<Pagination<T>>(() async {
      return paginate(state.requireValue.meta.currentPage + 1, state.requireValue.meta.perPage);
    });
  }
}