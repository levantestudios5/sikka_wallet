import 'package:flutter/material.dart';
import 'package:sikka_wallet/constants/assets.dart';

class GamesScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      bottomNavigationBar: _buildBottomNavBar(),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildAppBar(),
            _buildSectionTitle("Our Popular Games 🔥"),
            _buildGameGrid(),
            _buildSectionTitle("Newly Released"),
            _buildGameGrid(),
            _buildPromotionBanner(),
            _buildSectionTitle("Top Rated Games"),
            _buildGameGrid(),
          ],
        ),
      ),
    );
  }

  Widget _buildAppBar() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [Color(0xFF7D26DE), Color(0xFFEDE0F9)],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text("Games", style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.white)),
          Row(
            children: [
              Icon(Icons.notifications, color: Colors.white, size: 28),
              SizedBox(width: 15),
              Icon(Icons.person, color: Colors.white, size: 28),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      child: Text(title, style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
    );
  }

  Widget _buildGameGrid() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: GridView.builder(
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        itemCount: 2, // Replace with actual game count
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 1.5,
          crossAxisSpacing: 10,
          mainAxisSpacing: 10,
        ),
        itemBuilder: (context, index) {
          return _buildGameCard();
        },
      ),
    );
  }

  Widget _buildGameCard() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 5)],
      ),
      child: Column(
        children: [
          Image.asset(Assets.cryptoCrush, height: 80), // Replace with your image
          SizedBox(height: 5),
          Text("Crypto Crush", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
          Text("Play to Earn coins!", style: TextStyle(fontSize: 12, color: Colors.grey)),
        ],
      ),
    );
  }

  Widget _buildPromotionBanner() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Container(
        padding: EdgeInsets.all(20),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          image: DecorationImage(
            image: AssetImage(Assets.cryptoCrush), // Replace with actual banner image
            fit: BoxFit.cover,
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Play and Earn!", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white)),
            SizedBox(height: 5),
            Text("It's simple! Play game and earn coins. Our most trending game on PlayStore.",
                style: TextStyle(fontSize: 14, color: Colors.white)),
            SizedBox(height: 15),
            ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.purple,
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
              ),
              child: Text("Play Now"),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildBottomNavBar() {
    return BottomNavigationBar(
      selectedItemColor: Color(0xFF7D26DE),
      unselectedItemColor: Colors.grey,
      currentIndex: 1,
      items: [
        BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
        BottomNavigationBarItem(icon: Icon(Icons.sports_esports), label: "Games"),
        BottomNavigationBarItem(icon: Icon(Icons.account_balance_wallet), label: "Wallet"),
        BottomNavigationBarItem(icon: Icon(Icons.star), label: "Ranks"),
        BottomNavigationBarItem(icon: Icon(Icons.article), label: "Feed"),
      ],
    );
  }
}
