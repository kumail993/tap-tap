import 'package:tap_task/core/functions/supabase_signout.dart';
import 'package:tap_task/core/imports/common_imports.dart';
import 'package:tap_task/core/widgets/custom_text.dart';

class CustomAppBar extends StatelessWidget {
  const CustomAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    // This AppBar is designed for the desktop/web layout (right side content area).
    return Container(
      height: 65, // Sleek, reduced height
      padding: const EdgeInsets.symmetric(horizontal: 28),
      decoration: BoxDecoration(
        // Clean white background to contrast with the dark sidebar and content area
        color: Colors.white,
        border: const Border(
          bottom: BorderSide(
            color: Colors.black12,
            width: 0.5,
          ), // Subtle separator line
        ),
        boxShadow: [
          // Minimal shadow for a modern floating effect
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // Use this area for a dynamic page title or greeting, as 'Tap Task' is in the sidebar.
          const CustomText(
            title: 'Dashboard Overview', // Example Contextual Title
            fontSize: 18,
            fontWeight: FontWeight.w600,
            color: Colors.black87,
          ),

          const Spacer(),

          // Modernized Logout Icon
          MouseRegion(
            cursor: SystemMouseCursors.click,
            child: GestureDetector(
              onTap: () => logout(context),
              child: Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  // Light background and subtle border for the icon button
                  color: Colors.grey.shade100,
                  shape: BoxShape.circle,
                  border: Border.all(color: Colors.grey.shade200, width: 0.5),
                ),
                child: const Icon(
                  Icons.logout,
                  color: Colors.black54, // Darker icon for contrast on white
                  size: 20,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
