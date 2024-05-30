import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:manager/src/commons/utils/pagination_navigator.dart';
import 'package:manager/src/features/accounts/domain/controllers/permission_controller.dart';

final class PaginationNavigator<T> extends ConsumerStatefulWidget {
  final Pagination<T> pagination;

  const PaginationNavigator({
    required this.pagination,
    super.key,
  });

  @override
  ConsumerState<PaginationNavigator<T>> createState() =>
      _PaginationNavigatorState<T>();
}

class _PaginationNavigatorState<T>
    extends ConsumerState<PaginationNavigator<T>> {
  @override
  Widget build(BuildContext context) {
    final state = ref.watch(permissionsController.notifier);

    return Row(
      children: [
        IconButton(
          icon: const Icon(Icons.arrow_back_ios),
          tooltip: 'Previous page',
          color: state.page > 1 ? null : Colors.grey.shade300,
          iconSize: 20,
          onPressed: () {
            if (state.page > 1) {
              ref.read(permissionsController.notifier).previousPage(context);
            }
          },
        ),
        const SizedBox(width: 8),
        Text('${state.page}'),
        const SizedBox(width: 8),
        IconButton(
          icon: const Icon(Icons.arrow_forward_ios),
          tooltip: 'Next page',
          color: state.page < widget.pagination.meta.lastPage
              ? null
              : Colors.grey.shade300,
          iconSize: 20,
          onPressed: () {
            if (state.page < widget.pagination.meta.lastPage) {
              ref.read(permissionsController.notifier).nextPage(context);
            }
          },
        ),
      ],
    );
  }
}

final class PageSchema {
  int page;
  int limit;
  String? search;

  PageSchema({
    required this.page,
    required this.limit,
    this.search,
  });

  factory PageSchema.of(Uri uri) {
    final parameters = uri.queryParameters;
    return PageSchema(
      page: int.tryParse(parameters['page'] ?? '') ?? 1,
      limit: int.tryParse(parameters['limit'] ?? '') ?? 10,
      search: parameters['search'],
    );
  }
}
