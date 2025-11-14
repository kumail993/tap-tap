import 'package:tap_task/core/imports/common_imports.dart';

class HeroImage extends StatelessWidget {
  final String url;
  const HeroImage(this.url, {super.key});

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(22),
      child: Container(
        height: 520,
        decoration: BoxDecoration(
          image: DecorationImage(image: NetworkImage(url), fit: BoxFit.cover),
        ),
      ),
    );
  }
}
