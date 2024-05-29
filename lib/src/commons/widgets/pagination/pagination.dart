import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
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
  late int _page;
  late int _limit;

  void previousPage(BuildContext context, int page) async {
    final currentUri = Uri.base;
    _page = page;

    final location = Uri(
        path: currentUri.path,
        queryParameters: Map<String, String>.from(currentUri.queryParameters)
          ..update('page', (_) => page.toString())
          ..update('limit', (_) => _limit.toString())
    );

    context.go(location.toString());
    await ref.read(permissionsController.notifier).previousPage();
  }

  void nextPage(BuildContext context, int page) async {
    final currentUri = Uri.base;
    _page = page;

    final location = Uri(
        path: currentUri.path,
        queryParameters: Map<String, String>.from(currentUri.queryParameters)
          ..update('page', (_) => page.toString())
          ..update('limit', (_) => _limit.toString())
    );

    context.go(location.toString());
    await ref.read(permissionsController.notifier).nextPage();
  }

  @override
  Widget build(BuildContext context) {
    final parameters = GoRouterState.of(context).uri.queryParameters;
    _page = int.tryParse(parameters['page'] ?? '') ?? 1;
    _limit = int.tryParse(parameters['limit'] ?? '') ?? 10;

    return Row(
      children: [
        IconButton(
          icon: const Icon(Icons.arrow_back_ios),
          tooltip: 'Previous page',
          color: _page > 1 ? null : Colors.grey.shade300,
          iconSize: 20,
          onPressed: () {
            if (_page > 1) {
              previousPage(context, _page - 1);
            }
          },
        ),
        const SizedBox(width: 8),
        Text('${widget.pagination.meta.currentPage}'),
        const SizedBox(width: 8),
        IconButton(
          icon: const Icon(Icons.arrow_forward_ios),
          tooltip: 'Next page',
          color: _page < widget.pagination.meta.lastPage ? null : Colors.grey.shade300,
          iconSize: 20,
          onPressed: () {
            if (_page < widget.pagination.meta.lastPage) {
              nextPage(context, _page + 1);
            }
          },
        ),
      ],
    );
  }
}
