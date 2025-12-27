import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hackathon_app/constants/app_size.dart';
import 'package:hackathon_app/constants/routes/app_routes.dart';
import 'package:hackathon_app/constants/theme/app_colors.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:speech_to_text/speech_to_text.dart' as stt;

class ReadyPage extends StatefulWidget {
  const ReadyPage({super.key});

  @override
  State<ReadyPage> createState() => _ReadyPageState();
}

class _ReadyPageState extends State<ReadyPage> {
  late stt.SpeechToText _speech;
  String _text = '';
  bool _foundTarget = false;

  double _soundLevel = 0.0;
  double _visualLevel = 0.0;
  double minVoiceLevel = 3; // 3以下は雑音として無視
  final Random _random = Random();
  int _voiceCounter = 0; // 音量が一定以上続いた回数

  @override
  void initState() {
    super.initState();
    _speech = stt.SpeechToText();
    _initSpeech();
    _startAnimationLoop();
  }

  Future<bool> _requestMicrophonePermission() async {
    var status = await Permission.microphone.status;
    if (!status.isGranted) status = await Permission.microphone.request();
    return status.isGranted;
  }

  void _initSpeech() async {
    if (!await _requestMicrophonePermission()) return;

    bool available = await _speech.initialize(
      onStatus: (status) async {
        if (status == 'done') await _startListening();
      },
      onError: (_) => _startListening(),
    );

    if (available) await _startListening();
  }

  Future<void> _startListening() async {
    if (!_speech.isAvailable || !_speech.isNotListening) return;

    await _speech.listen(
      onResult: (result) async {
        if (!mounted) return;

        setState(() {
          _text = result.recognizedWords;
        });

        // フレーズ検出
        if (!_foundTarget && _text.contains('大丈夫')) {
          _foundTarget = true;

          await _speech.stop();
          if (!mounted) return;
          context.go(AppRoutes.game);
        }

        // 短いフレーズ向けに完了したら再起動
        if (result.finalResult && mounted) {
          await _speech.stop();
          await Future.delayed(const Duration(milliseconds: 100));
          if (mounted) await _startListening();
        }
      },
      onSoundLevelChange: (level) {
        if (!mounted) return;

        double adjustedLevel = (level * 15).clamp(0, 100);
        setState(() {
          _soundLevel = adjustedLevel;
        });

        if (adjustedLevel > minVoiceLevel) {
          _voiceCounter++;
        } else {
          _voiceCounter = 0;
        }

        // 3回連続（例: 数百ミリ秒）閾値以上なら声と判定
        if (_voiceCounter >= 3) {
          // ここで声として扱う
          // 例: アラートや波形表示など
          _voiceCounter = 0; // 判定後リセット
        }
      },
      listenOptions: stt.SpeechListenOptions(
        listenMode: stt.ListenMode.dictation,
        cancelOnError: false,
        partialResults: true,
        // モードによっては autoPunctuation なども指定可能
        autoPunctuation: true,
        enableHapticFeedback: false,
      ),
      listenFor: const Duration(seconds: 5), // 5秒以内に短いフレーズを検出
      pauseFor: const Duration(seconds: 1), // 一瞬止まったら自動停止
    );
  }

  void _startAnimationLoop() async {
    while (mounted) {
      int delay = (80 - (_soundLevel * 1.2)).clamp(20, 80).toInt();
      await Future.delayed(Duration(milliseconds: delay));

      if (!mounted) break;

      setState(() {
        _visualLevel += (_soundLevel - _visualLevel) * 0.25;
        if (_soundLevel < 1) {
          _visualLevel = 2 + _random.nextDouble() * 4;
        }
      });
    }
  }

  @override
  void dispose() {
    unawaited(_speech.stop());
    unawaited(_speech.cancel());
    super.dispose();
  }

  Widget _buildWaveBars(double baseHeight) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(11, (i) {
        double factor =
            0.65 + sin(DateTime.now().millisecondsSinceEpoch / 180 + i) * 0.35;
        double height = (baseHeight * factor).abs().clamp(12, 140);
        return AnimatedContainer(
          duration: Duration(
            milliseconds: (60 - (_soundLevel * 0.8)).clamp(20, 60).toInt(),
          ),
          curve: Curves.easeOut,
          margin: const EdgeInsets.symmetric(horizontal: 3),
          width: 10,
          height: height,
          decoration: BoxDecoration(
            color: AppColors.azureBlue,
            borderRadius: BorderRadius.circular(20),
          ),
        );
      }),
    );
  }

  @override
  Widget build(BuildContext context) {
    double baseHeight = (_visualLevel / 60) * 140;

    return Scaffold(
      backgroundColor: _foundTarget ? Colors.greenAccent : Colors.white,
      body: Stack(
        children: [
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _buildWaveBars(baseHeight),
                const SizedBox(height: 40),
                Text(
                  '「大丈夫ですか？」と声をかけてあげよう！',
                  style: TextStyle(
                    fontSize: AppSize.lg,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
          Positioned(
            left: 16,
            top: 40,
            child: GestureDetector(
              onTap: () => context.go(AppRoutes.top),
              child: Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: AppColors.accentColor,
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Icons.arrow_back_ios_new,
                  size: 28,
                  color: Colors.black,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
