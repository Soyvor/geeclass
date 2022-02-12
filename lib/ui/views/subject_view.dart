import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:geeclass/data/class_data.dart';
import 'package:geeclass/data/model/subject.dart';
import 'package:geeclass/ui/theme/app_color.dart';
import 'package:geeclass/ui/widgets/app_icon_buttton.dart';
import 'package:geeclass/ui/widgets/assignment_highlight.dart';
import 'package:geeclass/ui/widgets/stream_item.dart';
import 'package:geeclass/ui/widgets/subject_post.dart';

class SubjectView extends StatefulWidget {
  final Subject subject;

  const SubjectView({Key? key, required this.subject}) : super(key: key);

  @override
  State<SubjectView> createState() => _SubjectViewState();
}

class _SubjectViewState extends State<SubjectView> {
  int _activeIndex = 1;

  @override
  Widget build(BuildContext context) {
    final subjectStreams =
        streams.where((item) => item.subjectId == widget.subject.id).toList();
    final List<Map<String, dynamic>> menus = [
      {
        'index': 1,
        'icon': "assets/icons/stream.svg",
        'activeIcon': "assets/icons/stream-fill.svg",
        'title': "Stream"
      },
      {
        'index': 2,
        'icon': "assets/icons/assignment.svg",
        'activeIcon': "assets/icons/assignment-fill.svg",
        'title': "Assignment"
      },
      {
        'index': 3,
        'icon': "assets/icons/classmates.svg",
        'activeIcon': "assets/icons/classmates-fill.svg",
        'title': "Classmates"
      },
    ];

    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              Row(
                children: [
                  AppIconButton(
                    icon: SvgPicture.asset(
                      "assets/icons/back.svg",
                      width: 24,
                      height: 24,
                      color: AppColor.white,
                    ),
                    onTap: () {
                      // Navigate back
                      Navigator.of(context).pop();
                    },
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          widget.subject.name,
                          style: const TextStyle(
                            color: AppColor.white,
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        const SizedBox(height: 2),
                        Text(
                          widget.subject.desc,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                            color: AppColor.grey,
                            fontSize: 12,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 16),
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      AppIconButton(
                        icon: SvgPicture.asset(
                          "assets/icons/gmeet.svg",
                          width: 24,
                          height: 24,
                          color: AppColor.white,
                        ),
                        onTap: () {},
                      ),
                      const SizedBox(width: 8),
                      AppIconButton(
                        icon: SvgPicture.asset(
                          "assets/icons/info.svg",
                          width: 24,
                          height: 24,
                          color: AppColor.white,
                        ),
                        onTap: () {},
                      ),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 32),
              // Assignment highlight
              Row(
                children: assignments
                    .where((item) => item.subjectId == widget.subject.id)
                    .take(2)
                    .map(
                      (item) => Expanded(
                        child: AssignmentHighlight(
                          assignment: item,
                          onTap: (item) {},
                        ),
                      ),
                    )
                    .toList(),
              ),
              const SizedBox(height: 32),
              // Menu
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: menus
                    .map(
                      (item) => Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8),
                        child: InkWell(
                          borderRadius: BorderRadius.circular(16),
                          splashColor: (_activeIndex == item['index']
                                  ? Theme.of(context).primaryColor
                                  : AppColor.white)
                              .withOpacity(0.15),
                          highlightColor: (_activeIndex == item['index']
                                  ? Theme.of(context).primaryColor
                                  : AppColor.white)
                              .withOpacity(0.3),
                          onTap: () {
                            setState(() {
                              _activeIndex = item['index'];
                            });
                          },
                          child: AnimatedContainer(
                            curve: Curves.easeInOut,
                            duration: const Duration(milliseconds: 450),
                            padding: const EdgeInsets.symmetric(
                              horizontal: 12,
                              vertical: 8,
                            ),
                            decoration: BoxDecoration(
                              color: _activeIndex == item['index']
                                  ? Theme.of(context)
                                      .primaryColor
                                      .withOpacity(0.15)
                                  : Colors.transparent,
                              borderRadius: BorderRadius.circular(16),
                            ),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                SvgPicture.asset(
                                  _activeIndex == item['index']
                                      ? item['activeIcon']
                                      : item['icon'],
                                  color: _activeIndex == item['index']
                                      ? Theme.of(context).primaryColor
                                      : AppColor.white,
                                  width: 24,
                                  height: 24,
                                ),
                                _activeIndex == item['index']
                                    ? Row(
                                        children: [
                                          const SizedBox(width: 8),
                                          Text(
                                            item['title'],
                                            style: TextStyle(
                                              color: Theme.of(context)
                                                  .primaryColor,
                                              fontWeight: FontWeight.w600,
                                            ),
                                          ),
                                        ],
                                      )
                                    : const SizedBox.shrink(),
                              ],
                            ),
                          ),
                        ),
                      ),
                    )
                    .toList(),
              ),
              const SizedBox(height: 16),
              // Post
              const SubjectPost(),
              const SizedBox(height: 16),
              Expanded(
                child: ListView.builder(
                  physics: const BouncingScrollPhysics(),
                  itemCount: subjectStreams.length,
                  itemBuilder: (ctx, index) {
                    final stream = subjectStreams[index];
                    // Stream item
                    return StreamItem(stream: stream);
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
