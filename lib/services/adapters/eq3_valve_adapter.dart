import '../core/device_adapter.dart';

/// eQ-3 Eqiva 散热器阀门适配器汪！
/// 基于米兰大学逆向协议实现汪。
class Eq3ValveAdapter implements IDeviceAdapter {
    @override
    String get deviceName => "eQ-3 Eqiva Valve";

    @override
    String get serviceUuid => "3e135142-654f-9090-134a-a6ff5bb77046";

    @override
    String get writeCharacteristicUuid => "3fa4585a-ce4a-3bad-db4b-b8df8179ea09";

    @override
    Future<void> connect(String deviceId) async {
          // 实际蓝牙连接逻辑汪...
          print("Eq3 Valve Connected! 汪！");
    }

    @override
    Future<void> disconnect() async {
          print("Eq3 Valve Disconnected. 汪。");
    }

    @override
    Future<void> setIntensity(int value) async {
          // 阀门对应的“强度”可以理解为目标温度汪
          // 温度范围通常是 4.5°C (0x09) 到 30.0°C (0x3C)
          // 传入 0-100 映射到 5-30 度汪
          double temp = 5 + (value / 100 * 25);
          await setTemperature(temp);
    }

    @override
    Future<void> setMode(int mode) async {
          // mode 0: Auto (0x4000), mode 1: Manual (0x4040)汪
          List<int> command = (mode == 0) ? [0x40, 0x00] : [0x40, 0x40];
          await sendRawBytes(command);
    }

    /// 设置目标温度汪
    Future<void> setTemperature(double temp) async {
          // 温度 * 2 转换为十六进制字节汪
          int val = (temp * 2).toInt();
          List<int> command = [0x41, val];
          await sendRawBytes(command);
    }

    /// 设置儿童锁汪
    Future<void> setLock(bool locked) async {
          List<int> command = [0x80, locked ? 0x01 : 0x00];
          await sendRawBytes(command);
    }

    @override
    Future<void> sendRawBytes(List<int> bytes) async {
          // 实际下发蓝牙指令汪！
          print("Sending to Eq3 Valve: $bytes");
    }
}
