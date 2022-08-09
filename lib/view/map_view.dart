import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MapView extends StatefulWidget {
  const MapView({Key? key}) : super(key: key);

  @override
  State<MapView> createState() => _MapViewState();
}

class _MapViewState extends State<MapView> {
  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text('지도 서비스 준비중'),
    );
  }
}
