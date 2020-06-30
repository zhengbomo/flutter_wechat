import 'package:flutter/material.dart';

typedef int NumberOfRowsCallBack(int section);
typedef int NumberOfSectionCallBack();
typedef Widget SectionBuilder(BuildContext context, int section);
typedef Widget RowsBuilder(BuildContext context, int section, int row);

class SectionListView extends StatelessWidget {
  /// Defines the total number of sections
  final NumberOfSectionCallBack numberOfSection;

  /// Mandatory callback method to get the rows count in each section
  final NumberOfRowsCallBack numberOfRowsInSection;

  /// Callback method to get the section widget
  final SectionBuilder sectionWidget;

  /// Mandatory callback method to get the row widget
  final RowsBuilder rowWidget;

  SectionListView({
    this.numberOfSection,
    @required this.numberOfRowsInSection,
    this.sectionWidget,
    @required this.rowWidget,
  }) : assert(!(numberOfRowsInSection == null || rowWidget == null),
            'numberOfRowsInSection and rowWidget are mandatory');

  @override
  Widget build(BuildContext context) {
    var sectionCount = this.numberOfSection();

    return ListView.builder(
      itemCount: _itemCount(sectionCount),
      itemBuilder: (context, index) {
        final indexPath = _indexPathFor(sectionCount, index);
        if (indexPath.row == -1) {
          return this.sectionWidget(context, indexPath.section);
        } else {
          return this.rowWidget(context, indexPath.section, indexPath.row);
        }
      },
      key: this.key,
    );
  }

  int _itemCount(int sectionCount) {
    return List.generate(
            sectionCount, (index) => this.numberOfRowsInSection(index) + 1)
        .reduce((value, element) => value + element);
  }

  _IndexPath _indexPathFor(int sectionCount, int index) {
    int row = 0;
    int section = 0;
    var currentIndex = index;
    for (int i = 0; i < sectionCount; i++) {
      var rows = this.numberOfRowsInSection(i);
      if (currentIndex == 0) {
        // section
        return _IndexPath(section: section, row: -1);
      } else if ((currentIndex - 1) <= (rows - 1)) {
        // row
        return _IndexPath(section: section, row: row);
      } else if (currentIndex == rows) {
        // next section
        section += 1;
        currentIndex -= (rows + 1);
      }
    }
    return _IndexPath(section: 0, row: -1);
  }
}

/// Helper class for indexPath of each item in list
class _IndexPath {
  _IndexPath({this.section, this.row});
  int section = 0;
  int row = 0;
}
