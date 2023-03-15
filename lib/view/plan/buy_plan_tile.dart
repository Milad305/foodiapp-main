import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:get/get.dart';
import 'package:persian_number_utility/persian_number_utility.dart';
import 'package:salamatiman/getx/plan/plan.dart';
import 'package:salamatiman/model/plan/plan_model.dart';

import '../../utils/constants.dart';

class BuyPlanTile extends GetView<PlansGetx> {
  final PlansModel plan;
  final index;

  const BuyPlanTile({Key? key, required this.plan, required this.index})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        controller.planSelected(index);
      },
      child: Container(
        width: double.infinity,
        margin: EdgeInsets.only(bottom: 15),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(7),
        ),
        child: Column(
          children: [
            Container(
              width: double.infinity,
              child: Wrap(
                crossAxisAlignment: WrapCrossAlignment.center,
                children: [
                  FractionallySizedBox(
                    widthFactor: 0.7,
                    child: Wrap(
                      crossAxisAlignment: WrapCrossAlignment.center,
                      children: [
                        Obx(() {
                          return Container(
                            width: 17,
                            height: 17,
                            margin: const EdgeInsets.only(right: 10),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(50),
                                border: Border.all(
                                    color:
                                        controller.planSelected.value == index
                                            ? Color(0xFFe36436)
                                            : Colors.black87,
                                    width: 1.5),
                                color: controller.planSelected.value == index
                                    ? Color(0xFFe36436)
                                    : Colors.transparent),
                          );
                        }),
                        SizedBox(
                          width: 70,
                          height: 70,
                          child: Image.network(
                              "https://${Constants.BaseUrl}/${plan.img}",
                              fit: BoxFit.contain),
                        ),
                        const SizedBox(
                          width: 15,
                        ),
                        Text(
                          plan.title.toString(),
                          style: TextStyle(fontSize: 19),
                          maxLines: 1,
                        )
                      ],
                    ),
                  ),
                  FractionallySizedBox(
                    widthFactor: 0.3,
                    child: Container(
                      height: 80,
                      child: Column(
                        children: [
                          Text(
                              "${plan.price!.toStringAsFixed(0).toString().toPersianDigit()}",
                              style: const TextStyle(
                                fontSize: 25,
                                color: Color(0xFFe36436),
                              )),
                          const Text("هزار تومان",
                              style: TextStyle(
                                fontSize: 15,
                                color: Color(0xFFe36436),
                              ))
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                right: 5,
                left: 5,
                bottom: 7,
              ),
              child: FractionallySizedBox(
                widthFactor: 1,
                child: Text(plan.description.toString()),
              ),
            ),
            Obx(() {
              if (controller.planSelected.value != index) {
                return Container();
              }
              return TweenAnimationBuilder(
                duration: Duration(milliseconds: 200),
                tween: Tween<double>(
                    begin: 0,
                    end: controller.planSelected.value == index ? 1 : 0),
                builder: (BuildContext context, double value, child) {
                  return Transform.scale(
                    alignment: Alignment.topCenter,
                    scaleY: value,
                    child: FractionallySizedBox(
                      widthFactor: 1,
                      child: Html(data: '''${plan.features}'''),
                    ),
                  );
                },
              );
            }),
          ],
        ),
      ),
    );
  }
}
