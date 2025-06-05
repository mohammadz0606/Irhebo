import '../../../../../app/global_imports.dart';

class RangeSliderControlWidget extends StatefulWidget {
  const RangeSliderControlWidget({
    super.key,
    required this.minValue,
    required this.maxValue,
    required this.initialStart,
    required this.initialEnd,
    required this.onChangeRange,
    required this.title, required this.rangeText,
  });

  final double minValue;
  final double maxValue;
  final double initialStart;
  final double initialEnd;
  final Function(RangeValues values) onChangeRange;
  final String title;
  final String rangeText;

  @override
  State<RangeSliderControlWidget> createState() =>
      _RangeSliderControlWidgetState();
}

class _RangeSliderControlWidgetState extends State<RangeSliderControlWidget> {
  late RangeValues currentRange;

  @override
  void initState() {
    super.initState();
    currentRange = RangeValues(widget.initialStart, widget.initialEnd);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          widget.title.tr,
          style:
              Get.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 10),
        RangeSlider(
          values: currentRange,
          min: widget.minValue,
          max: widget.maxValue,
          divisions: 100,
          activeColor: Colors.deepPurple,
          inactiveColor: Colors.deepPurple.withOpacity(0.2),
          onChanged: (RangeValues values) {
            setState(() => currentRange = values);
            widget.onChangeRange(values);
          },
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('${currentRange.start.toStringAsFixed(0)} ${widget.rangeText}',
                style: Get.textTheme.labelLarge),
            Text('${currentRange.end.toStringAsFixed(0)} ${widget .rangeText}',
                style: Get.textTheme.labelLarge),
          ],
        ),
      ],
    );
  }
}
