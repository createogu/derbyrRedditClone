import 'dart:io';

import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:teambasketball/core/constants/common_code.dart';

import '../../../core/common/divider/title_divider.dart';
import '../../../core/common/error_text.dart';
import '../../../core/common/loader.dart';
import '../../../core/common/responsive/responsive.dart';
import '../../../core/common/selectAddress/select_adress_one_depth_view.dart';
import '../../../core/common/widgets/custom_text_form_area.dart';
import '../../../core/common/widgets/custom_text_form_field.dart';
import '../../../core/constants/constants.dart';
import '../../../core/constants/size.dart';
import '../../../core/utils.dart';
import '../../../theme/pallete.dart';
import '../../auth/controller/auth_controller.dart';
import '../controller/user_profile_controller.dart';
import '../widgets/player_height_slider_bottom_sheet_widget.dart';
import '../widgets/player_weight_slider_bottom_sheet_widget.dart';

class EditProfileScreen extends ConsumerStatefulWidget {
  final String uid;

  const EditProfileScreen({
    super.key,
    required this.uid,
  });

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _EditProfileScreenState();
}

class _EditProfileScreenState extends ConsumerState<EditProfileScreen> {
  File? bannerFile;
  File? profileFile;

  Uint8List? bannerWebFile;
  Uint8List? profileWebFile;
  late TextEditingController nameController;
  late TextEditingController introduceController;

  String? classGb;
  String? addressCode;
  String? addressName;
  String? genderGb;
  List<String> positions = [];
  double? weight;
  double? height;
  var address;

  @override
  void initState() {
    super.initState();
    nameController = TextEditingController(text: ref.read(userProvider)!.name);
    weight = ref.read(userProvider)!.weight;
    height = ref.read(userProvider)!.height;
    genderGb = ref.read(userProvider)!.genderGb;
    classGb = ref.read(userProvider)!.classGb;
    positions = ref.read(userProvider)!.positions;
    addressCode = ref.read(userProvider)!.addressCode;
    addressName = ref.read(userProvider)!.addressName;
    introduceController =
        TextEditingController(text: ref.read(userProvider)!.introduce);
  }

  @override
  void dispose() {
    super.dispose();
    nameController.dispose();
  }

  void selectBannerImage() async {
    final res = await pickImage();

    if (res != null) {
      if (kIsWeb) {
        setState(() {
          bannerWebFile = res.files.first.bytes;
        });
      } else {
        setState(() {
          bannerFile = File(res.files.first.path!);
        });
      }
    }
  }

  void selectProfileImage() async {
    final res = await pickImage();

    if (res != null) {
      if (kIsWeb) {
        setState(() {
          profileWebFile = res.files.first.bytes;
        });
      } else {
        setState(() {
          profileFile = File(res.files.first.path!);
        });
      }
    }
  }

  void save() {
    ref.read(userProfileControllerProvider.notifier).editCommunity(
          profileFile: profileFile,
          bannerFile: bannerFile,
          context: context,
          name: nameController.text.trim(),
          genderGb: genderGb ?? '',
          classGb: classGb ?? '',
          height: height ?? 170,
          weight: weight ?? 60,
          addressName: addressName ?? '',
          addressCode: addressCode ?? '',
          introduce: introduceController.text.trim(),
          positions: positions,
          bannerWebFile: bannerWebFile,
          profileWebFile: profileWebFile,
        );
  }

  void _onChangedPlayerHeight(double value) {
    setState(() {
      height = value;
    });
  }

  void _onChangedPlayerWeight(double value) {
    setState(() {
      weight = value;
    });
  }

  void _callbackAddress(value) {
    setState(() {
      addressName = value.name;
      addressCode = value.code;
    });
  }

