// ignore: file_names
import 'package:flutter/material.dart';

// ignore: camel_case_types
class drawerWidget extends StatefulWidget {
  const drawerWidget({super.key, required String username})
    : _username = username;

  final String _username;

  @override
  State<drawerWidget> createState() => _drawerWidgetState();
}

// ignore: camel_case_types
class _drawerWidgetState extends State<drawerWidget> {
  bool _isCollapsed = true;
  bool _shouldShowContent = false;
  void _toggleCollapse() {
    setState(() {
      _isCollapsed = !_isCollapsed;
      _shouldShowContent = false;
    });

    Future.delayed(Duration(milliseconds: 200), () {
      setState(() {
        _shouldShowContent = !_isCollapsed;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: Duration(milliseconds: 150),
      //height: _isCollapsed ? 145 : MediaQuery.of(context).size.height * 0.32,
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [Colors.black, Colors.black87, Colors.black87, Colors.black],
          begin: Alignment.topLeft,
          end: Alignment.topRight,
        ),
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(20),
          bottomRight: Radius.circular(20),
        ),
        border: Border.all(color: Colors.black54, width: 2),
      ),
      padding: EdgeInsets.all(0),
      child: Column(
        children: [
          SizedBox(height: 44),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              IconButton(
                icon: Icon(Icons.menu),
                color: Colors.white,
                onPressed: () {
                  Scaffold.of(context).openDrawer();
                },
              ),
              Row(
                children: [
                  Image.asset(
                    'assets/logo/seek.png',
                    fit: BoxFit.cover,
                    width: 30,
                    height: 30,
                  ),
                  SizedBox(width: 20),
                ],
              ),
            ],
          ),
          // Si no está colapsado, mostramos el contenido
          if (!_isCollapsed && _shouldShowContent) ...[
            Text(
              'Seek Gestor de QR',
              style: TextStyle(
                fontSize: 24,
                color: Colors.white54,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              'Estrategia, diseño e innovación',
              style: TextStyle(
                fontSize: 20,
                color: Colors.white70,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 10),
            Text(
              widget._username,
              style: TextStyle(fontSize: 18, color: Colors.white54),
            ),
            SizedBox(height: 5),
          ],
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              IconButton(
                icon: Icon(
                  _isCollapsed ? Icons.arrow_downward : Icons.arrow_upward,
                ),
                color: Colors.white54,
                onPressed: _toggleCollapse,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
