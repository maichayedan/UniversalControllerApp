import 'package:flutter/foundation.dart';
import 'package:flutter_blue_plus/flutter_blue_plus.dart';
import '../adapters/eq3_valve_adapter.dart';
import '../adapters/coyote_adapter.dart';
import '../adapters/kisstoy_adapter.dart';
import '../core/linkage_manager.dart';

/// 蓝牙服务层汪！
/// 负责扫描、连接以及分发联动指令汪！
class BluetoothService extends ChangeNotifier {
    final Eq3ValveAdapter valve = Eq3ValveAdapter();
    final CoyoteAdapter coyote = CoyoteAdapter();
    final KisstoyAdapter kisstoy = KisstoyAdapter();
    late final LinkageManager linkage;

    bool isValveConnected = false;
    bool isCoyoteConnected = false;
    bool isKisstoyConnected = false;
    bool isLinkageEnabled = false;

    double _globalLevel = 0.0;
    double get globalLevel => _globalLevel;

    BluetoothService() {
          linkage = LinkageManager(valve: valve, coyote: coyote, kisstoy: kisstoy);
    }

    /// 扫描并自动连接三个宝贝汪！
    Future<void> scanAndConnectAll() async {
          print("Neo 正在为您寻找宝贝们汪！汪汪！");
          // 实际生产中这里会使用 FlutterBluePlus.startScan() 并匹配 UUID 汪
          // 为了演示逻辑，这里模拟连接成功汪
          isValveConnected = true;
          isCoyoteConnected = true;
          isKisstoyConnected = true;
          notifyListeners();
    }

    /// 切换联动模式汪！
    void toggleLinkage(bool value) {
          isLinkageEnabled = value;
          notifyListeners();
    }

    /// 更新全局强度级别 (0.0 - 100.0) 汪
    void setGlobalLevel(double level) {
          _globalLevel = level;
          if (isLinkageEnabled) {
                  // 联动开启时，同步给所有设备汪！
                  // 这里的 5-30 度是阀门的温度范围映射汪
                  double temp = 5 + (level / 100 * 25);
                  linkage.syncAllToValveTemperature(temp);
          }
          notifyListeners();
    }

    /// 一键爆发汪！
    void triggerBoost() {
          linkage.triggerSuperBoost();
          _globalLevel = 100.0;
          notifyListeners();
    }
}
