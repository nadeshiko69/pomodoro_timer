import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:math';

const kColorPurple = Color(0xFF8337EC);
const kColorPink = Color(0xFFFF006F);
const kColorIndicatorBegin = kColorPink;
const kColorIndicatorEnd = kColorPurple;
const kColorTitle = Color(0xFF616161);
const kColorText = Color(0xFF9E9E9E);
const kElevation = 4.0;

class _Percentage extends CustomPainter {
final double percentage; // バッテリーレベルの割合
final double textCircleRadius; // 内側に表示される白丸の半径

_Percentage({
  required this.percentage,
  required this.textCircleRadius,
});

@override
void paint(Canvas canvas, Size size) {
  for (int i = 1; i < (360 * percentage); i += 5) {
    final per = i / 360.0;
    // 割合（0~1.0）からグラデーション色に変換
    final color = ColorTween(
      begin: kColorIndicatorBegin,
      end: kColorIndicatorEnd,
    ).lerp(per)!;
    final paint = Paint()
      ..color = color
      ..style = PaintingStyle.stroke
      ..strokeWidth = 4;

    final spaceLen = 16; // 円とゲージ間の長さ
    final lineLen = 24; // ゲージの長さ
    final angle = (2 * pi * per) - (pi / 2); // 0時方向から開始するため-90度ずらす

    // 円の中心座標
    final offset0 = Offset(size.width * 0.5, size.height * 0.5);
    // 線の内側部分の座標
    final offset1 = offset0.translate(
      (textCircleRadius + spaceLen) * cos(angle),
      (textCircleRadius + spaceLen) * sin(angle),
    );
    // 線の外側部分の座標
    final offset2 = offset1.translate(
      lineLen * cos(angle),
      lineLen * sin(angle),
    );

    canvas.drawLine(offset1, offset2, paint);
  }
}

@override
bool shouldRepaint(CustomPainter oldDelegate) {
  return false;
}
}

class Percentage extends StatelessWidget {
  Percentage(this.percentage);
  final percentage;
  final size = 164.0;

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: _Percentage(
        percentage: percentage,
        textCircleRadius: size * 0.5,
      ),
      child: Container(
        padding: const EdgeInsets.all(64),
        child: Material(
          color: Colors.white,
          elevation: kElevation,
          borderRadius: BorderRadius.circular(size * 0.5),
          child: Container(
            width: size,
            height: size,
            child: Center(
              child: Text(
                '${(percentage * 100).toInt()}%',
                style: TextStyle(color: Colors.blue, fontSize: 48),
              ),
            ),
          ),
        ),
      ),
    );
  }
}