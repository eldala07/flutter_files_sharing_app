import 'package:cross_file/cross_file.dart';
import 'package:flutter/material.dart';
import 'package:responsive_sharing_files/pages/home/dropArea/drop_area.dart';
import 'package:responsive_sharing_files/pages/home/droppedFiles/dropped_files.dart';
import 'package:responsive_sharing_files/pages/home/toolbar/toolbar.dart';
import 'package:responsive_sharing_files/theme/app_colors.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<XFile> files = [];

  @override
  void initState() {
    super.initState();
    files = [];
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: null,
      backgroundColor: AppColors.backgroundColor,
      body: SizedBox(
        height: height,
        width: width,
        child: Column(
          children: [
            const Toolbar(),
            Expanded(
              flex: 1,
              child: Row(
                children: [
                  Expanded(
                    flex: 2,
                    child: DropArea(
                      onFilesDropped: (List<XFile> files) {
                        setState(() {
                          this.files = files;
                        });
                      },
                    ),
                  ),
                  Expanded(flex: 3, child: DroppedFiles(files: files)),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
