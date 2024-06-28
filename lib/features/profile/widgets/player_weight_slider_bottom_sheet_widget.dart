import 'package:flutter/material.dart';

import '../../../core/constants/size.dart';

class PlayerWeightSliderBottomSheetWidget extends StatefulWidget {
  final double p_playerWeight;
  final Function onChangedPlayerWeight;

  const PlayerWeightSliderBottomSheetWidget({
    required this.p_playerWeight,
    required this.onChangedPlayerWeight,
    Key? key,
  }) : super(key: key);

  @override
  State<PlayerWeightSliderBottomSheetWidget> createState() =>
      _PlayerWeightSliderBottomSheetWidgetState();
}

class _PlayerWeightSliderBottomSheetWidgetState
    extends State<PlayerWeightSliderBottomSheetWidget> {
  double playerWeight = 0;

  @override
  void initState() {
    playerWeight = widget.p_playerWeight;
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(MEDIUM_GAP),
      child: SizedBox(
        height: MediaQuery.of(context).size.height / 3,
        child: Container(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                '몸무게',
                style: TextStyle(
                    fontSize: MEDIUM_FONT_SIZE, fontWeight: FontWeight.w600),
              ),
              Text(
                playerWeight.toString() + ' kg',
                style: TextStyle(
                  fontSize: MEDIUM_FONT_SIZE,
                ),
              ),
              Slider(
                value: playerWeight,
                min: 30.0,
                max: 150.0,
                divisions: 240,
                onChanged: (value) {
                  setState(() {
                    playerWeight = value;
                  });
                },
              ),
              const SizedBox(
                height: LARGE_GAP,
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  minimumSize: const Size.fromHeight(50),
                ),
                onPressed: () {
                  widget.onChangedPlayerWeight(playerWeight);
                  Navigator.pop(context);
                },
                child: Text('확인'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
