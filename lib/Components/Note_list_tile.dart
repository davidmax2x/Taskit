import 'package:flutter/widgets.dart';

class NoteTile extends StatelessWidget {
  const NoteTile(
      {Key? key,
      required this.time,
      required this.title,
      required this.courseTitle,
      required this.width})
      : super(key: key);
  final String time;
  final String title;
  final String courseTitle;
  final double width;
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 30,
      width: width,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5),
        // boxShadow: BoxShadow(
        //   color: Color()
        // )
      ),
      child: Row(
        children: [
          Column(
            children: [
              Text(title),
              Text(courseTitle),
            ],
          ),
          Text(time)
        ],
      ),
    );
  }
}
