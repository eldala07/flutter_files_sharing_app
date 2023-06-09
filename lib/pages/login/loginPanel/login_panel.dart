import 'package:flutter/material.dart';

import '../../../theme/responsive_widget.dart';
import 'leftPanel/left_panel.dart';
import 'rightPanel/right_panel.dart';

class LoginPanel extends StatelessWidget {
  const LoginPanel({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

    return SizedBox(
      height: height,
      width: width,
      child: ResponsiveWidget.isMobile(context)
          ? Column(
              children: [const LeftPanel(), const RightPanel()],
            )
          : Row(
              children: [const LeftPanel(), const RightPanel()],
            ),
    );
  }
}
