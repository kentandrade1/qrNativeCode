// ignore: file_names
import 'package:flutter/material.dart';

import 'package:seek_app/features/home/widgets/MyDrawer.dart';
import 'package:seek_app/features/Scan/qr_scanner.dart';
import 'package:seek_app/features/home/widgets/headerView.dart';
import 'package:seek_app/features/nativeScanner/scanner_native.dart';
import 'package:seek_app/models/user.dart';
import 'package:seek_app/features/Scan/scanInfoView.dart';
import 'package:seek_app/services/dataBaseHelper.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:seek_app/models/scanner.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _currentIndex = 2;
  late final PageController _pageController;
  String _username = "";
  List<Scan> _scannedCodes = [];

  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: 2);
    _loadUserData();
    //_updateBalance();
    _loadScannedCodes();
  }

  _loadUserData() async {
    User? user = await DatabaseHelper().getUser();
    setState(() {
      _username = user?.username ?? "Usuario";
    });
  }

  _updateBalance() async {
    _loadScannedCodes();
    setState(() {
      _onItemTapped(2);
    });
  }

  _updateScans() async {
    _loadScannedCodes();
  }

  _loadScannedCodes() async {
    List<Scan> scannedCodes = await DatabaseHelper().getScannedCodes();
    setState(() {
      _scannedCodes = scannedCodes;
    });
  }

  void _onItemTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
    _pageController.jumpToPage(index);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _currentIndex == 1 ? Colors.black : Colors.white,
      drawer: MyDrawer(onItemTapped: _onItemTapped),
      body: Column(
        children: [
          drawerWidget(username: _username),
          Expanded(
            child: PageView(
              controller: _pageController,
              onPageChanged: (index) {
                setState(() {
                  _currentIndex = index;
                });
              },
              physics: NeverScrollableScrollPhysics(),
              children: <Widget>[
                ScannerInfoView(
                  scannedCodes: _scannedCodes,
                  updateBalance: _updateScans,
                ),

                MobileScannerSimple(updateBalance: _updateBalance),

                NativeScanner(updateBalance: _updateBalance,),
              ],
            ),
          ),
        ],
      ),
      bottomNavigationBar: _buildCustomBottomNavigationBar(),
    );
  }

  Widget _buildCustomBottomNavigationBar() {
    return Stack(
      clipBehavior: Clip.none,
      alignment: Alignment.center,
      children: [
        Container(
          height: 60,
          decoration: const BoxDecoration(color: Color(0xFF000000)),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              GestureDetector(
                onTap: () {
                  _onItemTapped(0);
                },
                child: SvgPicture.asset(
                  'assets/icons/nube.svg',
                  width: 40,
                  height: 40,
                  // ignore: deprecated_member_use
                  color: _currentIndex == 0 ? Colors.white : Colors.grey,
                ),
              ),
              const SizedBox(width: 80),
              GestureDetector(
                onTap: () {
                  _onItemTapped(1);
                },
                child: SvgPicture.asset(
                  'assets/icons/lectura-de-codigo-de-barras.svg',
                  width: 40,
                  height: 40,
                  // ignore: deprecated_member_use
                  color: _currentIndex == 1 ? Colors.white : Colors.grey,
                ),
              ),
            ],
          ),
        ),
        Positioned(
          top: -30,
          child: GestureDetector(
            onTap: () {
              _onItemTapped(2);
            },
            child: CircleAvatar(
              radius: 45,
              backgroundColor: const Color(0xFF000000),
              child: CircleAvatar(
                radius: 40,
                backgroundColor: Colors.white,
                child: ClipOval(
                  child: Image.asset(
                    'assets/logo/seek.png',
                    width: 80,
                    height: 80,
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
