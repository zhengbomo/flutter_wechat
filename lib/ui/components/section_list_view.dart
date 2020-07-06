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
  final Widget header;

  SectionListView({
    @required this.numberOfRowsInSection,
    @required this.rowWidget,
    this.header,
    this.sectionWidget,
    NumberOfSectionCallBack numberOfSection,
  })  : assert(!(numberOfRowsInSection == null || rowWidget == null),
            'numberOfRowsInSection and rowWidget are mandatory'),
        this.numberOfSection = numberOfSection ?? (() => 1);

  @override
  Widget build(BuildContext context) {
    final sectionCount = this.numberOfSection();

    return Scrollbar(
      child: ListView.builder(
        itemCount: _itemCount(sectionCount) + 1,
        itemBuilder: (context, index) {
          if (index == 0) {
            return this.header ?? SizedBox(width: 0, height: 0);
          } else {
            final indexPath = _indexPathFor(sectionCount, index - 1);
            if (indexPath.row == -1) {
              if (this.sectionWidget != null) {
                final section = this.sectionWidget(context, indexPath.section);
                return section ?? SizedBox.fromSize(size: Size(0, 0));
              } else {
                return SizedBox.fromSize(size: Size(0, 0));
              }
            } else {
              return this.rowWidget(context, indexPath.section, indexPath.row);
            }
          }
        },
        key: this.key,
      ),
    );
  }

  int _itemCount(int sectionCount) {
    return List.generate(
            sectionCount, (index) => this.numberOfRowsInSection(index) + 1)
        .reduce((value, element) => value + element);
  }

  _IndexPath _indexPathFor(int sectionCount, int index) {
    int section = 0;
    var currentIndex = index;
    for (int i = 0; i < sectionCount; i++) {
      var rows = this.numberOfRowsInSection(i);
      if (currentIndex == 0) {
        // section
        return _IndexPath(section: section, row: -1);
      } else if ((currentIndex - 1) <= (rows - 1)) {
        // row
        return _IndexPath(section: section, row: currentIndex - 1);
      } else {
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

  @override
  String toString() {
    return "section=$section, row=$row";
  }
}
