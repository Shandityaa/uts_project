import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController controller = PageController();
  int currentIndex = 0;

  Future<void> finish() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('seen_onboarding', true);
    if (!mounted) return;
    Navigator.pushReplacementNamed(context, '/login');
  }

  @override
  Widget build(BuildContext context) {
    final pages = [
      "Selamat datang di Movie App UTS!",
      "Aplikasi ini menampilkan film populer dari TMDB.",
      "Login dengan Google untuk mulai menggunakan aplikasi.",
    ];

    return Scaffold(
      body: PageView.builder(
        controller: controller,
        itemCount: pages.length,
        onPageChanged: (i) => setState(() => currentIndex = i),
        itemBuilder: (_, index) {
          return Center(
            child: Padding(
              padding: const EdgeInsets.all(24),
              child: Text(
                pages[index],
                textAlign: TextAlign.center,
                style: const TextStyle(fontSize: 22),
              ),
            ),
          );
        },
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text("${currentIndex + 1}/${pages.length}"),
            ElevatedButton(
              onPressed: () {
                if (currentIndex == pages.length - 1) {
                  finish();
                } else {
                  controller.nextPage(
                    duration: const Duration(milliseconds: 300),
                    curve: Curves.easeInOut,
                  );
                }
              },
              child: Text(currentIndex == pages.length - 1
                  ? "Mulai"
                  : "Berikutnya"),
            ),
          ],
        ),
      ),
    );
  }
} 
// update