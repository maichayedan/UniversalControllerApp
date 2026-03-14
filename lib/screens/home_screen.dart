import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../services/bluetooth_service.dart';

class HomeScreen extends StatelessWidget {
    const HomeScreen({super.key});

    @override
    Widget build(BuildContext context) {
          return Scaffold(
                  appBar: AppBar(
                            title: const Text('体感指挥棒汪！'),
                            actions: [
                                        IconButton(
                                                      icon: const Icon(Icons.bluetooth_searching),
                                                      onPressed: () => context.read<BluetoothService>().scanAndConnectAll(),
                                                    ),
                                      ],
                          ),
                  body: Consumer<BluetoothService>(
                            builder: (context, service, child) {
                                        return Padding(
                                                      padding: const EdgeInsets.all(20.0),
                                                      child: Column(
                                                                      crossAxisAlignment: CrossAxisAlignment.stretch,
                                                                      children: [
                                                                                        _buildDeviceStatus(service),
                                                                                        const SizedBox(height: 30),
                                                                                        _buildLinkageSwitch(service),
                                                                                        const SizedBox(height: 50),
                                                                                        _buildGlobalSlider(service),
                                                                                        const Spacer(),
                                                                                        _buildBoostButton(service),
                                                                                      ],
                                                                    ),
                                                    );
                            },
                          ),
                );
    }

    Widget _buildDeviceStatus(BluetoothService service) {
          return Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                            _statusIndicator('阀门', service.isValveConnected),
                            _statusIndicator('郊狼', service.isCoyoteConnected),
                            _statusIndicator('小吻', service.isKisstoyConnected),
                          ],
                );
    }

    Widget _statusIndicator(String label, bool isConnected) {
          return Column(
                  children: [
                            Icon(Icons.circle, color: isConnected ? Colors.green : Colors.red, size: 20),
                            Text(label, style: const TextStyle(fontSize: 12)),
                          ],
                );
    }

    Widget _buildLinkageSwitch(BluetoothService service) {
          return Container(
                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  decoration: BoxDecoration(
                            color: Colors.white10,
                            borderRadius: BorderRadius.circular(15),
                          ),
                  child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                                        const Text('三位一体联动模式汪！', style: TextStyle(fontWeight: FontWeight.bold)),
                                        Switch(
                                                      value: service.isLinkageEnabled,
                                                      onChanged: (val) => service.toggleLinkage(val),
                                                    ),
                                      ],
                          ),
                );
    }

    Widget _buildGlobalSlider(BluetoothService service) {
          return Column(
                  children: [
                            const Text('全屋兴奋度控制汪！', style: TextStyle(fontSize: 18, color: Colors.deepPurpleAccent)),
                            const SizedBox(height: 20),
                            Slider(
                                        value: service.globalLevel,
                                        min: 0,
                                        max: 100,
                                        divisions: 100,
                                        label: '${service.globalLevel.toInt()}%',
                                        onChanged: (val) => service.setGlobalLevel(val),
                                      ),
                          ],
                );
    }

    Widget _buildBoostButton(BluetoothService service) {
          return ElevatedButton(
                  style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.redAccent,
                            foregroundColor: Colors.white,
                            padding: const EdgeInsets.symmetric(vertical: 20),
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
                          ),
                  onPressed: () => service.triggerBoost(),
                  child: const Text('一键爆发！汪汪汪！', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                );
    }
}
