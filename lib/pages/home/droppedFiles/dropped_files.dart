import 'package:cross_file/cross_file.dart';
import 'package:flutter/material.dart';
import 'package:responsive_sharing_files/theme/app_styles.dart';

import '../../../shared/app_images.dart';
import '../../../theme/app_colors.dart';

class DroppedFiles extends StatefulWidget {
  final List<XFile> files;

  const DroppedFiles({Key? key, required this.files}) : super(key: key);

  @override
  State<DroppedFiles> createState() => _DroppedFilesState();
}

class _DroppedFilesState extends State<DroppedFiles> {
  List<XFile> allFiles = [];

  allFilesList() {
    allFiles = widget.files + allFiles;
  }

  @override
  void initState() {
    super.initState();
    allFilesList();
  }

  @override
  void didUpdateWidget(covariant DroppedFiles oldWidget) {
    super.didUpdateWidget(oldWidget);
    allFilesList();
  }

  @override
  Widget build(BuildContext context) {
    return allFiles.isNotEmpty
        ? Column(
            children: [
              Container(
                margin: const EdgeInsets.only(
                    top: 10, bottom: 10, left: 20, right: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Dropped files',
                      style: robotoStyle(
                        fontSize: 14,
                        color: AppColors.textColor,
                      ),
                    ),
                    TextButton(
                      onPressed: () {
                        setState(() {
                          allFiles = [];
                        });
                      },
                      child: Text(
                        'Clear all',
                        style: robotoStyle(
                          fontSize: 14,
                          color: AppColors.secondaryColor,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: ListView.builder(
                  itemCount: allFiles.length,
                  itemBuilder: (context, index) {
                    final file = allFiles[index];
                    return ListTile(
                      leading: const Icon(
                        Icons.insert_drive_file,
                        color: Colors.deepOrange,
                      ),
                      title: Text(file.name),
                      // subtitle: Text(file.path),
                    );
                  },
                ),
              ),
            ],
          )
        : Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(AppImages.noFilesDropped, height: 200, width: 200),
              Center(
                child: Text(
                  'No files dropped',
                  textAlign: TextAlign.center,
                  style:
                      robotoStyle(fontSize: 14.0, color: AppColors.textColor),
                ),
              ),
            ],
          );
  }
}
