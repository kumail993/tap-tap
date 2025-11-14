import 'dart:ui';

import 'package:tap_task/core/imports/common_imports.dart';

class GlassTopBar extends StatelessWidget {
  const GlassTopBar({super.key});

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 28, sigmaY: 28),
        child: Container(
          height: 65,
          width: double.infinity,
          padding: const EdgeInsets.symmetric(horizontal: 24),
          decoration: BoxDecoration(
            color: Colors.white.withValues(alpha: 0.05),
            border: Border(
              bottom: BorderSide(color: Colors.white.withValues(alpha: 0.15)),
            ),
          ),
          child: Row(
            children: [
              const CustomText(
                title: "Dashboard",
                fontSize: 20,
                fontWeight: FontWeight.w700,
                color: Colors.white,
              ),
              const Spacer(),
              Icon(
                Icons.notifications_none_rounded,
                color: Colors.white.withValues(alpha: 0.9),
              ),
              horizontalSpace(20),
              CircleAvatar(
                radius: 18,
                backgroundColor: Colors.white.withValues(alpha: 0.2),
                child: const Icon(Icons.person, color: Colors.white),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
