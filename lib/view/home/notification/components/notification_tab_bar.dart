/// File: notification_tab_bar.dart
/// Purpose: 알림 탭 화면에서 사용할 커스터마이즈된 TabBar 위젯을 제공하여 탭 전환 및 스타일을 관리
/// Author: 박민준
/// Created: 2025-01-02
/// Last Modified: 2025-01-30 by 강희

import 'package:flutter/material.dart';
import 'package:readventure/theme/font.dart';
import '../../../../theme/theme.dart';

class NotificationTabBar extends StatelessWidget implements PreferredSizeWidget {
  final TabController tabController;

  const NotificationTabBar({Key? key, required this.tabController}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final customColors = Theme.of(context).extension<CustomColors>()!;

    return AnimatedBuilder(
      animation: tabController,
      builder: (context, _) {
        return Column(
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 0, 16, 0),// 탭 전체의 패딩
              child: TabBar(
                labelPadding: EdgeInsets.only(right: 8), // 탭 간의 패딩!!!!
                dividerColor: Colors.transparent, // Divider 제거
                controller: tabController,
                isScrollable: true,
                indicator: BoxDecoration(
                  color: customColors.primary, // 선택된 탭의 배경색
                  borderRadius: BorderRadius.circular(12), // 선택된 탭의 둥근 모서리
                ),
                tabAlignment: TabAlignment.start,
                tabs: List.generate(tabController.length, (index) {
                  final isSelected = tabController.index == index;
                  return _buildTab(
                    context,
                    text: ['전체', '안읽음', '코스', '보상', '시스템'][index],
                    isSelected: isSelected,
                    index: index, // 인덱스를 전달
                  );
                }),
              ),
            ),
            const SizedBox(height: 16), // TabBar 아래 16픽셀 공간 추가
          ],
        );
      },
    );
  }

  Widget _buildTab(BuildContext context, {required String text, required bool isSelected, required int index}) {
    final customColors = Theme.of(context).extension<CustomColors>()!;

    return InkWell(
      borderRadius: BorderRadius.circular(12), // 리플 효과에 둥근 모서리 적용
      onTap: () {
        tabController.animateTo(index); // 탭 클릭 시 해당 인덱스로 애니메이션 효과와 함께 전환
      },
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
        alignment: Alignment.center,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12), // 둥근 모서리
          border: Border.all(
            color: isSelected
                ? customColors.primary ?? Colors.blue // 선택된 탭의 테두리 색상
                : customColors.neutral90 ?? Colors.grey, // 선택되지 않은 탭의 테두리 색상
          ),
        ),
        child: Text(
          text,
          textAlign: TextAlign.center,
          style: body_xsmall_semi(context).copyWith(
            color: isSelected ? customColors.white : customColors.neutral60, // 텍스트 색상을 동적으로 변경
          ),
        ),
      ),
    );
  }



  @override
  Size get preferredSize => const Size.fromHeight(58); // TabBar 높이 설정
}
