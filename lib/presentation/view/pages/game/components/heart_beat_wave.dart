import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:hackathon_app/constants/theme/app_colors.dart';

///
/// 心拍波形コンポーネント
///
class HeartbeatWaveController {
  HeartbeatWaveController();

  VoidCallback? _onTriggerPulse;

  void _attach(VoidCallback trigger) {
    _onTriggerPulse = trigger;
  }

  void _detach(VoidCallback trigger) {
    if (_onTriggerPulse == trigger) {
      _onTriggerPulse = null;
    }
  }

  void triggerPulse() {
    _onTriggerPulse?.call();
  }
}

class HeartbeatWave extends StatefulWidget {
  final double bpm; // beats per minute
  final Color waveColor;
  final double baseAmplitude;
  final double waveSpeed; // how fast the baseline wave scrolls (seconds)
  final double frequency; // baseline wave cycles across the width
  final HeartbeatWaveController? controller;

  const HeartbeatWave({
    super.key,
    this.bpm = 60,
    this.waveColor = Colors.white,
    this.baseAmplitude = 18,
    this.waveSpeed = 2.0,
    this.frequency = 1.5,
    this.controller,
  });

  @override
  State<HeartbeatWave> createState() => _HeartbeatWaveState();
}

class _HeartbeatWaveState extends State<HeartbeatWave>
    with TickerProviderStateMixin {
  late final AnimationController _phaseController;
  late final AnimationController _pulseController;
  Timer? _beatTimer;

  @override
  void initState() {
    super.initState();

    // controller that continuously moves the wave phase (0..1)
    _phaseController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: (widget.waveSpeed * 1000).round()),
    );
    unawaited(_phaseController.repeat());

    // short animation to represent the beat "pulse" (0..1)
    _pulseController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 420),
    );
    _pulseController.addStatusListener(_handlePulseStatus);
    // Start a periodic timer to trigger the beat based on bpm
    // _startBeatTimer();
    widget.controller?._attach(_triggerPulse);
  }

  // void _startBeatTimer() {
  //   final intervalMs = (60000 / widget.bpm).round();
  //   _beatTimer?.cancel();
  //   // trigger immediately then periodically
  //   _triggerPulse();
  //   _beatTimer = Timer.periodic(Duration(milliseconds: intervalMs), (_) {
  //     _triggerPulse();
  //   });
  // }

  void _triggerPulse() {
    // Make the pulse animation go forward from 0.
    // We use a non-blocking forward and it will naturally ease out.
    unawaited(_pulseController.forward(from: 0.0));
  }
  void _handlePulseStatus(AnimationStatus status) {
    if (status == AnimationStatus.completed) {
      unawaited(_pulseController.reverse());
    }
  }

  @override
  void didUpdateWidget(covariant HeartbeatWave oldWidget) {
    super.didUpdateWidget(oldWidget);
    // if (oldWidget.bpm != widget.bpm) {
    //   _startBeatTimer();
    // }
    if (oldWidget.controller != widget.controller) {
      oldWidget.controller?._detach(_triggerPulse);
      widget.controller?._attach(_triggerPulse);
    }
    if ((oldWidget.waveSpeed != widget.waveSpeed) ||
        (oldWidget.frequency != widget.frequency)) {
      _phaseController.duration = Duration(
        milliseconds: (widget.waveSpeed * 1000).round(),
      );
      if (!_phaseController.isAnimating) {
        unawaited(_phaseController.repeat());
      }
    }
  }

  @override
  void dispose() {
    widget.controller?._detach(_triggerPulse);
    _beatTimer?.cancel();
    _phaseController.dispose();
    _pulseController.removeStatusListener(_handlePulseStatus);
    _pulseController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Repaint when either controller changes
    return RepaintBoundary(
      child: AnimatedBuilder(
        animation: Listenable.merge([_phaseController, _pulseController]),
        builder: (context, child) {
          return CustomPaint(
            painter: _HeartbeatPainter(
              phase: _phaseController.value, // 0..1
              pulse: _pulseController.value, // 0..1
              color: widget.waveColor,
              baseAmplitude: widget.baseAmplitude,
              frequency: widget.frequency,
            ),
            size: Size.infinite,
          );
        },
      ),
    );
  }
}

