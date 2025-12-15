# Flutter 通用全功能 Demo（带 Mock 数据）

## 功能与特性
- Crash 测试 + PV/UV 日志
- 网络请求 GET/POST + Mock 数据
- 列表 + 轮播图（示例图片/文案）
- Mock 支付
- 高德地图 Demo（标记 + 导航 Mock）
- 扫码跳转网址 Mock
- 分享 Mock（微信/QQ/微博）
- 截图 Demo
- 主题切换（深色/浅色）+ 语言切换（中/英文）
- 权限申请 Demo（相机/定位）

## 项目结构（简要）
```
lib/
  main.dart                # 入口：初始化 Hive/Crash + Riverpod
  app.dart                 # 全局壳：主题/路由
  config/                  # Theme / Language / Env / Constants
  routes/                  # AutoRoute 配置
  services/                # Network/Mock、Crash、Analytics、Payment、Map、Scan、Share、Screenshot、Storage
  modules/                 # 页面：Splash/Login/Home/Settings + 各 Demo
  widgets/                 # 可复用组件
android/ ios/ ohos/        # 各端原生配置与权限
assets/images/             # 轮播/占位图
```

## 快速开始
```bash
flutter pub get
flutter pub run build_runner build --delete-conflicting-outputs
flutter run   # 选择目标设备 (iOS/Android/鸿蒙)
```

## 关键依赖
- 路由：auto_route
- 状态管理：flutter_riverpod
- 网络：dio
- 存储：hive / hive_flutter
- 权限：permission_handler
- 功能：amap_flutter_map, qr_code_scanner, share_plus, screenshot, carousel_slider

## 额外说明
- 权限已在 AndroidManifest / Info.plist / 鸿蒙 module.json5 配置。
- HomePage 聚合所有 Demo 按钮，开箱即看效果。
- Mock 数据位于 `lib/modules/network/mock_data.dart`。

## 自动生成脚本
详见 `docs/Demo脚本及架构说明.md`，包含一键生成项目的 Bash 脚本与完整目录说明。
