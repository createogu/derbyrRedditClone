import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:routemaster/routemaster.dart';
import 'package:spider_chart_updated/spider_chart_updated.dart';
import 'package:teambasketball/core/constants/common_code.dart';
import 'package:teambasketball/features/post/widgets/post_card.dart';

import '../../../core/common/error_text.dart';
import '../../../core/common/loader.dart';
import '../../../core/utils.dart';
import '../../auth/controller/auth_controller.dart';
import '../controller/user_profile_controller.dart';

class UserProfileScreen extends ConsumerWidget {
  final String uid;

  const UserProfileScreen({
    super.key,
    required this.uid,
  });

  void navigateToEditUser(BuildContext context) {
    Routemaster.of(context).push('/edit-profile/$uid');
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    String loginedUid = ref.read(userProvider)!.uid;
    return Scaffold(
      body: ref.watch(getUserDataProvider(uid)).when(
            data: (user) => NestedScrollView(
              headerSliverBuilder: (context, innerBoxIsScrolled) {
                return [
                  SliverAppBar(
                    expandedHeight: 250,
                    floating: true,
                    snap: true,
                    flexibleSpace: Stack(
                      children: [
                        Positioned.fill(
                          child: Image.network(
                            user.banner,
                            fit: BoxFit.cover,
                          ),
                        ),
                        Container(
                          alignment: Alignment.bottomCenter,
                          padding:
                              const EdgeInsets.all(20).copyWith(bottom: 70),
                          child: CircleAvatar(
                            backgroundImage: NetworkImage(user.profilePic),
                            radius: 72,
                          ),
                        ),
                        if (uid == loginedUid)
                          Container(
                            alignment: Alignment.bottomCenter,
                            padding: const EdgeInsets.all(0),
                            child: ElevatedButton(
                              onPressed: () => navigateToEditUser(context),
                              style: ElevatedButton.styleFrom(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 20),
                              ),
                              child: const Text(
                                '프로필 수정',
                                style: TextStyle(fontSize: 14),
                              ),
                            ),
                          ),
                      ],
                    ),
                  ),
                  SliverPadding(
                    padding: const EdgeInsets.all(16),
                    sliver: SliverList(
                      delegate: SliverChildListDelegate(
                        [
                          Text(
                            user.addressName,
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Text(
                                '${user.name}',
                                style: const TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              SizedBox(
                                width: 5,
                              ),
                              Text(
                                getCommCdNm(
                                    CommonCode().classGbList, user.classGb),
                                style: TextStyle(
                                    fontWeight: FontWeight.w400, fontSize: 12),
                              )
                            ],
                          ),
                          if (user.positions.isNotEmpty) ...[
                            const SizedBox(height: 5),
                            SizedBox(
                              height: 20,
                              child: ListView.separated(
                                  scrollDirection: Axis.horizontal,
                                  itemCount: user.positions.length,
                                  itemBuilder:
                                      (BuildContext context, int index) {
                                    final position = user.positions[index];
                                    return Text(
                                      getCommCdNm(
                                          CommonCode().positionList, position),
                                      style: TextStyle(
                                          fontWeight: FontWeight.w700,
                                          fontSize: 14),
                                    );
                                  },
                                  separatorBuilder: (_, index) =>
                                      const Text(', ')),
                            ),
                          ],
                          const SizedBox(height: 10),
                          Text(user.introduce),
                          const SizedBox(
                            height: 50,
                          ),
                          Center(
                            child: Container(
                              width: 250,
                              height: 250,
                              child: SpiderChartUpdated(
                                labels: ['슛', '드리블', '리딩', '피지컬', '매너'],
                                data: [
                                  7,
                                  5,
                                  10,
                                  7,
                                  4,
                                ],
                                maxValue: 10,
                                // the maximum value that you want to represent (essentially sets the data scale of the chart)
                                colors: <Color>[
                                  Colors.red,
                                  Colors.green,
                                  Colors.blue,
                                  Colors.yellow,
                                  Colors.indigo,
                                ],
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ];
              },
              body: ref.watch(getUserPostsProvider(uid)).when(
                    data: (data) {
                      return ListView.builder(
                        itemCount: data.length,
                        itemBuilder: (BuildContext context, int index) {
                          final post = data[index];
                          return PostCard(post: post);
                        },
                      );
                    },
                    error: (error, stackTrace) {
                      return ErrorText(error: error.toString());
                    },
                    loading: () => const Loader(),
                  ),
            ),
            error: (error, stackTrace) => ErrorText(error: error.toString()),
            loading: () => const Loader(),
          ),
    );
  }
}
