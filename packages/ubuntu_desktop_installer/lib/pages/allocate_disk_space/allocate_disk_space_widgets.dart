import 'package:filesize/filesize.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:scroll_to_index/scroll_to_index.dart';
import 'package:ubuntu_wizard/widgets.dart';

import '../../l10n.dart';
import 'allocate_disk_space_dialogs.dart';
import 'allocate_disk_space_model.dart';
import 'storage_columns.dart';
import 'storage_table.dart';

class PartitionBar extends StatelessWidget {
  PartitionBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final model = Provider.of<AllocateDiskSpaceModel>(context);
    return RoundedContainer(
      child: CustomPaint(
        size: const Size(double.infinity, 24),
        painter: _PartitionPainter(model),
      ),
    );
  }
}

Color _partitionColor(int index, int count) {
  assert(count > 0);
  final baseColor = HSLColor.fromColor(Colors.blue.shade900);
  final hue = (baseColor.hue + 360 / count * index) % 360;
  return baseColor.withHue(hue).toColor();
}

class _PartitionPainter extends CustomPainter {
  _PartitionPainter(this._model)
      : _selectedDiskIndex = _model.selectedDiskIndex,
        _selectedPartitionIndex = _model.selectedPartitionIndex;

  final AllocateDiskSpaceModel _model;
  final int _selectedDiskIndex;
  final int _selectedPartitionIndex;

  @override
  void paint(Canvas canvas, Size size) {
    final diskSize = _model.selectedDisk?.size ?? 0;
    if (diskSize <= 0) return;

    final rect = Offset.zero & size;
    final partitions = _model.selectedDisk?.partitions;
    final partitionCount = partitions?.length ?? 0;
    for (var index = 0; index < partitionCount; ++index) {
      final partitionSize = partitions![index].size ?? 0;
      if (partitionSize <= 0) continue;

      final paint = Paint();
      paint.color = _partitionColor(index, partitions.length);
      paint.style = PaintingStyle.fill;

      final width = rect.width * partitionSize / diskSize;
      canvas.drawRect(Rect.fromLTWH(0, 0, width, rect.height), paint);
      canvas.translate(width, 0);
    }
  }

  @override
  bool shouldRepaint(covariant _PartitionPainter old) {
    return old._selectedDiskIndex != _selectedDiskIndex ||
        old._selectedPartitionIndex != _selectedPartitionIndex;
  }
}

class PartitionLegend extends StatelessWidget {
  const PartitionLegend({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final model = Provider.of<AllocateDiskSpaceModel>(context);
    final lang = AppLocalizations.of(context);

    final partitions = model.selectedDisk?.partitions;
    final partitionCount = partitions?.length ?? 0;
    final freeSpace = model.selectedDisk?.freeForPartitions ?? 0;

    return SizedBox(
      height: 48,
      child: ListView.separated(
        shrinkWrap: true,
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(vertical: 8),
        itemCount: partitionCount + 1,
        separatorBuilder: (context, index) => const SizedBox(width: 40),
        itemBuilder: (context, index) {
          if (index >= partitionCount) {
            return _PartitionLabel(
              size: freeSpace,
              title: lang.freeDiskSpace,
              borderColor: Theme.of(context).dividerColor,
            );
          }

          final partition = partitions![index];

          return _PartitionLabel(
            // TODO:
            // - localize?
            // - partition type?
            title: '${model.selectedDisk!.id}${partition.number}',
            size: partition.size ?? 0,
            color: _partitionColor(index, partitions.length),
          );
        },
      ),
    );
  }
}

class _PartitionLabel extends StatelessWidget {
  const _PartitionLabel({
    Key? key,
    required this.title,
    required this.size,
    this.color = Colors.transparent,
    this.borderColor = Colors.transparent,
  }) : super(key: key);

  final String title;
  final int size;
  final Color color;
  final Color borderColor;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Align(
          alignment: Alignment.topLeft,
          child: Padding(
            padding: const EdgeInsets.fromLTRB(0, 2, 8, 0),
            child: Container(
              width: 10,
              height: 10,
              decoration: BoxDecoration(
                color: color,
                border: Border.all(color: borderColor),
                borderRadius: BorderRadius.circular(12),
              ),
            ),
          ),
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(title, style: Theme.of(context).textTheme.subtitle2),
            Text(filesize(size), style: Theme.of(context).textTheme.caption),
          ],
        ),
      ],
    );
  }
}

class PartitionTable extends StatelessWidget {
  const PartitionTable({Key? key, required this.controller}) : super(key: key);

  final AutoScrollController controller;

  @override
  Widget build(BuildContext context) {
    final model = Provider.of<AllocateDiskSpaceModel>(context);
    return StorageTable(
      columns: [
        StorageDeviceColumn(),
        StorageTypeColumn(),
        StorageMountColumn(),
        StorageSizeColumn(),
        StorageSystemColumn(),
        StorageWipeColumn(
          onWipe: (disk, partition, wipe) {
            model.editPartition(disk, partition, wipe: wipe);
          },
        ),
      ],
      storages: model.disks,
      controller: controller,
      canSelect: model.canSelectStorage,
      isSelected: model.isStorageSelected,
      onSelected: model.selectStorage,
    );
  }
}

class PartitionButtonRow extends StatelessWidget {
  const PartitionButtonRow({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final model = Provider.of<AllocateDiskSpaceModel>(context);
    final lang = AppLocalizations.of(context);

    return Row(
      children: <Widget>[
        RoundedContainer(
          child: IntrinsicHeight(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                OutlinedButton(
                  child: const Icon(Icons.add),
                  style: OutlinedButton.styleFrom(
                    side: BorderSide.none,
                    shape: const RoundedRectangleBorder(),
                  ),
                  onPressed: model.canAddPartition
                      ? () => showCreatePartitionDialog(
                          context, model.selectedDisk!)
                      : null,
                ),
                const VerticalDivider(width: 1),
                OutlinedButton(
                  child: const Icon(Icons.remove),
                  style: OutlinedButton.styleFrom(
                    side: BorderSide.none,
                    shape: const RoundedRectangleBorder(),
                  ),
                  onPressed: model.canRemovePartition
                      ? () => model.deletePartition(
                          model.selectedDisk!, model.selectedPartition!)
                      : null,
                ),
                const VerticalDivider(width: 1),
                OutlinedButton(
                  child: Text(lang.changeButtonText),
                  style: OutlinedButton.styleFrom(
                    side: BorderSide.none,
                    shape: const RoundedRectangleBorder(),
                  ),
                  onPressed: model.canEditPartition
                      ? () => showEditPartitionDialog(context,
                          model.selectedDisk!, model.selectedPartition!)
                      : null,
                ),
              ],
            ),
          ),
        ),
        const Spacer(),
        ButtonBar(
          children: [
            OutlinedButton(
              child: Text(lang.newPartitionTable),
              onPressed: model.canReformatDisk
                  ? () => _maybeReformatDisk(context)
                  : null,
            ),
          ],
        ),
        OutlinedButton(
          child: Text(lang.revertButtonText),
          onPressed: model.resetStorage,
        ),
      ],
    );
  }

  Future<void> _maybeReformatDisk(BuildContext context) async {
    final model = Provider.of<AllocateDiskSpaceModel>(context, listen: false);
    final lang = AppLocalizations.of(context);

    final disk = model.selectedDisk!;
    if (disk.ptable != null) {
      final confirmed = await showConfirmationDialog(
        context,
        title: lang.newPartitionTableConfirmationTitle,
        message: lang.newPartitionTableConfirmationMessage,
      );
      if (!confirmed) return;
    }
    model.reformatDisk(disk);
  }
}
