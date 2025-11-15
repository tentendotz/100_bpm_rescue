import 'package:flutter/material.dart';
import 'package:hackathon_app/presentation/view/model/bottom_nav_item_model.dart';

///
/// 仮の共通ボトムナビ
///
class BottomNav extends StatelessWidget {
  const BottomNav({
    super.key,
    this.currentIndex = 0,
    required this.itemList,
    required this.tapFunc,
  });

  final int currentIndex;
  final List<BottomNavItemModel> itemList;
  final void Function(int) tapFunc;

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      items: [
        ...itemList.map((item) {
          return BottomNavigationBarItem(
            icon: item.icon,
            label: item.labelText,
          );
        }),
      ],
      currentIndex: currentIndex,
      onTap: tapFunc,
    );
  }
}
