import 'package:flutter/material.dart';
import 'package:sikka_wallet/constants/assets.dart';

class WalletScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      bottomNavigationBar: _buildBottomNavBar(),
      body: Column(
        children: [
          _buildAppBar(),
          _buildBalanceCard(),
          _buildAnnouncementBanner(),
          _buildExchangeHistory(),
        ],
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
          Text("Wallet", style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.white)),
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

  Widget _buildBalanceCard() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Container(
        width: double.infinity,
        padding: EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(15),
          boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 8, spreadRadius: 2)],
        ),
        child: Column(
          children: [
            Image.asset(Assets.appLogo, height: 50), // Use your coin image
            SizedBox(height: 10),
            Text("SKX 0.00", style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
            SizedBox(height: 5),
            Text("Available SikkaX Coins", style: TextStyle(fontSize: 16, color: Colors.grey)),
            SizedBox(height: 20),
            ElevatedButton.icon(
              onPressed: () {},
              icon: Icon(Icons.swap_horiz, color: Color(0xFF7D26DE)),
              label: Text("Exchange Coins"),
              style: ElevatedButton.styleFrom(
                foregroundColor: Color(0xFF7D26DE),
                backgroundColor: Colors.white,
                side: BorderSide(color: Color(0xFF7D26DE)),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAnnouncementBanner() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Container(
        padding: EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: Color(0xFFEDE0F9),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Row(
          children: [
            Icon(Icons.campaign, color: Color(0xFF7D26DE)),
            SizedBox(width: 10),
            Expanded(
              child: Text(
                "📢 Our SikkaX Coin is launching soon! In next July, 2026 we are launching SikkaX publicly.",
                style: TextStyle(fontSize: 14, color: Color(0xFF7D26DE)),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildExchangeHistory() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("Exchange History", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          SizedBox(height: 5),
          Text("You did not make any coins exchange yet", style: TextStyle(fontSize: 14, color: Colors.grey)),
        ],
      ),
    );
  }

  Widget _buildBottomNavBar() {
    return BottomNavigationBar(
      selectedItemColor: Color(0xFF7D26DE),
      unselectedItemColor: Colors.grey,
      currentIndex: 2,
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
