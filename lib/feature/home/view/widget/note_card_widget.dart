import 'package:flutter/material.dart';
import 'package:hive_notes_app/core/const/app_colors.dart';
import 'package:hive_notes_app/core/const/app_size.dart';
import 'package:hive_notes_app/core/style/global_text_style.dart';
import 'package:hive_notes_app/feature/home/model/note_model.dart';


class NoteCardWidget extends StatelessWidget {
  final NoteModel note;
  final VoidCallback? onTap;
  final int index;

  const NoteCardWidget({
    super.key,
    required this.note,
    required this.index,
    this.onTap,
  });

  // Card Colors
  static const List<Color> cardColors = [
    Color(0xFFF4F8FF),
    Color(0xFFFFF8E8),
    Color(0xFFF7F4FF),
    Color(0xFFEFFBF4),
    Color(0xFFFFF1F5),
    Color(0xFFF3F3F3),
  ];

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        margin: EdgeInsets.only(bottom: getHeight(16)),
        padding: EdgeInsets.all(getWidth(16)),
        decoration: BoxDecoration(
          color: cardColors[index % cardColors.length],
          borderRadius: BorderRadius.circular(getWidth(16)),
          border: Border.all(
            color: note.isNew? Color(0xFFFF7A50) : Colors.transparent,
            width: 1.2,
          ),
        ),
        child: Stack(
          clipBehavior: Clip.none,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  note.title,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: globalTextStyle(
                    fontSize: 16,
                    color: AppColors.blackColor,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                SizedBox(height: getHeight(10)),
                Text(
                  note.description,
                  maxLines: 3,
                  overflow: TextOverflow.ellipsis,
                  style: globalTextStyle(
                    fontSize: 13,
                    color: AppColors.greyColor,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                SizedBox(height: getHeight(18)),
                Row(
                  children: [
                    Text(
                      note.date,
                      style: globalTextStyle(
                        fontSize: 13,
                        color: AppColors.greyColor,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ],
                ),
              ],
            ),
            if (note.isNew) _buildNewRibbon(),
          ],
        ),
      ),
    );
  }




  // Sits exactly on the card's top-right corner, clipped by the
  // rounded border so it looks tucked into the card edge.
  Widget _buildNewRibbon() {
    return Positioned(
      top: -15,
      right: -15,

      child: ClipPath(
        clipper: _CornerRibbonClipper(),
        child: Container(
          width: getWidth(56),
          height: getWidth(56),
          decoration: const BoxDecoration(
            color: Color(0xFFFF7A50),
          ),
          child: Align(
            alignment: const Alignment(0.55, -0.55),
            child: Transform.rotate(
              angle: 0.785398, // 45 degrees
              child: const Text(
                'New',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 11,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

/// Clips a square into a right-angled triangle so the ribbon
/// hugs the top-right corner of the card exactly.
class _CornerRibbonClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final radius = size.width * 0.28;
    return Path()
      ..moveTo(size.width - radius, 0)
      ..arcToPoint(
        Offset(size.width, radius),
        radius: Radius.circular(radius),
      )
      ..lineTo(size.width, size.height)
      ..lineTo(0, 0)
      ..close();
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) => false;
}

