import 'package:cross_file/cross_file.dart';
import 'package:desktop_drop/desktop_drop.dart';
import 'package:flutter/material.dart';
import 'package:mime/mime.dart';
import 'package:responsive_sharing_files/shared/app_icons.dart';
import 'package:responsive_sharing_files/theme/app_colors.dart';
import 'package:responsive_sharing_files/theme/app_styles.dart';

class DropArea extends StatefulWidget {
  final void Function(List<XFile> files) onFilesDropped;

  const DropArea({Key? key, required this.onFilesDropped}) : super(key: key);

  @override
  State<DropArea> createState() => _DropAreaState();
}

class _DropAreaState extends State<DropArea> {
  bool dragging = false;
  Offset localPosition = Offset.zero;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned.fill(
          child: DropTarget(
            onDragEntered: (details) {
              dragging = true;
              localPosition = details.localPosition;
              setState(() {});
            },
            onDragUpdated: (details) {
              localPosition = details.localPosition;
              setState(() {});
            },
            onDragExited: (details) {
              dragging = false;
              localPosition = details.localPosition;
              setState(() {});
            },
            onDragDone: (details) async {
              final files = details.files;
              final filteredFiles = files.where((file) {
                final mimeType = lookupMimeType(file.name);
                return mimeType != null && mimeType.startsWith('image/');
              }).toList();
              widget.onFilesDropped(filteredFiles.toList());
            },
            child: AnimatedContainer(
                duration: const Duration(milliseconds: 200),
                margin: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: dragging
                      ? AppColors.secondaryColor.withAlpha(50)
                      : Colors.white24,
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(
                    color: dragging
                        ? AppColors.secondaryColor
                        : AppColors.secondaryColor.withAlpha(50),
                    width: 2,
                  ),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.file_copy_sharp,
                      size: 32,
                      color: dragging
                          ? AppColors.textColor
                          : AppColors.textLightColor,
                    ),
                    const SizedBox(height: 20),
                    Text('Drop files here',
                        textAlign: TextAlign.center,
                        style: robotoStyle(fontSize: 14.0).copyWith(
                          color: dragging
                              ? AppColors.textColor
                              : AppColors.textLightColor,
                          fontWeight: FontWeight.bold,
                        )),
                  ],
                )),
          ),
        ),
        Positioned(
          left: localPosition.dx - 25,
          top: localPosition.dy - 25,
          child: AnimatedOpacity(
            duration: const Duration(milliseconds: 200),
            opacity: dragging ? 1 : 0,
            child: IgnorePointer(
                ignoring: true, child: Image.asset(AppIcons.picture as String)),
          ),
        ),
      ],
    );
  }
}
