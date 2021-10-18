import 'package:flutter/material.dart';

enum FilterOptions {
  SortbyNameAsec,
  SortbyNameDesc,
  SortbyActiveCasesAsec,
  SortbyActiveCasesDesc,
}

class PopupSubMenuItem {
  final String title;
  final value;

  const PopupSubMenuItem({this.title, this.value});
}

class PopupSubMenu<T> extends PopupMenuEntry<T> {
  final List<PopupSubMenuItem> items;
  final String title;
  final void Function(FilterOptions filterOptions) onSelected;

  const PopupSubMenu({
    @required this.title,
    @required this.onSelected,
    @required this.items,
  });

  @override
  State<StatefulWidget> createState() => PopupSubMenuState();

  /// The minimum height of the menu item.
  ///
  /// Defaults to [kMinInteractiveDimension] pixels.
  @override
  double get height => kMinInteractiveDimension;

  @override
  bool represents(T value) => false;
}

class PopupSubMenuState<T, W extends PopupSubMenu<T>> extends State<W> {
  @override
  Widget build(BuildContext context) {
    return PopupMenuButton(
      tooltip: widget.title,
      onCanceled: () {
        if (Navigator.canPop(context)) Navigator.pop(context);
      },
      onSelected: (FilterOptions value) {
        if (Navigator.canPop(context)) Navigator.pop(context);

        if (value != null) widget.onSelected?.call(value);
      },
      itemBuilder: (context) {
        return widget.items.map((item) {
          PopupMenuItem(
            child: Text(item.title),
            value: item.value,
          );
        }).toList();
      },
    );
  }
}
