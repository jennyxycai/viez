import 'package:flutter/material.dart';
import 'package:viez/core/domain/entity/user_activity_entity.dart';
import 'package:viez/core/ui/widgets/activity_card.dart';
import 'package:viez/core/ui/widgets/placeholder_card.dart';
import 'package:viez/core/utils/navigation_options.dart';
import 'package:viez/screens/add_activity_screen.dart';

class ActivityVerticalList extends StatelessWidget {
  final DateTime day;
  final String title;
  final List<UserActivityEntity> userActivityList;
  final Function(BuildContext, UserActivityEntity) onItemLongPressedCallback;

  const ActivityVerticalList(
      {Key? key,
      required this.day,
      required this.title,
      required this.userActivityList,
      required this.onItemLongPressedCallback})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
          alignment: Alignment.centerLeft,
          child: Row(
            children: [
              Icon(UserActivityEntity.getIconData(),
                  size: 24, color: Theme.of(context).colorScheme.onBackground),
              const SizedBox(width: 4.0),
              Text(
                title,
                style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    color: Theme.of(context).colorScheme.onBackground),
              ),
            ],
          ),
        ),
        SizedBox(
          height: 160,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount:
                userActivityList.length + 1, // List length + placeholder card
            itemBuilder: (BuildContext context, int index) {
              final firstListElement = index == 0 ? true : false;
              if (index == userActivityList.length) {
                return PlaceholderCard(
                    day: day,
                    onTap: () => _onPlaceholderCardTapped(context),
                    firstListElement: firstListElement);
              } else {
                final userActivity = userActivityList[index];
                return ActivityCard(
                  activityEntity: userActivity,
                  onItemLongPressed: onItemLongPressedCallback,
                  firstListElement: firstListElement,
                );
              }
            },
          ),
        )
      ],
    );
  }

  void _onPlaceholderCardTapped(BuildContext context) {
    Navigator.of(context).pushNamed(NavigationOptions.addActivityRoute,
        arguments: AddActivityScreenArguments(day: day));
  }
}
