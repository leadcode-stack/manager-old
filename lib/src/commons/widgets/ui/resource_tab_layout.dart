import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

final class ResourceTabLayout extends StatefulWidget {
  final List<ResourceTab> resources;

  const ResourceTabLayout({
    required this.resources,
    super.key,
  });

  @override
  State<ResourceTabLayout> createState() => _ResourceTabLayoutState();
}

class _ResourceTabLayoutState extends State<ResourceTabLayout>
    with TickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    final location = GoRouterState.of(context).matchedLocation;
    final availableResources =
        widget.resources.where((resource) => resource.visible).toList();

    final resourceIndex = availableResources
        .indexWhere((element) => location.startsWith(element.path));

    return DefaultTabController(
      animationDuration: const Duration(milliseconds: 0),
      initialIndex: resourceIndex,
      length: availableResources.length,
      child: Container(
          color: Colors.grey.shade200,
          child: Column(
            children: [
              Container(
                color: Colors.white,
                child: TabBar(
                    isScrollable: true,
                    labelColor: Colors.blue.shade400,
                    indicatorColor: Colors.blue.shade400,
                    dividerColor: Colors.grey.shade200,
                    onTap: (index) {
                      final resource = availableResources.elementAt(index);
                      context.go(resource.path);
                    },
                    tabs: availableResources
                        .map((resource) => Tab(child: resource.label))
                        .toList()),
              ),
              Expanded(
                  child: TabBarView(
                children: availableResources
                    .map((ResourceTab resource) => resource.child)
                    .toList(),
              )),
            ],
          )),
    );
  }
}

final class ResourceTab {
  final Widget label;
  final String path;
  final Widget child;
  final bool visible;

  const ResourceTab(
      {required this.label,
      required this.path,
      required this.child,
      this.visible = true});
}
