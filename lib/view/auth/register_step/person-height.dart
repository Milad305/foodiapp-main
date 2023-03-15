import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:persian_number_utility/persian_number_utility.dart';
import 'package:salamatiman/getx/auth/auth-getter.dart';
import 'package:salamatiman/utils/constants.dart';

class PersonHeight extends GetView<AuthGetter> {
  final double parentHeight;
  final double itemExtent;
  var itemHide;
  PersonHeight(
      {Key? key,
      required this.parentHeight,
      required this.itemExtent,
      required this.itemHide})
      : super(key: key) {
    itemHide = itemHide + 1;
  }

  @override
  int _itemCount = 177;
  int _minValue = 0;
  int minValueStart = 50;
  int _step = 1;
  int _value = 0;
  int _curentIndex = 50;
  bool _haptics = false;

  late ScrollController _scrollController;
  bool get isScrolling => _scrollController.position.isScrollingNotifier.value;

  int get additionalItemsOnEachSide => (_itemCount - 1) ~/ 2;

  @override
  Widget build(BuildContext context) {
    final initialOffset = (_curentIndex - _minValue) ~/ _step * itemExtent;
    _scrollController = ScrollController(initialScrollOffset: initialOffset);
    _scrollController.addListener(_scrollListener);
    return Container(
      alignment: Alignment.topRight,
      width: double.infinity,
      height: parentHeight,
      child: NotificationListener<ScrollEndNotification>(
        onNotification: (not) {
          if (not.dragDetails?.primaryVelocity == 0) {
            Future.microtask(() => _maybeCenterValue());
          }
          return true;
        },
        child: Stack(
          children: [
            Positioned(
              bottom: 0,
              left: 0,
              child: Align(
                alignment: Alignment.bottomLeft,
                child: Obx(() => Image.asset(
                      controller.gender.value > 0
                          ? 'assets/images/woman.png'
                          : 'assets/images/man.png',
                      height: parentHeight -
                          (itemExtent * itemHide) +
                          (itemExtent / 2) +
                          2,
                      alignment: Alignment.bottomLeft,
                    )),
              ),
            ),
            ListView.builder(
              controller: _scrollController,
              itemCount: _itemCount,
              itemExtent: itemExtent,
              reverse: true,
              padding: EdgeInsets.only(
                  bottom: parentHeight - (itemExtent * itemHide)),
              itemBuilder: (context, index) {
                return index > _itemCount - itemHide
                    ? Container()
                    : Container(
                        alignment: Alignment.centerRight,
                        child: Wrap(
                          crossAxisAlignment: WrapCrossAlignment.center,
                          children: [
                            Container(
                              width: 30,
                              height: 2,
                              color: Colors.grey,
                            ),
                            Container(
                              alignment: Alignment.center,
                              width: 40,
                              child: Text(
                                (index + 50).toString().toPersianDigit(),
                                style: TextStyle(fontSize: 16.sp),
                              ),
                            )
                          ],
                        ),
                      );
              },
            ),
            Positioned(
              top: ((itemExtent * itemHide) - (itemExtent / 2) - 1) - 9,
              right: 0,
              child: CustomPaint(
                painter: RPSCustomPainter(),
                child: Container(
                  width: 15,
                  height: 20,
                  clipBehavior: Clip.none,
                  alignment: Alignment.centerRight,
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.only(
                top: (itemExtent * itemHide) - (itemExtent / 2) - 1,
              ),
              width: double.infinity,
              height: 2,
              color: Constants.textSelected,
            ),
          ],
        ),
      ),
    );
  }

  void _scrollListener() {
    var indexOfMiddleElement = (_scrollController.offset / itemExtent).round();
    indexOfMiddleElement = indexOfMiddleElement.clamp(0, _itemCount - 1);

    final intValueInTheMiddle =
        _intValueFromIndex(indexOfMiddleElement + additionalItemsOnEachSide);
    if (controller.personHeightSize.value != intValueInTheMiddle) {
      onChangeValue(intValueInTheMiddle);
      if (_haptics) {
        //HapticFeedback.selectionClick();
      }
    }

    Future.delayed(
      Duration(milliseconds: 100),
      () => _maybeCenterValue(),
    );
  }

  int _intValueFromIndex(int index) {
    index -= additionalItemsOnEachSide;
    index %= _itemCount;
    return _minValue + index * _step;
  }

  void onChangeValue(val) {
    controller.personHeightSize(val);
  }

  void _maybeCenterValue() {
    if (_scrollController.hasClients && !isScrolling) {
      int diff = controller.personHeightSize.value - _minValue;
      int index = diff ~/ _step;
      _scrollController.animateTo(
        controller.personHeightSize.value * itemExtent,
        duration: Duration(milliseconds: 300),
        curve: Curves.easeOutCubic,
      );
    }
  }
}

class RPSCustomPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    Paint paint0 = Paint()
      ..color = Constants.textSelected
      ..style = PaintingStyle.fill
      ..strokeWidth = 1;

    Path path0 = Path();
    path0.moveTo(0, size.height * 0.4952000);
    path0.lineTo(size.width, size.height);
    path0.lineTo(size.width, 0);
    path0.lineTo(0, size.height * 0.4974000);

    canvas.drawPath(path0, paint0);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
