import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

final class OverviewNavigationBar extends StatelessWidget {
  final List<OverviewResourceLink> links;

  const OverviewNavigationBar({required this.links, super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
        decoration: BoxDecoration(
            color: Colors.white,
            border: Border(
                bottom: BorderSide(color: Colors.grey.shade400, width: 1))),
        child: Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
          for (final link in links)
            Padding(
              padding: const EdgeInsets.only(right: 20.0),
              child: TextButton(
                onPressed: () => context.go(link.route),
                child: Text(link.title),
              ),
            )
        ]));
  }
}

class OverviewResourceLink {
  final String title;
  final String route;

  const OverviewResourceLink({required this.title, required this.route});
}