  @override
  Widget build(BuildContext context) {
    final isLoading = ref.watch(userProfileControllerProvider);
    final currentTheme = ref.watch(themeNotifierProvider);

    return ref.watch(getUserDataProvider(widget.uid)).when(
          data: (user) => Scaffold(
            backgroundColor: currentTheme.colorScheme.background,
            appBar: AppBar(
              title: const Text('프로필 수정'),
              centerTitle: false,
              actions: [
                TextButton(
                  onPressed: save,
                  child: const Text('저장'),
                ),
              ],
            ),
            body: isLoading
                ? const Loader()
                : Responsive(
                    child: SingleChildScrollView(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          children: [
                            TitleDivider(
                              title: '프로필사진',
                              subTitle: '(타인에게 불쾌감을 주는 사진 사용 금지)',
                            ),
                            SizedBox(
                              height: 200,
                              child: Stack(
                                children: [
                                  GestureDetector(
                                    onTap: selectBannerImage,
                                    child: DottedBorder(
                                      borderType: BorderType.RRect,
                                      radius: const Radius.circular(10),
                                      dashPattern: const [10, 4],
                                      strokeCap: StrokeCap.round,
                                      color: currentTheme
                                          .textTheme.bodyMedium!.color!,
                                      child: Container(
                                        width: double.infinity,
                                        height: 150,
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                        ),
                                        child: bannerWebFile != null
                                            ? Image.memory(bannerWebFile!)
                                            : bannerFile != null
                                                ? Image.file(bannerFile!)
                                                : user.banner.isEmpty ||
                                                        user.banner ==
                                                            Constants
                                                                .bannerDefault
                                                    ? const Center(
                                                        child: Icon(
                                                          Icons
                                                              .camera_alt_outlined,
                                                          size: 40,
                                                        ),
                                                      )
                                                    : Image.network(
                                                        user.banner),
                                      ),
                                    ),
                                  ),
                                  Positioned(
                                    bottom: 10,
                                    left: 10,
                                    child: GestureDetector(
                                      onTap: selectProfileImage,
                                      child: profileWebFile != null
                                          ? CircleAvatar(
                                              backgroundImage:
                                                  MemoryImage(profileWebFile!),
                                              radius: 48,
                                            )
                                          : profileFile != null
                                              ? CircleAvatar(
                                                  backgroundImage:
                                                      FileImage(profileFile!),
                                                  radius: 48,
                                                )
                                              : CircleAvatar(
                                                  backgroundImage: NetworkImage(
                                                      user.profilePic),
                                                  radius: 48,
                                                ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            TitleDivider(
                              title: '닉네임',
                              subTitle: '(타인에게 불쾌감을 주는 닉네임 사용 금지)',
                            ),
                            CustomTextFormField(
                              textController: nameController,
                              hintText: '닉네임을 입력해 주세요.',
                              onChanged: (value) {},
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            TitleDivider(title: '성별'),
                            selectGender(),
                            const SizedBox(
                              height: 20,
                            ),
                            TitleDivider(title: '활동지역'),
                            selectAddress(context),
                            const SizedBox(
                              height: 20,
                            ),
                            TitleDivider(title: '종별'),
                            selectClass(),
                            const SizedBox(
                              height: 20,
                            ),
                            TitleDivider(
                              title: '포지션',
                              subTitle: '(다중선택 가능)',
                            ),
                            selectPosition(),
                            const SizedBox(
                              height: 20,
                            ),
                            TitleDivider(title: '키 / 몸무게'),
                            Row(
                              children: [
                                selectPlayerHeigth(),
                                const SizedBox(
                                  width: LARGE_GAP,
                                ),
                                selectPlayerWeight(),
                              ],
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            TitleDivider(title: '자기소개'),
                            CustomTextFormArea(
                              textController: introduceController,
                              onChanged: (value) {
                                setState(() {});
                              },
                              hintText: '바르고 고운말을 사용합시다.',
                            ),
                            const SizedBox(
                              height: 100,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
          ),
          loading: () => const Loader(),
          error: (error, stackTrace) => ErrorText(
            error: error.toString(),
          ),
        );
  }

  Container selectGender() {
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          for (final chip in CommonCode().genderList)
            Wrap(
              children: [
                ChoiceChip(
                  label: Text(
                    chip['comm_cd_nm'],
                    style: TextStyle(
                      fontSize: 14,
                    ),
                  ),
                  selected: genderGb == chip['comm_cd'],
                  onSelected: (value) {
                    setState(() {
                      genderGb = chip['comm_cd'];
                    });
                  },
                ),
                SizedBox(
                  width: 10,
                ),
              ],
            )
        ],
      ),
    );
  }

  Container selectClass() {
    return Container(
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            for (final chip in CommonCode().classGbList)
              Wrap(
                children: [
                  ChoiceChip(
                    label: Text(
                      chip['comm_cd_nm'],
                      style: TextStyle(
                        fontSize: 12,
                      ),
                    ),
                    selected: classGb == chip['comm_cd'],
                    onSelected: (value) {
                      setState(() {
                        classGb = chip['comm_cd'];
                      });
                    },
                  ),
                  SizedBox(
                    width: 10,
                  ),
                ],
              )
          ],
        ),
      ),
    );
  }

  Container selectPosition() {
    return Container(
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            for (final chip in CommonCode().positionList)
              Wrap(
                children: [
                  ChoiceChip(
                    label: Text(
                      chip['comm_cd_nm'],
                      style: TextStyle(
                        fontSize: 14,
                      ),
                    ),
                    selected: positions.contains(chip['comm_cd']),
                    onSelected: (value) {
                      List<String> tempPositions = [...positions];
                      if (!value) {
                        tempPositions.remove(chip['comm_cd']);
                      } else {
                        tempPositions.add(chip['comm_cd']);
                      }
                      setState(() {
                        //정렬해서 넣자
                        tempPositions.sort((a, b) => a.compareTo(b));
                        positions = tempPositions;
                      });
                    },
                  ),
                  SizedBox(
                    width: 10,
                  ),
                ],
              )
          ],
        ),
      ),
    );
  }

  Container selectPlayerHeigth() {
    return Container(
      width: (MediaQuery.of(context).size.width / 5) * 2,
      child: GestureDetector(
        onTapDown: (value) {
          openShowPlayerHeightModalBottomSheet(context);
        },
        child: Container(
          child: CustomTextFormField(
            isReadOnly: true,
            hintText: '${height} cm',
            onChanged: (value) {},
          ),
        ),
      ),
    );
  }

  Container selectPlayerWeight() {
    return Container(
      width: (MediaQuery.of(context).size.width / 5) * 2,
      child: GestureDetector(
        onTapDown: (value) {
          openShowPlayerWeightModalBottomSheet(context);
        },
        child: Container(
          child: CustomTextFormField(
            isReadOnly: true,
            hintText: '${weight} kg',
            onChanged: (value) {},
          ),
        ),
      ),
    );
  }

  void openShowPlayerHeightModalBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return PlayerHeightSliderBottomSheetWidget(
          p_playerHeight: height ?? 170,
          onChangedPlayerHeight: _onChangedPlayerHeight,
        );
      },
    );
  }

  void openShowPlayerWeightModalBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return PlayerWeightSliderBottomSheetWidget(
          p_playerWeight: weight ?? 70,
          onChangedPlayerWeight: _onChangedPlayerWeight,
        );
      },
    );
  }

  Container selectAddress(BuildContext context) {
    return Container(
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: (MediaQuery.of(context).size.width / 5) * 4,
              child: CustomTextFormField(
                isReadOnly: true,
                hintText: addressCode == null ? '내 동네를 설정해 주세요' : addressName,
                onChanged: (value) {},
              ),
            ),
            const SizedBox(
              width: SMALL_GAP,
            ),
            IconButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) {
                      return SelectAdressOneDepthView(
                          callback: _callbackAddress);
                    },
                  ),
                );
              },
              icon: Icon(Icons.search),
            ),
          ],
        ),
      ),
    );
  }
}
