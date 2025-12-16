import 'package:flutter/material.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import '../../../services/scan/scan_service.dart';
import 'scan_result_page.dart';

/// 扫码页面
class ScanPage extends StatefulWidget {
  const ScanPage({Key? key}) : super(key: key);

  @override
  State<ScanPage> createState() => _ScanPageState();
}

class _ScanPageState extends State<ScanPage> {
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
  QRViewController? _controller;
  bool _isScanning = true;

  @override
  void reassemble() {
    super.reassemble();
    ScanService.handlePlatformResume(_controller);
  }

  @override
  void dispose() {
    _controller?.dispose();
    super.dispose();
  }

  void _onQRViewCreated(QRViewController controller) {
    setState(() => _controller = controller);
    controller.scannedDataStream.listen((scanData) {
      if (!_isScanning) return;
      _isScanning = false;
      ScanService.pauseCamera(_controller);
      
      final code = scanData.code;
      if (code != null) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => ScanResultPage(result: code),
          ),
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('扫码'),
      ),
      body: Stack(
        children: [
          QRView(
            key: qrKey,
            onQRViewCreated: _onQRViewCreated,
            overlay: QrScannerOverlayShape(
              borderColor: Colors.white,
              borderRadius: 16,
              borderLength: 30,
              borderWidth: 4,
              cutOutSize: 250,
            ),
          ),
          // 提示文字
          Positioned(
            bottom: 100,
            left: 0,
            right: 0,
            child: const Center(
              child: Text(
                '将二维码放入框内即可自动扫描',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  shadows: [
                    Shadow(
                      color: Colors.black,
                      blurRadius: 4,
                    ),
                  ],
                ),
              ),
            ),
          ),
          // 手电筒按钮
          Positioned(
            bottom: 40,
            left: 0,
            right: 0,
            child: Center(
              child: FutureBuilder(
                future: ScanService.getFlashStatus(_controller),
                builder: (context, snapshot) {
                  final isFlashOn = snapshot.data ?? false;
                  return FloatingActionButton(
                    onPressed: () async {
                      await ScanService.toggleFlash(_controller);
                      setState(() {});
                    },
                    backgroundColor: Colors.white.withOpacity(0.8),
                    child: Icon(
                      isFlashOn ? Icons.flash_on : Icons.flash_off,
                      color: Colors.black,
                    ),
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}

