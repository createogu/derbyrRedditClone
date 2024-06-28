import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:teambasketball/core/common/selectAddress/select_adress_two_depth_view.dart';
import 'package:teambasketball/core/common/selectAddress/widgets/juso_list_item_widget.dart';
import 'package:teambasketball/core/constants/constants.dart';

import '../../constants/size.dart';
import '../layout/default_layout.dart';
import 'models/juso.model.dart';

class SelectAdressOneDepthView extends StatelessWidget {
  final Function callback;

  const SelectAdressOneDepthView({required this.callback, super.key});

  Future<List> jusoList() async {
    final dio = Dio();

    final resp = await dio.get(
      Constants().ip + '/common/getJusoList/' + '__00000000',
      options: Options(
        headers: {},
      ),
    );
    return resp.data;
  }

  @override
  Widget build(BuildContext context) {
    return DefaultLayout(
      title: '주소선택',
      child: FutureBuilder<List>(
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
            padding: const EdgeInsets.all(MEDIUM_GAP),
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
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (_) => DefaultLayout(
                          title: pItem.name,
                          child: SelectAdressTwoDepthView(
                              callback: callback,
                              up_code: pItem.code.substring(0, 2)),
                        ),
                      ),
                    );
                  },
                  child: JusoListItemWidget.fromModel(
                    model: pItem,
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }
}
