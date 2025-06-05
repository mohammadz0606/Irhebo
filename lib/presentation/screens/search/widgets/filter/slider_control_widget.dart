import '../../../../../app/global_imports.dart';

class SliderControlWidget extends StatefulWidget {
  const SliderControlWidget({
    super.key,
    required this.limit,
    required this.maxValue,
    required this.minValue,
    required this.onChangeSlide,
  });

  final String limit;

  //final double selectedValue;
  final double maxValue;
  final double minValue;
  final Function(double value) onChangeSlide;

  @override
  State<SliderControlWidget> createState() => _SliderControlWidgetState();
}

class _SliderControlWidgetState extends State<SliderControlWidget> {
  late double currentValue;
  late double limit;

  @override
  void initState() {
    limit = double.tryParse(widget.limit) ?? 0.0;
    currentValue = limit.clamp(widget.minValue, widget.maxValue);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              widget.minValue.toString(), // Display min value
              style: Get.textTheme.labelMedium,
            ),
            Text(
              widget.maxValue.toString(), // Display max value
              style: Get.textTheme.labelMedium,
            ),
          ],
        ),
        SliderTheme(
          //Get.find<AppController>().darkMode
          data: SliderThemeData(
            overlayShape: SliderComponentShape.noOverlay,
            activeTickMarkColor: AppLightColors.primaryColor,
            thumbColor: AppLightColors.darkGreen,
            activeTrackColor: AppLightColors.primaryColor,
            inactiveTrackColor: Get.find<AppController>().darkMode
                ? Colors.white
                : Colors.black,
            inactiveTickMarkColor: Get.find<AppController>().darkMode
                ? Colors.white
                : Colors.black,
            valueIndicatorTextStyle: TextStyle(
              color: Get.find<AppController>().darkMode
                  ? Colors.white
                  : Colors.black,
              fontSize: 14.0,
              fontWeight: FontWeight.bold,
            ),
            showValueIndicator: ShowValueIndicator.always,
          ),
          child: Slider.adaptive(
            allowedInteraction: SliderInteraction.slideOnly,
            value: currentValue,
            onChanged: (val) {
              setState(() {
                currentValue = val;
              });
              widget.onChangeSlide(currentValue.round().toDouble());
            },
            min: widget.minValue,
            max: widget.maxValue,
            divisions: 100,
            label: currentValue.round().toString(), // Display the current value
          ),
        ),
      ],
    );
  }
}
