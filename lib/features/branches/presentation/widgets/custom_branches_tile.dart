import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../../core/constants/app_colors.dart';

class CustomBranchesTile extends StatelessWidget {
  final String name;
  final String image;
  final String phones;
  final String socialmediaInstagram;
  final String socialmediaFacebook;
  final String location;

  const CustomBranchesTile({
    super.key,
    required this.name,
    required this.phones,
    required this.image,
    required this.socialmediaInstagram,
    required this.socialmediaFacebook,
    required this.location,
  });

  Future<void> _launchURL(String url) async {
    final uri = Uri.tryParse(url);
    if (uri != null && await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 10),
      decoration: BoxDecoration(
        color: AppColors.smooky2,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: AppColors.black1.withOpacity(0.3),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          _Cell(flex: 4, child: Text(name, textAlign: TextAlign.center, style: const TextStyle(color: Colors.white))),
          _Cell(flex: 4, child: Text(phones, textAlign: TextAlign.center, style: const TextStyle(color: Colors.white))),
          _Cell(
            flex: 4,
            child: Center(
              child: ClipOval(
                child: image.isNotEmpty
                    ? Image.network(
                  image,
                  width: 70,
                  height: 70,
                  fit: BoxFit.cover,
                  errorBuilder: (_, __, ___) => const Icon(Icons.broken_image, color: Colors.white, size: 40),
                )
                    : const Icon(Icons.image_not_supported, color: Colors.white, size: 40),
              ),
            ),
          ),
          _Cell(
            flex: 3,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                if (socialmediaInstagram.isNotEmpty)
                  GestureDetector(
                    onTap: () => _launchURL(socialmediaInstagram),
                    child: const Text(
                      'Instagram',
                      style: TextStyle(
                        color: Colors.blueAccent,
                        decoration: TextDecoration.underline,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                const SizedBox(height: 4),
                if (socialmediaFacebook.isNotEmpty)
                  GestureDetector(
                    onTap: () => _launchURL(socialmediaFacebook),
                    child: const Text(
                      'Facebook',
                      style: TextStyle(
                        color: Colors.blueAccent,
                        decoration: TextDecoration.underline,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
              ],
            ),
          ),
          _Cell(
            flex: 2,
            child: location.isNotEmpty
                ? GestureDetector(
              onTap: () => _launchURL(location),
              child: const Text(
                "رابط الموقع",
                style: TextStyle(
                  color: Colors.blueAccent,
                  decoration: TextDecoration.underline,
                ),
                textAlign: TextAlign.center,
              ),
            )
                : const Text(
              '—',
              style: TextStyle(color: AppColors.white),
              textAlign: TextAlign.center,
            ),
          ),
        ],
      ),
    );
  }
}

class _Cell extends StatelessWidget {
  final int flex;
  final Widget child;
  const _Cell({required this.flex, required this.child});

  @override
  Widget build(BuildContext context) {
    return Expanded(flex: flex, child: child);
  }
}
