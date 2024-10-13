import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hyshare/app/core/theme/color_theme.dart';
import 'package:hyshare/app/core/theme/text_theme.dart';
import 'package:hyshare/app/core/util/extension.dart';
import 'package:hyshare/app/data/models/ride.dart';
import 'package:hyshare/app/routes/route.dart';
import 'package:hyshare/app/widgets/theme_widget.dart';

class ShareCard extends StatelessWidget {
  const ShareCard({super.key, required this.ride});

  final Ride ride;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        await Get.toNamed(Routes.detail, arguments: ride);
      },
      child: Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: FGBPColors.mainColor),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("${ride.departureTime.formattedDateYMDHM} 출발", style: FGBPTextTheme.semiboldMain12.copyWith(color: FGBPColors.mainColor)),
                  Container(
                    padding: const EdgeInsets.all(4),
                    decoration: BoxDecoration(
                      color: ride.status.color,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Text(ride.status.name, style: FGBPTextTheme.semiboldMain10.copyWith(color: Colors.white)),
                  ),
                ],
              ),
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
                    FGBPText(ride.departue.split(",")[1], style: FGBPTextTheme.boldWhite14),
                    Text(ride.departue.split(",")[0], style: FGBPTextTheme.regular12.copyWith(color: FGBPColors.subColor)),
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
                    FGBPText(ride.destination.split(",")[1], style: FGBPTextTheme.boldWhite14),
                    Text(ride.destination.split(",")[0], style: FGBPTextTheme.regular12.copyWith(color: FGBPColors.subColor)),
                  ],
                ),
              ]),
              const SizedBox(height: 8),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Row(
                    children: [
                      Column(
                        children: [
                          const Icon(Icons.people, color: FGBPColors.mainColor),
                          Text("인원", style: FGBPTextTheme.medium8.copyWith(color: FGBPColors.mainColor)),
                        ],
                      ),
                      const SizedBox(width: 8),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          FGBPText("${ride.maxPassanger}명", style: FGBPTextTheme.boldWhite14),
                          Text("${ride.currentPassanger}/${ride.maxPassanger}", style: FGBPTextTheme.regular12.copyWith(color: FGBPColors.subColor)),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(width: 16),
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
                          FGBPText("${ride.estimatedCostPerPassanger.commaCost}원", style: FGBPTextTheme.boldWhite14),
                          Text("${(ride.estimatedCostPerPassanger ~/ (ride.currentPassanger == 0 ? 1 : ride.currentPassanger)).commaCost}원",
                              style: FGBPTextTheme.regular12.copyWith(color: FGBPColors.subColor)),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ],
          )),
    );
  }
}
