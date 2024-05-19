import 'package:flutter/material.dart';
import 'package:manager/src/routing/navigation_rail_items.dart';

class ScaffoldNavigationRail extends StatelessWidget {
  final Widget body;
  final int selectedIndex;
  final ValueChanged<int> onDestinationSelected;

  const ScaffoldNavigationRail({
    super.key,
    required this.body,
    required this.selectedIndex,
    required this.onDestinationSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        children: [
          Container(
            decoration: BoxDecoration(
              color: Colors.white,
              border: Border(
                right: BorderSide(color: Colors.grey.shade200, width: 1),
              ),
            ),
            child: NavigationRail(
                indicatorColor: Colors.blue.shade200,
                indicatorShape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                backgroundColor: Colors.white,
                selectedIndex: selectedIndex,
                onDestinationSelected: onDestinationSelected,
                labelType: NavigationRailLabelType.all,
                leading: Container(
                    padding: const EdgeInsets.only(bottom: 20),
                    child: ClipRRect(
                        borderRadius: BorderRadius.circular(8.0),
                        child: Image.network(
                            'https://avatars.githubusercontent.com/u/105711639?s=200&v=4',
                            width: 50,
                            height: 50))),
                trailing: Expanded(
                  child: Align(
                    alignment: Alignment.bottomCenter,
                    child: Padding(
                        padding: const EdgeInsets.only(bottom: 8.0),
                        child: CircleAvatar(
                          backgroundColor: Colors.grey.shade400,
                          radius: 20,
                        )),
                  ),
                ),
                destinations: railDestinations),
          ),
          Expanded(
            child: body,
          ),
        ],
      ),
    );
  }
}
