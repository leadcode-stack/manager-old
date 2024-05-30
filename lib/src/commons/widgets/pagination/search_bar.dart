import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:manager/src/commons/utils/pagination_controller.dart';

final class Search extends ConsumerStatefulWidget {
  final Refreshable<PaginationController> notifier;
  const Search({required this.notifier, super.key});

  @override
  ConsumerState createState() => _SearchBarState();
}

class _SearchBarState extends ConsumerState<Search> {
  final TextEditingController _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 400,
      child: SearchBar(
        controller: _controller,
        hintText: 'Search...',
        backgroundColor: WidgetStateProperty.all(Colors.white),
        elevation: WidgetStateProperty.all(0),
        overlayColor: WidgetStateProperty.all(Colors.white),
        shape: WidgetStateProperty.all(RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8.0),
          side: BorderSide(color: Colors.grey.shade300),
        )),
        padding: const WidgetStatePropertyAll<EdgeInsets>(
            EdgeInsets.symmetric(horizontal: 16.0)),
        onChanged: (value) =>
            ref.read(widget.notifier).search(context, value),
        leading: const Icon(Icons.search),
      ),
    );
  }
}
