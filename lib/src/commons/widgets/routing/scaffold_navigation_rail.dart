import 'package:flutter/material.dart';
import 'package:manager/src/routing/navigation_rail_items.dart';

class ScaffoldNavigationRail extends StatefulWidget {
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
  State<ScaffoldNavigationRail> createState() => _ScaffoldNavigationRailState();
}

class _ScaffoldNavigationRailState extends State<ScaffoldNavigationRail> {
  bool isExtended = false;

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
                extended: isExtended,
                backgroundColor: Colors.white,
                selectedIndex: widget.selectedIndex,
                onDestinationSelected: widget.onDestinationSelected,
                leading: Container(
                    padding: const EdgeInsets.only(bottom: 20),
                    child: _buildCompanyLogo()),
                trailing: Expanded(
                  child: Align(
                    alignment: Alignment.bottomCenter,
                    child: _buildToggleExtendedButton(),
                  ),
                ),
                destinations: railDestinations),
          ),
          Expanded(
            child: widget.body,
          ),
        ],
      ),
    );
  }

  Widget _buildCompanyLogo() {
    return Container(
      padding: const EdgeInsets.only(bottom: 20),
      child: ClipRRect(
          borderRadius: BorderRadius.circular(8.0),
          child: Image.network(
              'https://avatars.githubusercontent.com/u/105711639?s=200&v=4',
              width: 50,
              height: 50)),
    );
  }

  Widget _buildToggleExtendedButton() {
    return Padding(
        padding: const EdgeInsets.only(bottom: 8.0),
        child: ElevatedButton(
          onPressed: () {
            setState(() => isExtended = !isExtended);
          },
          child:
          Icon(isExtended ? Icons.arrow_back_ios : Icons.arrow_forward_ios),
        ));
  }
}
