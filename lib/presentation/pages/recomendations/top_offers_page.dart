import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

@RoutePage()  // ✅ Added RoutePage annotation
class TopOffersPage extends StatelessWidget {
  const TopOffersPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Top Offers"),
        backgroundColor: const Color(0xFF84C264),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => context.router.pop(), // ✅ Fixed navigation issue
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: GridView.builder(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 16,
            mainAxisSpacing: 16,
            childAspectRatio: 0.8,
          ),
          itemCount: 5,
          itemBuilder: (context, index) {
            return _buildOfferCard();
          },
        ),
      ),
    );
  }

  Widget _buildOfferCard() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
        boxShadow: const [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 4,
            spreadRadius: 2,
          ),
        ],
      ),
      child: Column(
        children: [
          Expanded(
            child: Image.asset(
              'assets/images/sample_product.png',
              fit: BoxFit.cover,
            ),
          ),
          const Text("Jin Ramen Mild", style: TextStyle(fontSize: 14)),
          const Text("48 som", style: TextStyle(fontSize: 14, color: Colors.red)),
        ],
      ),
    );
  }
}

extension on StackRouter {
  pop() {}
}
