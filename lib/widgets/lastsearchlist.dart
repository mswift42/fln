import 'package:flutter/material.dart';

class LastSearchGrid extends StatelessWidget {
  final ValueChanged<String> onDeleted;
  final ValueChanged<String> onTapped;
  final List<String> _lastSearches;
  LastSearchGrid(this.onDeleted, this.onTapped, this._lastSearches);

  void _handleOnDelete(String value) {
    onDeleted(value);
  }

  void _handleOnTap(String value) {
    onTapped(value);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        child: Wrap(
      spacing: 12.0,
      runSpacing: 4.0,
      children: _lastSearches
          .map((i) => LastSearchWidget(i, _handleOnDelete, _handleOnTap))
          .toList(),
    ));
  }
}

class LastSearchWidget extends StatelessWidget {
  final String value;
  final ValueChanged<String> onDeleted;
  final ValueChanged<String> onTapped;

  LastSearchWidget(this.value, this.onDeleted, this.onTapped);

  void _handleOnDelete() {
    onDeleted(value);
  }

  void _handleTap() {
    onTapped(value);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Chip(
        label: GestureDetector(
          child: Text(value),
          onTap: _handleTap,
        ),
        deleteIcon: Icon(Icons.delete),
        onDeleted: _handleOnDelete,
      ),
    );
  }
}
