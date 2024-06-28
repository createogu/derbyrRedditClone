import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:teambasketball/core/common/selectAddress/widgets/juso_list_item_widget.dart';

import '../../constants/constants.dart';
import '../../constants/size.dart';
import 'models/juso.model.dart';

class SelectAdressThreeDepthView extends StatelessWidget {
  final String up_code;
  final Function callback;

  const SelectAdressThreeDepthView({
    required this.callback,
    required this.up_code,
    super.key,
  });

  Future<List> jusoList() async {
    final dio = Dio();
    final resp = await dio.get(
      Constants().ip + '/common/getJusoList/' + up_code + '____00',
      options: Options(
        headers: {},
      ),
    );
    return resp.data;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List>(
      future: jusoList(),
      builder: (context, AsyncSnapshot<List> snapshot) {
        if (!snapshot.hasData) {
          return Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text('불러오는중 입니다.'),
              SizedBox(
                height: 16,
              ),
            ],
          );
        }
        return Padding(
          padding: const EdgeInsets.all(LARGE_GAP),
          child: GridView.builder(
            shrinkWrap: true, // child 위젯의 크기를 정해주지 않은 경우 true로 지정해야됨
            itemCount: snapshot.data!.length, //item 개수
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3, //1 개의 행에 보여줄 item 개수
              childAspectRatio: 1 / 1, //item 의 가로 세로의 비율
              mainAxisSpacing: SMALL_GAP, //수평 Padding
              crossAxisSpacing: SMALL_GAP, //수직 Padding
            ),
            itemBuilder: (_, index) {
              //!연산자는 null이 아니라고 단언 하는것 스크립트 에러를 막기위해서
              final item = snapshot.data![index];

              final pItem = JusoModel.fromJson(json: item);
              return GestureDetector(
                onTap: () {
                  callback(pItem);
                  Navigator.of(context).pop();
                  Navigator.of(context).pop();
                  Navigator.of(context).pop();
                },
                child: JusoListItemWidget.fromModel(
                  model: pItem,
                ),
              );
            },
          ),
        );
      },
    );
  }
}
