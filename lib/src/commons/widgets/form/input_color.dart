import 'package:flex_color_picker/flex_color_picker.dart';
import 'package:flutter/material.dart';
import 'package:manager/src/commons/utils/color.dart';

final class InputColor extends StatefulWidget {
  final String label;
  final String initialValue;
  final Function(Color) onChange;

  const InputColor(
      {required this.label,
      required this.initialValue,
      required this.onChange,
      super.key});

  @override
  State<StatefulWidget> createState() => _InputColorState();
}

final class _InputColorState extends State<InputColor> {
  late Color color;

  @override
  void initState() {
    super.initState();
    color = stringToColor(widget.initialValue);
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        ColorIndicator(
            width: 25,
            height: 25,
            borderRadius: 50,
            color: color,
            elevation: 1,
            onSelectFocus: false,
            onSelect: () async {
              final Color newColor = await showColorPickerDialog(
                context,
                stringToColor(widget.initialValue),
                title: Text(widget.label,
                    style: Theme.of(context).textTheme.titleLarge),
                width: 40,
                height: 40,
                spacing: 0,
                runSpacing: 0,
                borderRadius: 0,
                wheelDiameter: 165,
                enableOpacity: true,
                showColorCode: true,
                colorCodeHasColor: true,
                pickersEnabled: <ColorPickerType, bool>{
                  ColorPickerType.wheel: true,
                },
                copyPasteBehavior: const ColorPickerCopyPasteBehavior(
                  copyButton: true,
                  pasteButton: true,
                  longPressMenu: true,
                ),
                actionButtons: const ColorPickerActionButtons(
                  okButton: true,
                  closeButton: true,
                  dialogActionButtons: false,
                ),
                transitionBuilder: (BuildContext context, Animation<double> a1,
                    Animation<double> a2, Widget widget) {
                  final double curvedValue =
                      Curves.easeInOutBack.transform(a1.value) - 1.0;
                  return Transform(
                    transform:
                        Matrix4.translationValues(0.0, curvedValue * 200, 0.0),
                    child: Opacity(
                      opacity: a1.value,
                      child: widget,
                    ),
                  );
                },
                transitionDuration: const Duration(milliseconds: 400),
                constraints: const BoxConstraints(
                    minHeight: 480, minWidth: 320, maxWidth: 320),
              );

              setState(() => color = newColor);
              widget.onChange(newColor);
            }),
        const SizedBox(width: 10),
        Text(widget.label, style: Theme.of(context).textTheme.bodyLarge),
      ],
    );
  }
}
