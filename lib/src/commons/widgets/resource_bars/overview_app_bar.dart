import 'package:flutter/material.dart';

final class OverviewAppBar extends StatelessWidget
    implements PreferredSizeWidget {
  final String title;
  final Widget? description;

  const OverviewAppBar({required this.title, this.description, super.key});

  @override
  Size get preferredSize => const Size.fromHeight(100);

  @override
  Widget build(BuildContext context) {
    final ModalRoute<dynamic>? parentRoute = ModalRoute.of(context);
    final bool usePopNavigation =
        parentRoute is PageRoute<dynamic> && parentRoute.impliesAppBarDismissal;

    return Container(
      height: preferredSize.height,
      alignment: Alignment.centerLeft,
      decoration: BoxDecoration(
          color: Colors.white,
          border: Border(
              bottom: BorderSide(color: Colors.grey.shade200, width: 1))),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: usePopNavigation
            ? Row(
                children: [
                  IconButton(
                      icon: const Icon(Icons.arrow_back, color: Colors.black),
                      onPressed: () => Navigator.of(context).pop()),
                  _OverviewBody(title: title, description: description)
                ],
              )
            : _OverviewBody(title: title, description: description),
      ),
    );
  }
}

final class _OverviewBody extends StatelessWidget {
  final String title;
  final Widget? description;

  const _OverviewBody({required this.title, required this.description});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(title, style: Theme.of(context).textTheme.titleLarge),
            description ?? const SizedBox()
          ]),
    );
  }
}
