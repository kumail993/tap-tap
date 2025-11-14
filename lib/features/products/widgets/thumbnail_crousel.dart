import 'package:tap_task/core/imports/common_imports.dart';

class ThumbnailCarousel extends StatelessWidget {
  final List<String> images;
  const ThumbnailCarousel(this.images, {super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 85,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: images.length,
        separatorBuilder: (_, __) => const SizedBox(width: 12),
        itemBuilder: (context, i) {
          return ClipRRect(
            borderRadius: BorderRadius.circular(14),
            child: Container(
              width: 85,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: NetworkImage(images[i]),
                  fit: BoxFit.cover,
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
