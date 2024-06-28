import 'package:flutter/material.dart';

import '../../../core/constants/size.dart';

class PlayerHeightSliderBottomSheetWidget extends StatefulWidget {
  final double p_playerHeight;
  final Function onChangedPlayerHeight;

  const PlayerHeightSliderBottomSheetWidget({
    required this.p_playerHeight,
    required this.onChangedPlayerHeight,
    Key? key,
  }) : super(key: key);

  @override
  State<PlayerHeightSliderBottomSheetWidget> createState() =>
      _PlayerHeightSliderBottomSheetWidgetState();
}

class _PlayerHeightSliderBottomSheetWidgetState
    extends State<PlayerHeightSliderBottomSheetWidget> {
  double playerHeight = 150;

  @override
  void initState() {
    playerHeight = widget.p_playerHeight;
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
                '키',
                style: TextStyle(
                    fontSize: MEDIUM_FONT_SIZE, fontWeight: FontWeight.w600),
              ),
              Text(
                playerHeight.toString() + ' cm',
                style: TextStyle(
                  fontSize: MEDIUM_FONT_SIZE,
                ),
              ),
              Slider(
                value: playerHeight,
                min: 100.0,
                max: 220.0,
                divisions: 240,
                onChanged: (value) {
                  setState(() {
                    playerHeight = value;
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
                  widget.onChangedPlayerHeight(playerHeight);
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
