import 'package:get/get.dart';
import 'package:hyshare/app/core/theme/color_theme.dart';
import 'package:hyshare/app/core/theme/text_theme.dart';
import 'package:flutter/material.dart';
import 'package:hyshare/app/pages/add/controller.dart';
import 'package:hyshare/app/widgets/button.dart';

import '../../widgets/theme_widget.dart';

class AddPage extends GetView<AddPageController> {
  const AddPage({super.key});

  @override
  Widget build(BuildContext context) {
    Color color = !context.isDarkMode ? Colors.white : Colors.black;
    Color reverseColor = context.isDarkMode ? Colors.white : Colors.black;
    return Scaffold(
      appBar: AppBar(),
      body: SafeArea(
          child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(child: Obx(() => _placeCard("출발지", controller.departure.value, color))),
                      const SizedBox(width: 16),
                      Expanded(child: Obx(() => _placeCard("도착지", controller.destination.value, color))),
                    ],
                  ),
                  const SizedBox(height: 16),
                  GestureDetector(
                    onTap: () {
                      Get.dialog(
                        Dialog(
                          child: Container(
                            height: 250,
                            decoration: BoxDecoration(
                              color: color,
                              borderRadius: BorderRadius.circular(16),
                            ),
                            child: Column(
                              children: [
                                Expanded(
                                  child: Row(
                                    children: [
                                      Expanded(
                                        child: SizedBox(
                                          height: 125,
                                          child: ListWheelScrollView(
                                            physics: const FixedExtentScrollPhysics(),
                                            controller: FixedExtentScrollController(initialItem: controller.month.value - 1),
                                            onSelectedItemChanged: (value) => controller.month.value = value + 1,
                                            itemExtent: 50,
                                            diameterRatio: 1.5,
                                            children: [
                                              for (var i = 1; i < 13; i++)
                                                FGBPText(
                                                  '$i 월',
                                                  style: FGBPTextTheme.semiboldGrey16.copyWith(color: color),
                                                ),
                                            ],
                                          ),
                                        ),
                                      ),
                                      Expanded(
                                        child: SizedBox(
                                          height: 125,
                                          child: ListWheelScrollView(
                                            physics: const FixedExtentScrollPhysics(),
                                            controller: FixedExtentScrollController(initialItem: controller.day.value - 1),
                                            onSelectedItemChanged: (value) => controller.day.value = value + 1,
                                            itemExtent: 50,
                                            diameterRatio: 1.5,
                                            children: [
                                              for (var i = 1; i < 32; i++)
                                                FGBPText(
                                                  '$i 일',
                                                  style: FGBPTextTheme.semiboldGrey16.copyWith(color: color),
                                                ),
                                            ],
                                          ),
                                        ),
                                      ),
                                      Expanded(
                                        child: SizedBox(
                                          height: 125,
                                          child: ListWheelScrollView(
                                            physics: const FixedExtentScrollPhysics(),
                                            controller: FixedExtentScrollController(initialItem: controller.hour.value),
                                            useMagnifier: true,
                                            onSelectedItemChanged: (value) => controller.hour.value = value,
                                            itemExtent: 50,
                                            children: [
                                              for (var i = 0; i < 24; i++)
                                                FGBPText(
                                                  '$i 시',
                                                  style: FGBPTextTheme.semiboldGrey16.copyWith(color: color),
                                                ),
                                            ],
                                          ),
                                        ),
                                      ),
                                      Expanded(
                                        child: SizedBox(
                                          height: 125,
                                          child: ListWheelScrollView(
                                            physics: const FixedExtentScrollPhysics(),
                                            controller: FixedExtentScrollController(initialItem: controller.minute.value),
                                            onSelectedItemChanged: (value) => controller.minute.value = value,
                                            itemExtent: 50,
                                            diameterRatio: 1.5,
                                            children: [
                                              for (var i = 0; i < 60; i++)
                                                FGBPText(
                                                  '$i 분',
                                                  style: FGBPTextTheme.semiboldGrey16.copyWith(color: color),
                                                ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: FGBPMediumTextButton(
                                    text: "확인",
                                    onTap: () {
                                      controller.setDate();
                                      Get.back();
                                    },
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                    child: Container(
                      width: double.infinity,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(color: FGBPColors.mainColor),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(16),
                        child: Column(
                          children: [
                            Text("출발 일시", style: FGBPTextTheme.boldGrey12.copyWith(color: FGBPColors.mainColor)),
                            const SizedBox(height: 4),
                            Obx(() => FGBPText(controller.formattedDate, style: FGBPTextTheme.bold20)),
                          ],
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  GestureDetector(
                    onTap: () {
                      Get.dialog(Dialog(
                        child: Container(
                          height: 250,
                          decoration: BoxDecoration(
                            color: color,
                            borderRadius: BorderRadius.circular(16),
                          ),
                          child: Column(
                            children: [
                              Expanded(
                                child: Row(
                                  children: [
                                    Expanded(
                                      child: SizedBox(
                                        height: 125,
                                        child: ListWheelScrollView(
                                          physics: const FixedExtentScrollPhysics(),
                                          controller: FixedExtentScrollController(initialItem: controller.maxParticipants.value - 1),
                                          onSelectedItemChanged: (value) => controller.maxParticipants.value = value + 1,
                                          itemExtent: 50,
                                          diameterRatio: 1.5,
                                          children: [
                                            for (var i = 1; i < 5; i++)
                                              FGBPText(
                                                '$i 명',
                                                style: FGBPTextTheme.semiboldGrey16.copyWith(color: color),
                                              ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: FGBPMediumTextButton(
                                  text: "확인",
                                  onTap: () {
                                    Get.back();
                                  },
                                ),
                              ),
                            ],
                          ),
                        ),
                      ));
                    },
                    child: Container(
                      width: double.infinity,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(color: FGBPColors.mainColor),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(16),
                        child: Column(
                          children: [
                            Text("참가 인원", style: FGBPTextTheme.boldGrey12.copyWith(color: FGBPColors.mainColor)),
                            const SizedBox(height: 4),
                            Obx(() => FGBPText("${controller.maxParticipants}명", style: FGBPTextTheme.bold20)),
                          ],
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  GestureDetector(
                    onTap: () {},
                    child: GestureDetector(
                      onTap: () {
                        Get.dialog(Dialog(
                          child: Container(
                            height: 250,
                            decoration: BoxDecoration(
                              color: color,
                              borderRadius: BorderRadius.circular(16),
                            ),
                            child: Column(
                              children: [
                                Expanded(
                                    child: Row(
                                  children: [
                                    Expanded(
                                      child: SizedBox(
                                        height: 125,
                                        child: ListWheelScrollView(
                                          physics: const FixedExtentScrollPhysics(),
                                          controller: FixedExtentScrollController(initialItem: controller.cost.value - 1),
                                          onSelectedItemChanged: (value) => controller.cost.value = value + 1,
                                          itemExtent: 50,
                                          diameterRatio: 1.5,
                                          children: [
                                            for (var i = 1; i < 100; i++)
                                              FGBPText(
                                                '${i * 1000}원',
                                                style: FGBPTextTheme.semiboldGrey16.copyWith(color: color),
                                              ),
                                          ],
                                        ),
                                      ),
                                    )
                                  ],
                                )),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: FGBPMediumTextButton(
                                    text: "확인",
                                    onTap: () {
                                      Get.back();
                                    },
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ));
                      },
                      child: Container(
                        width: double.infinity,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(16),
                          border: Border.all(color: FGBPColors.mainColor),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(16),
                          child: Column(
                            children: [
                              Text("총 예상 비용", style: FGBPTextTheme.boldGrey12.copyWith(color: FGBPColors.mainColor)),
                              const SizedBox(height: 4),
                              Obx(() => FGBPText("${controller.commaCost}원", style: FGBPTextTheme.bold20)),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                ],
              ),
            ),
            controller.obx(
                (_) => Obx(
                      () => FGBPKeyboardReactiveButton(
                        disabled: !controller.isValidate,
                        onTap: controller.shareRide,
                        child: const Text("공유하기", style: TextStyle(color: FGBPColors.white, fontSize: 16, fontWeight: FontWeight.w500)),
                      ),
                    ),
                onLoading: FGBPKeyboardReactiveButton(
                  onTap: () {},
                  child: const CircularProgressIndicator(),
                ))
          ],
        ),
      )),
    );
  }

  Widget _placeCard(String title, String place, Color color) {
    List<String> detailPlace = place.split(",");

    return GestureDetector(
      onTap: () {
        Get.bottomSheet(
          Container(
            height: 400,
            decoration: BoxDecoration(
              color: color,
              borderRadius: const BorderRadius.only(topLeft: Radius.circular(16), topRight: Radius.circular(16)),
            ),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(title, style: FGBPTextTheme.bold20.copyWith(color: FGBPColors.mainColor)),
                      GestureDetector(
                          onTap: () {
                            Get.back();
                          },
                          child: const Icon(Icons.close))
                    ],
                  ),
                ),
                Expanded(
                  child: ListView.builder(
                    itemCount: controller.places.length,
                    itemBuilder: (context, index) {
                      List<String> place = controller.places[index].split(",");
                      return ListTile(
                        title: FGBPText(place[1], style: FGBPTextTheme.bold20),
                        subtitle: FGBPText(place[0], style: FGBPTextTheme.regular12),
                        onTap: () {
                          if (title == "출발지") {
                            controller.setDeparture(controller.places[index]);
                          } else {
                            controller.setDestination(controller.places[index]);
                          }
                          Get.back();
                        },
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        );
      },
      child: Container(
        height: 120,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: FGBPColors.mainColor),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(title, style: FGBPTextTheme.boldGrey12.copyWith(color: FGBPColors.mainColor)),
              FGBPText(detailPlace.isNotEmpty ? detailPlace[1] : "", style: FGBPTextTheme.bold20),
              FGBPText(detailPlace.isNotEmpty ? detailPlace[0] : "", style: FGBPTextTheme.regular12),
            ],
          ),
        ),
      ),
    );
  }
}
