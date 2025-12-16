import 'package:amap_flutter_base/amap_flutter_base.dart';
import 'package:amap_flutter_map/amap_flutter_map.dart';
import 'package:flutter/widgets.dart';

/// MapService
///
/// 高德地图 Demo 的统一封装，避免业务页面直接接触 SDK 细节。
class MapService {
  static const AMapPrivacyStatement defaultPrivacyStatement =
      AMapPrivacyStatement(
    hasContains: true,
    hasShow: true,
    hasAgree: true,
  );

  static const AMapApiKey demoApiKey = AMapApiKey(
    androidKey: 'your_android_key',
    iosKey: 'your_ios_key',
  );

  static const CameraPosition demoCameraPosition = CameraPosition(
    target: LatLng(39.909187, 116.397451), // 北京天安门
    zoom: 15,
  );

  static const LatLng demoMarkerPosition =
      LatLng(39.909187, 116.397451); // 北京天安门

  /// 提供一个简单的 Demo 地图 Widget，方便页面直接使用。
  static Widget buildDemoMap() {
    return AMapWidget(
      privacyStatement: defaultPrivacyStatement,
      apiKey: demoApiKey,
      initialCameraPosition: demoCameraPosition,
      markers: <Marker>{
        Marker(
          position: demoMarkerPosition,
          icon: BitmapDescriptor.defaultMarker,
        ),
      },
    );
  }
}


