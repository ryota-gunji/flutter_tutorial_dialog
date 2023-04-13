library flutter_tutorial_dialog;

import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';

/// show Dialog
void showTutorialDialog({
  required BuildContext context,
  required List<Widget> children,
  required double width,
  required double height,
  Color dotsColor = Colors.grey,
}) {
  showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        content: TutorialScrollableDialog(
          height: height,
          dotsColor: dotsColor,
          children: children,
        ),
      );
    },
  );
}

/// TutorialScrollableDialog
class TutorialScrollableDialog extends StatefulWidget {
  const TutorialScrollableDialog({
    Key? key,
    required this.children,
    required this.height,
    required this.dotsColor,
  }) : super(key: key);

  /// children
  final List<Widget> children;

  /// height
  final double height;

  /// dotsColor
  final Color dotsColor;

  @override
  State<TutorialScrollableDialog> createState() =>
      _TutorialScrollableDialogState();
}

class _TutorialScrollableDialogState extends State<TutorialScrollableDialog> {
  /// PageController
  final controller = PageController();

  /// 現在のページ
  double currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: widget.height,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
            ),
            height: widget.height * 0.8,
            width: MediaQuery.of(context).size.width * 0.8,
            child: PageView(
              // エフェクトを無くす
              physics: const BouncingScrollPhysics(),
              controller: controller,
              children: widget.children,
              onPageChanged: (int index) {
                setState(() {
                  // ページが変わったらcurrentIndexを更新
                  currentIndex = index.toDouble();
                });
              },
            ),
          ),
          // ページのインジケーター
          Container(
            margin: EdgeInsets.symmetric(
                vertical: MediaQuery.of(context).size.width * 0.01),
            height: widget.height * 0.1,
            child: DotsIndicator(
              dotsCount: widget.children.length, // ページ数
              position: currentIndex,
              decorator: DotsDecorator(
                activeColor: widget.dotsColor, // アクティブなドットの色
                size: const Size.square(9.0),
                activeSize: const Size(9.0, 9.0),
                activeShape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5.0),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class NormalTutorialWidget extends StatelessWidget {
  const NormalTutorialWidget({
    Key? key,
    required this.imagePath,
    required this.message,
    this.fontSize = 20,
  }) : super(key: key);

  /// imagePath
  final String imagePath;

  /// message
  final String message;

  /// fontSize
  final double fontSize;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          child: Image.asset(
            imagePath,
          ),
        ),
        Text(
          message,
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: fontSize,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }
}
