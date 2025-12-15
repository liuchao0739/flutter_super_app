import 'package:flutter/material.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'dart:io';

class ScanDemoPage extends StatefulWidget {
  @override
  _ScanDemoPageState createState() => _ScanDemoPageState();
}

class _ScanDemoPageState extends State<ScanDemoPage> {
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
  QRViewController? controller;
  String? scannedData;

  @override
  void reassemble() {
    super.reassemble();
    if (Platform.isAndroid) {
      controller?.pauseCamera();
    }
    controller?.resumeCamera();
  }

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }

  void _onQRViewCreated(QRViewController controller) {
    this.controller = controller;
    controller.scannedDataStream.listen((scanData) {
      setState(() {
        scannedData = scanData.code;
      });
      if (scannedData != null) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('扫描结果: $scannedData')),
        );
        // Mock 处理：如果是 URL，可以跳转
        if (scannedData!.startsWith('http')) {
          _handleUrl(scannedData!);
        }
      }
    });
  }

  void _handleUrl(String url) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('扫描到网址'),
        content: Text(url),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('取消'),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('Mock: 打开网址 $url')),
              );
            },
            child: const Text('打开（Mock）'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('扫码 Demo')),
      body: Column(
        children: [
          Expanded(
            flex: 4,
            child: QRView(
              key: qrKey,
              onQRViewCreated: _onQRViewCreated,
            ),
          ),
          Expanded(
            flex: 1,
            child: Center(
              child: scannedData != null
                  ? Text('扫描结果: $scannedData')
                  : const Text('请将二维码对准扫描框'),
            ),
          ),
        ],
      ),
    );
  }
}