class _HeartbeatPainter extends CustomPainter {
  final double phase; // 0..1 - horizontal translation of the baseline wave
  final double pulse; // 0..1 - current beat pulse envelope
  final Color color;
  final double baseAmplitude;
  final double frequency;

  _HeartbeatPainter({
    required this.phase,
    required this.pulse,
    required this.color,
    required this.baseAmplitude,
    required this.frequency,
  });

  final Paint _paint = Paint()
    ..style = PaintingStyle.stroke
    ..strokeCap = StrokeCap.round
    ..isAntiAlias = true;

  @override
  void paint(Canvas canvas, Size size) {
    final w = size.width;
    final h = size.height;
    if (w <= 0 || h <= 0) return;

    // configure paint
    final bool isPulsing = pulse > 0.3; // threshold to highlight beat moment
    final Color strokeColor = isPulsing ? AppColors.strawberryRed : color;
    _paint.color = strokeColor;
    _paint.strokeWidth = max(2.0, size.height * 0.018);

    final centerY = h / 2;

    // We'll draw a baseline smooth sine wave + a localized sharp pulse that travels with phase.
    final Path path = Path();

    // Determine spike position that moves left as phase increases (feel of scrolling)
    final spikeX = (1.0 - (phase % 1.0)) * w; // left-moving spike

    // Precompute some constants
    final double twoPi = pi * 2;
    final double freq = frequency; // number of baseline cycles across the width
    final double baseAmp = baseAmplitude.clamp(0.0, h / 2);

    // Sampling step: choose larger step for wide screens to reduce work
    final int samples = (w / 2).clamp(100, 1000).toInt();
    final double dx = w / samples;

    for (int i = 0; i <= samples; i++) {
      final double x = i * dx;
      // baseline sine wave with phase shift
      final double t = (x / w) * twoPi * freq + phase * twoPi;
      double y = sin(t) * baseAmp;

      // Add a localized sharp spike (Gaussian) centered at spikeX, scaled by pulse.
      // The spike is narrow and high compared to baseline.
      final double distance = (x - spikeX).abs();
      final double sigma = max(6.0, w * 0.02); // determines spike width
      final double gauss = exp(-(distance * distance) / (2 * sigma * sigma));
      final double spikeHeight = baseAmp * 6.0; // how tall the spike is
      y += gauss * spikeHeight * Curves.easeOut.transform(pulse);

      final double dy = centerY - y;

      if (i == 0) {
        path.moveTo(x, dy);
      } else {
        // use quadratic to smooth between points
        final double prevX = (i - 1) * dx;
        final double prevT = (prevX / w) * twoPi * freq + phase * twoPi;
        double prevY = sin(prevT) * baseAmp;
        final double prevDistance = (prevX - spikeX).abs();
        final double prevGauss = exp(
          -(prevDistance * prevDistance) / (2 * sigma * sigma),
        );
        prevY += prevGauss * spikeHeight * Curves.easeOut.transform(pulse);
        final double prevDy = centerY - prevY;

        final double midX = (prevX + x) / 2;
        final double midY = (prevDy + dy) / 2;
        path.quadraticBezierTo(prevX, prevDy, midX, midY);
      }
    }

    // Optionally draw a subtle glow / background line (thin)
    final Paint bgPaint = Paint()
      ..color = strokeColor.withAlpha((255 * 0.12).round())
      ..style = PaintingStyle.stroke
      ..strokeWidth = _paint.strokeWidth * 1.6;
    canvas.drawPath(path, bgPaint);

    // main line
    canvas.drawPath(path, _paint);
  }

  @override
  bool shouldRepaint(covariant _HeartbeatPainter oldDelegate) {
    // repaint when the animation values or style change
    return oldDelegate.phase != phase ||
        oldDelegate.pulse != pulse ||
        oldDelegate.color != color ||
        oldDelegate.baseAmplitude != baseAmplitude ||
        oldDelegate.frequency != frequency;
  }
}
