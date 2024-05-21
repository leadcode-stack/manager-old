import 'package:flutter/material.dart';

class DataTableResource<T> extends StatefulWidget {
  final List<T> resources;
  final List<DataColumn> columns;
  final List<DataCell> Function(T) builder;

  const DataTableResource(
      {required this.resources,
      required this.columns,
      required this.builder,
      super.key});

  @override
  State<DataTableResource<T>> createState() => _DataTableResourceState();
}

class _DataTableResourceState<T> extends State<DataTableResource<T>> {
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        return SingleChildScrollView(
          child: ConstrainedBox(
            constraints: BoxConstraints(minWidth: constraints.maxWidth),
            child: DataTable(
              decoration: BoxDecoration(
                color: Colors.white,
                border: Border.all(color: Colors.grey.shade300),
                borderRadius: BorderRadius.circular(8),
              ),
              columns: widget.columns,
              rows: widget.resources
                  .map(
                    (T resource) => DataRow(
                  cells: widget.builder(resource),
                ),
              )
                  .toList(),
            ),
          ),
        );
      },
    );
  }
}
