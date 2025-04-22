class OnboardingModel {
  final String imagePath;
  final String title;
  final String subtitle;

  OnboardingModel({
    required this.imagePath,
    required this.title,
    required this.subtitle,
  });
}

final List<OnboardingModel> pages = [
  OnboardingModel(
    imagePath: 'assets/images/onb_1.png',
    title: 'Welcome to\nSnap Shop',
    subtitle:
        'Your campus store—digitized. Browse, order, and stay updated wherever you are',
  ),
  OnboardingModel(
    imagePath: 'assets/images/onb_2.png',
    title: 'Browse Campus Essentials',
    subtitle: 'From snacks to stationery—find everything you need in one place',
  ),
  OnboardingModel(
    imagePath: 'assets/images/onb_3.png',
    title: 'Manage Your Balance Effortlessly',
    subtitle:
        'Track your purchases, monitor your debt, and get notified about payment deadlines',
  ),
];
