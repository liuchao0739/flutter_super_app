import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';

class PermissionDemoPage extends StatefulWidget {
  @override
  _PermissionDemoPageState createState() => _PermissionDemoPageState();
}

class _PermissionDemoPageState extends State<PermissionDemoPage> {
  Map<Permission, PermissionStatus> _permissions = {};

  @override
  void initState() {
    super.initState();
    _checkPermissions();
  }

  Future<void> _checkPermissions() async {
    final permissions = [
      Permission.camera,
      Permission.location,
      Permission.storage,
    ];

    final statuses = await permissions.request();
    setState(() {
      _permissions = statuses;
    });
  }

  Future<void> _requestPermission(Permission permission) async {
    final status = await permission.request();
    setState(() {
      _permissions[permission] = status;
    });

    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('${_getPermissionName(permission)}: ${_getStatusText(status)}'),
        ),
      );
    }
  }

  String _getPermissionName(Permission permission) {
    if (permission == Permission.camera) return '相机权限';
    if (permission == Permission.location) return '定位权限';
    if (permission == Permission.storage) return '存储权限';
    return permission.toString();
  }

  String _getStatusText(PermissionStatus status) {
    switch (status) {
      case PermissionStatus.granted:
        return '已授权';
      case PermissionStatus.denied:
        return '已拒绝';
      case PermissionStatus.restricted:
        return '受限';
      case PermissionStatus.limited:
        return '受限';
      case PermissionStatus.permanentlyDenied:
        return '永久拒绝';
      case PermissionStatus.provisional:
        return '临时授权';
    }
  }

  Color _getStatusColor(PermissionStatus? status) {
    if (status == null) return Colors.grey;
    switch (status) {
      case PermissionStatus.granted:
        return Colors.green;
      case PermissionStatus.denied:
        return Colors.orange;
      case PermissionStatus.restricted:
        return Colors.red;
      case PermissionStatus.limited:
        return Colors.yellow;
      case PermissionStatus.permanentlyDenied:
        return Colors.red;
      case PermissionStatus.provisional:
        return Colors.blue;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('权限申请 Demo')),
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: [
          _buildPermissionCard(
            Permission.camera,
            Icons.camera_alt,
            '相机权限',
            '用于扫描二维码功能',
          ),
          const SizedBox(height: 16),
          _buildPermissionCard(
            Permission.location,
            Icons.location_on,
            '定位权限',
            '用于地图和导航功能',
          ),
          const SizedBox(height: 16),
          _buildPermissionCard(
            Permission.storage,
            Icons.storage,
            '存储权限',
            '用于保存截图和文件',
          ),
        ],
      ),
    );
  }

  Widget _buildPermissionCard(
    Permission permission,
    IconData icon,
    String title,
    String description,
  ) {
    final status = _permissions[permission];
    final statusColor = _getStatusColor(status);

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(icon, size: 32, color: statusColor),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        title,
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        description,
                        style: TextStyle(color: Colors.grey[600]),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  decoration: BoxDecoration(
                    color: statusColor.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Text(
                    status != null ? _getStatusText(status) : '未检查',
                    style: TextStyle(color: statusColor, fontWeight: FontWeight.bold),
                  ),
                ),
                const Spacer(),
                ElevatedButton(
                  onPressed: () => _requestPermission(permission),
                  child: const Text('申请权限'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

