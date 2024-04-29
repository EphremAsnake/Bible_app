import 'package:american_bible/app/modules/detail/views/widgets/highlight_color.dart';
import 'package:flutter/material.dart';

int setHighlightColor(Color color) {
  if (color == HighlightColors.highlightGreen) {
    return 1;
  } else if (color == HighlightColors.highlightYellow) {
    return 2;
  } else if (color == HighlightColors.highlightOrange) {
    return 3;
  } else if (color == HighlightColors.highlightRed) {
    return 4;
  } else if (color == HighlightColors.highlightBlue) {
    return 5;
  } else if (color == HighlightColors.highlightPink) {
    return 6;
  } else if (color == HighlightColors.highlightDarkGreen) {
    return 7;
  } else if (color == HighlightColors.highlightDarkYellow) {
    return 8;
  } else if (color == HighlightColors.highlightDarkTeal) {
    return 9;
  } else if (color == HighlightColors.highlightBrown) {
    return 10;
  } else if (color == HighlightColors.highlightLightRed) {
    return 11;
  } else {
    return 0;
  }
}

Color getHighlightColor(int number) {
  if (number == 1) {
    return HighlightColors.highlightGreen;
  } else if (number == 2) {
    return HighlightColors.highlightYellow;
  } else if (number == 3) {
    return HighlightColors.highlightOrange;
  } else if (number == 4) {
    return HighlightColors.highlightRed;
  } else if (number == 5) {
    return HighlightColors.highlightBlue;
  } else if (number == 6) {
    return HighlightColors.highlightPink;
  } else if (number == 7) {
    return HighlightColors.highlightDarkGreen;
  } else if (number == 8) {
    return HighlightColors.highlightDarkYellow;
  } else if (number == 9) {
    return HighlightColors.highlightDarkTeal;
  } else if (number == 10) {
    return HighlightColors.highlightBrown;
  } else if (number == 11) {
    return HighlightColors.highlightLightRed;
  } else {
    return Colors.transparent;
  }
}
