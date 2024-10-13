import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:hyshare/app/core/theme/color_theme.dart';
import 'package:hyshare/app/core/theme/text_theme.dart';
import 'package:hyshare/app/core/util/extension.dart';
import 'package:hyshare/app/data/models/ride.dart';
import 'package:hyshare/app/pages/detail/controller.dart';
import 'package:hyshare/app/widgets/button.dart';
import 'package:hyshare/app/widgets/theme_widget.dart';

class DetailPage extends GetView<DetailPageController> {
  const DetailPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SafeArea(
          child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Expanded(
              child: Column(mainAxisAlignment: MainAxisAlignment.start, crossAxisAlignment: CrossAxisAlignment.center, children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("${controller.ride.departureTime.formattedDateMDHM} 출발",
                        style: FGBPTextTheme.extraBold24.copyWith(color: FGBPColors.mainColor)),
                    Container(
                      padding: const EdgeInsets.all(4),
                      decoration: BoxDecoration(
                        color: controller.ride.status.color,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Text(controller.ride.status.name, style: FGBPTextTheme.extraBold22.copyWith(color: Colors.white)),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                const Divider(),
                const SizedBox(height: 8),
                Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
                  Column(
                    children: [
                      const Icon(Icons.location_on, color: FGBPColors.subColor),
                      Text("출발", style: FGBPTextTheme.medium8.copyWith(color: FGBPColors.subColor)),
                    ],
                  ),
                  const SizedBox(width: 8),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      FGBPText(controller.ride.departue.split(",")[1], style: FGBPTextTheme.boldWhite14),
                      Text(controller.ride.departue.split(",")[0], style: FGBPTextTheme.regular12.copyWith(color: FGBPColors.subColor)),
                    ],
                  ),
                ]),
                const SizedBox(height: 8),
                Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
                  Column(
                    children: [
                      const Icon(Icons.pin_drop, color: FGBPColors.mainColor),
                      Text("도착", style: FGBPTextTheme.medium8.copyWith(color: FGBPColors.mainColor)),
                    ],
                  ),
                  const SizedBox(width: 8),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      FGBPText(controller.ride.destination.split(",")[1], style: FGBPTextTheme.boldWhite14),
                      Text(controller.ride.destination.split(",")[0], style: FGBPTextTheme.regular12.copyWith(color: FGBPColors.subColor)),
                    ],
                  ),
                ]),
                const SizedBox(height: 8),
                const Divider(),
                const SizedBox(height: 8),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("참가자", style: FGBPTextTheme.extraBold22.copyWith(color: FGBPColors.mainColor)),
                    Text("${controller.ride.currentPassanger}/${controller.ride.maxPassanger}",
                        style: FGBPTextTheme.extraBold22.copyWith(color: FGBPColors.mainColor)),
                  ],
                ),
                const SizedBox(height: 8),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: controller.ride.passangers
                      .map((e) => Column(
                            children: [
                              Image.network(e.photoUrl, width: 40, height: 40),
                              const SizedBox(height: 8),
                              FGBPText(e.name, style: FGBPTextTheme.boldWhite14),
                            ],
                          ))
                      .toList(),
                ),
                const SizedBox(height: 8),
                const Divider(),
                const SizedBox(height: 8),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("비용", style: FGBPTextTheme.extraBold22.copyWith(color: FGBPColors.mainColor)),
                  ],
                ),
                const SizedBox(height: 8),
                Row(
                  children: [
                    Column(
                      children: [
                        const Icon(Icons.attach_money, color: FGBPColors.mainColor),
                        Text("비용", style: FGBPTextTheme.medium8.copyWith(color: FGBPColors.mainColor)),
                      ],
                    ),
                    const SizedBox(width: 8),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        FGBPText("${controller.ride.estimatedCostPerPassanger.commaCost}원", style: FGBPTextTheme.boldWhite14),
                        Text(
                            "${(controller.ride.estimatedCostPerPassanger ~/ (controller.ride.currentPassanger == 0 ? 1 : controller.ride.currentPassanger)).commaCost}원",
                            style: FGBPTextTheme.regular12.copyWith(color: FGBPColors.subColor)),
                      ],
                    ),
                  ],
                ),
              ]),
            ),
            if (controller.isOwner)
              Row(
                children: [
                  Expanded(child: FGBPMediumTextButton(text: "출발하기", onTap: controller.letsgo)),
                  const SizedBox(width: 8),
                  Expanded(child: FGBPMediumTextButton(text: "나가기", onTap: controller.cancelRide)),
                ],
              ),
            if (controller.isParticipant) FGBPMediumTextButton(text: "나가기", onTap: controller.cancelRide),
            if (!controller.isOwner &&
                !controller.isParticipant &&
                controller.ride.status != RideStatus.completed) //&& controller.ride.status != RideStatus.completed
              FGBPMediumTextButton(text: "신청하기", onTap: controller.selectRide),
          ],
        ),
      )),
    );
  }
}
