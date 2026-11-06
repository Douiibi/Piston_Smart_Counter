import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import '../theme/app_theme.dart';
import '../features/counting/controllers/counting_controller.dart';
import 'camera_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Consumer<CountingController>(
      builder: (context, c, _) {
        return Scaffold(
          backgroundColor: AppConfig.bgDark,
          body: Stack(
            children: [
              // 1. IMAGEN DE FONDO ATMOSFÉRICA CON DEGRADADO PROFUNDO
              Positioned(
                top: 0,
                left: 0,
                right: 0,
                height: size.height * 0.65,
                child: Stack(
                  fit: StackFit.expand,
                  children: [
                    Image.asset(
                      AppConfig.bgPath,
                      fit: BoxFit.cover,
                      cacheWidth: 1080,
                      alignment: const Alignment(0.0, -0.2),
                      errorBuilder: (_, __, ___) => Container(
                        decoration: const BoxDecoration(
                          gradient: LinearGradient(
                            begin: Alignment.topRight,
                            end: Alignment.bottomLeft,
                            colors: [
                              Color(0xFF1E293B),
                              Color(0xFF0F172A),
                              AppConfig.bgDark,
                            ],
                          ),
                        ),
                      ),
                    ),
                    // Viñeta para fundir la imagen perfectamente con el fondo oscuro
                    Container(
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          stops: const [0.0, 0.35, 0.75, 1.0],
                          colors: [
                            AppConfig.bgDark.withOpacity(0.50),
                            AppConfig.bgDark.withOpacity(0.12),
                            AppConfig.bgDark.withOpacity(0.85),
                            AppConfig.bgDark,
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              // 2. CONTENIDO PRINCIPAL MINIMALISTA Y ELEGANTE
              SafeArea(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 16),

                      // CABECERA DISCRETA
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              const _AppLogoBadge(size: 38),
                              const SizedBox(width: 12),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Text(
                                    'PMG VISION',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 13.5,
                                      fontWeight: FontWeight.w800,
                                      letterSpacing: 1.2,
                                    ),
                                  ),
                                  const SizedBox(height: 1),
                                  Text(
                                    AppConfig.lineId,
                                    style: TextStyle(
                                      color: Colors.white.withOpacity(0.45),
                                      fontSize: 10,
                                      fontWeight: FontWeight.w600,
                                      letterSpacing: 0.6,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                          // Píldora de estado minimalista TFLITE GPU
                          ClipRRect(
                            borderRadius: BorderRadius.circular(20),
                            child: BackdropFilter(
                              filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                              child: Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 11,
                                  vertical: 6,
                                ),
                                decoration: BoxDecoration(
                                  color: Colors.white.withOpacity(0.06),
                                  borderRadius: BorderRadius.circular(20),
                                  border: Border.all(
                                    color: Colors.white.withOpacity(0.10),
                                  ),
                                ),
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Container(
                                      width: 6,
                                      height: 6,
                                      decoration: const BoxDecoration(
                                        color: Color(0xFF38BDF8),
                                        shape: BoxShape.circle,
                                      ),
                                    ),
                                    const SizedBox(width: 7),
                                    Text(
                                      'TFLITE GPU',
                                      style: TextStyle(
                                        color: Colors.white.withOpacity(0.85),
                                        fontSize: 10,
                                        fontWeight: FontWeight.w700,
                                        letterSpacing: 0.5,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),

                      const SizedBox(height: 38),

                      // TIPOGRAFÍA EDITORIAL CON DEGRADADO DE ALTA GAMA
                      ShaderMask(
                        shaderCallback: (bounds) => const LinearGradient(
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                          colors: [
                            Colors.white,
                            Color(0xFFE0F7FA),
                            Color(0xFF38BDF8), // Azul cielo luminoso
                            Color(0xFF818CF8), // Índigo suave
                          ],
                          stops: [0.0, 0.4, 0.75, 1.0],
                        ).createShader(bounds),
                        child: const Text(
                          'Count\nSmarter.',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 52,
                            fontWeight: FontWeight.w800,
                            height: 1.02,
                            letterSpacing: -1.8,
                          ),
                        ),
                      ),
                      const SizedBox(height: 14),
                      Text(
                        'Herramienta de visión artificial e inferencia\nneuronal en tiempo real.',
                        style: TextStyle(
                          color: Colors.white.withOpacity(0.58),
                          fontSize: 14.5,
                          fontWeight: FontWeight.w400,
                          height: 1.45,
                          letterSpacing: -0.2,
                        ),
                      ),

                      const Spacer(),

                      // TARJETA DE ACCIÓN 1: INICIAR CONTEO (PRINCIPAL HERO)
                      _GlassActionCard(
                        iconGradient: const [
                          Color(0xFF0EA5E9),
                          Color(0xFF2563EB),
                        ],
                        icon: Icons.camera_alt_rounded,
                        title: 'Iniciar Conteo',
                        subtitle:
                            'Cámara activa • ${c.target} u/capa × ${c.layersPerBox} capas',
                        isPrimary: true,
                        onTap: () {
                          HapticFeedback.mediumImpact();
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => const CameraScreen(),
                            ),
                          );
                        },
                      ),
                      const SizedBox(height: 14),

                      // TARJETA DE ACCIÓN 2: HISTORIAL DEL TURNO (SECUNDARIA)
                      _GlassActionCard(
                        iconGradient: const [
                          Color(0xFF6366F1),
                          Color(0xFF8B5CF6),
                        ],
                        icon: Icons.bar_chart_rounded,
                        title: 'Historial del Turno',
                        subtitle:
                            '${c.completedBoxes} cajas completadas • ${c.sessionPieces} u. OK',
                        isPrimary: false,
                        onTap: () {
                          HapticFeedback.selectionClick();
                          _showShiftModal(context, c);
                        },
                      ),

                      const SizedBox(height: 36),
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  void _showShiftModal(BuildContext ctx, CountingController c) {
    showModalBottomSheet(
      context: ctx,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (_) => ClipRRect(
        borderRadius: const BorderRadius.vertical(top: Radius.circular(26)),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 24, sigmaY: 24),
          child: Container(
            padding: const EdgeInsets.fromLTRB(24, 14, 24, 32),
            decoration: BoxDecoration(
              color: const Color(0xFF0F141C).withOpacity(0.92),
              borderRadius:
                  const BorderRadius.vertical(top: Radius.circular(26)),
              border: Border(
                top: BorderSide(color: Colors.white.withOpacity(0.12)),
              ),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: Container(
                    width: 38,
                    height: 4,
                    margin: const EdgeInsets.only(bottom: 18),
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.2),
                      borderRadius: BorderRadius.circular(2),
                    ),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'Datos de Producción',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.w700,
                        letterSpacing: -0.3,
                      ),
                    ),
                    Row(
                      children: [
                        IconButton(
                          tooltip: 'Copiar Reporte',
                          onPressed: () {
                            Clipboard.setData(
                              ClipboardData(text: c.buildShiftReport()),
                            );
                            HapticFeedback.lightImpact();
                            Navigator.pop(ctx);
                            ScaffoldMessenger.of(ctx).showSnackBar(
                              SnackBar(
                                behavior: SnackBarBehavior.floating,
                                backgroundColor: const Color(0xFF1E293B),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                content: const Text(
                                  'Reporte copiado al portapapeles',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                            );
                          },
                          icon: const Icon(
                            Icons.copy_rounded,
                            color: Colors.white70,
                            size: 18,
                          ),
                        ),
                        const SizedBox(width: 4),
                        TextButton.icon(
                          onPressed: () {
                            c.clearSessionHistory();
                            Navigator.pop(ctx);
                          },
                          icon: const Icon(
                            Icons.refresh_rounded,
                            color: Colors.redAccent,
                            size: 16,
                          ),
                          label: const Text(
                            'Reiniciar',
                            style: TextStyle(
                              color: Colors.redAccent,
                              fontSize: 13,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                Container(
                  width: double.infinity,
                  constraints: BoxConstraints(
                    maxHeight: MediaQuery.of(ctx).size.height * 0.38,
                  ),
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.04),
                    borderRadius: BorderRadius.circular(14),
                    border: Border.all(color: Colors.white.withOpacity(0.08)),
                  ),
                  child: SingleChildScrollView(
                    child: Text(
                      c.buildShiftReport(),
                      style: const TextStyle(
                        color: Color(0xFFCBD5E1),
                        fontFamily: 'monospace',
                        fontSize: 11.5,
                        height: 1.45,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _GlassActionCard extends StatefulWidget {
  final List<Color> iconGradient;
  final IconData icon;
  final String title;
  final String subtitle;
  final bool isPrimary;
  final VoidCallback onTap;

  const _GlassActionCard({
    required this.iconGradient,
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.isPrimary,
    required this.onTap,
  });

  @override
  State<_GlassActionCard> createState() => _GlassActionCardState();
}

class _GlassActionCardState extends State<_GlassActionCard> {
  bool _isPressed = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: (_) => setState(() => _isPressed = true),
      onTapUp: (_) => setState(() => _isPressed = false),
      onTapCancel: () => setState(() => _isPressed = false),
      onTap: widget.onTap,
      child: AnimatedScale(
        scale: _isPressed ? 0.98 : 1.0,
        duration: const Duration(milliseconds: 120),
        curve: Curves.easeOut,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(22),
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 22, sigmaY: 22),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 16),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: widget.isPrimary
                      ? [
                          Colors.white.withOpacity(0.14),
                          Colors.white.withOpacity(0.06),
                        ]
                      : [
                          Colors.white.withOpacity(0.09),
                          Colors.white.withOpacity(0.03),
                        ],
                ),
                borderRadius: BorderRadius.circular(22),
                border: Border.all(
                  color: widget.isPrimary
                      ? const Color(0xFF38BDF8).withOpacity(0.35)
                      : Colors.white.withOpacity(0.12),
                  width: widget.isPrimary ? 1.4 : 1.0,
                ),
                boxShadow: widget.isPrimary
                    ? [
                        BoxShadow(
                          color: const Color(0xFF0EA5E9).withOpacity(0.15),
                          blurRadius: 18,
                          offset: const Offset(0, 6),
                        ),
                      ]
                    : [],
              ),
              child: Row(
                children: [
                  Container(
                    width: 48,
                    height: 48,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        colors: widget.iconGradient,
                      ),
                      borderRadius: BorderRadius.circular(14),
                      boxShadow: [
                        BoxShadow(
                          color: widget.iconGradient.first.withOpacity(0.4),
                          blurRadius: 10,
                          offset: const Offset(0, 4),
                        ),
                      ],
                    ),
                    child: Icon(
                      widget.icon,
                      color: Colors.white,
                      size: 23,
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Text(
                              widget.title,
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                                fontWeight: FontWeight.w700,
                                letterSpacing: -0.3,
                              ),
                            ),
                            if (widget.isPrimary) ...[
                              const SizedBox(width: 8),
                              Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 6,
                                  vertical: 2,
                                ),
                                decoration: BoxDecoration(
                                  color:
                                      const Color(0xFF0EA5E9).withOpacity(0.2),
                                  borderRadius: BorderRadius.circular(4),
                                ),
                                child: const Text(
                                  'ACTIVO',
                                  style: TextStyle(
                                    color: Color(0xFF38BDF8),
                                    fontSize: 8.5,
                                    fontWeight: FontWeight.w900,
                                    letterSpacing: 0.6,
                                  ),
                                ),
                              ),
                            ],
                          ],
                        ),
                        const SizedBox(height: 3),
                        Text(
                          widget.subtitle,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            color: Colors.white.withOpacity(0.55),
                            fontSize: 12,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 8),
                  Icon(
                    Icons.chevron_right_rounded,
                    color: Colors.white.withOpacity(0.4),
                    size: 22,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _AppLogoBadge extends StatelessWidget {
  final double size;
  const _AppLogoBadge({required this.size});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: size,
      height: size,
      child: CustomPaint(
        painter: _LogoCPainter(),
      ),
    );
  }
}

class _LogoCPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final double w = size.width;
    final double h = size.height;

    final RRect rRect = RRect.fromRectAndRadius(
      Rect.fromLTWH(0, 0, w, h),
      Radius.circular(w * 0.28),
    );
    canvas.drawRRect(
      rRect,
      Paint()
        ..color = const Color(0xFF0F1219)
        ..style = PaintingStyle.fill,
    );

    canvas.drawRRect(
      rRect,
      Paint()
        ..color = Colors.white.withOpacity(0.14)
        ..style = PaintingStyle.stroke
        ..strokeWidth = 1.0,
    );

    final Paint linePaint = Paint()
      ..color = const Color(0xFF263238).withOpacity(0.3)
      ..style = PaintingStyle.stroke
      ..strokeWidth = w * 0.055;
    canvas.drawLine(
        Offset(w * 0.12, h * 0.40), Offset(w * 0.88, h * 0.40), linePaint);
    canvas.drawLine(
        Offset(w * 0.12, h * 0.60), Offset(w * 0.88, h * 0.60), linePaint);

    final Paint metalFill = Paint()
      ..color = const Color(0xFF546E7A)
      ..style = PaintingStyle.fill;
    final Paint metalStroke = Paint()
      ..color = const Color(0xFFECEFF1)
      ..style = PaintingStyle.stroke
      ..strokeWidth = w * 0.038;

    final Path pistonHead = Path()
      ..moveTo(w * 0.36, h * 0.38)
      ..lineTo(w * 0.36, h * 0.16)
      ..quadraticBezierTo(w * 0.50, h * 0.08, w * 0.64, h * 0.16)
      ..lineTo(w * 0.64, h * 0.38)
      ..close();
    canvas.drawPath(pistonHead, metalFill);
    canvas.drawPath(pistonHead, metalStroke);

    final Paint groovePaint = Paint()
      ..color = const Color(0xFF0F1219)
      ..style = PaintingStyle.stroke
      ..strokeWidth = w * 0.032;
    canvas.drawLine(
        Offset(w * 0.42, h * 0.16), Offset(w * 0.58, h * 0.16), groovePaint);
    canvas.drawLine(
        Offset(w * 0.40, h * 0.22), Offset(w * 0.60, h * 0.22), groovePaint);
    canvas.drawLine(
        Offset(w * 0.40, h * 0.28), Offset(w * 0.60, h * 0.28), groovePaint);

    canvas.drawCircle(Offset(w * 0.50, h * 0.31), w * 0.045,
        Paint()..color = const Color(0xFF263238));

    final Path shaft = Path()
      ..moveTo(w * 0.45, h * 0.38)
      ..lineTo(w * 0.45, h * 0.72)
      ..lineTo(w * 0.55, h * 0.72)
      ..lineTo(w * 0.55, h * 0.38)
      ..close();
    canvas.drawPath(shaft, metalFill);
    canvas.drawPath(shaft, metalStroke);

    canvas.drawCircle(Offset(w * 0.50, h * 0.76), w * 0.14, metalFill);
    canvas.drawCircle(Offset(w * 0.50, h * 0.76), w * 0.14, metalStroke);
    canvas.drawCircle(Offset(w * 0.50, h * 0.76), w * 0.065,
        Paint()..color = const Color(0xFF0F1219));

    final Paint fontPaint = Paint()
      ..color = const Color(0xFFFFFFFF)
      ..style = PaintingStyle.fill;
    final Paint fontBorder = Paint()
      ..color = const Color(0xFF1C2833)
      ..style = PaintingStyle.stroke
      ..strokeWidth = w * 0.035
      ..strokeJoin = StrokeJoin.round;

    final Path textPath = Path();
    textPath
      ..moveTo(w * 0.14, h * 0.40)
      ..lineTo(w * 0.30, h * 0.40)
      ..quadraticBezierTo(w * 0.36, h * 0.40, w * 0.36, h * 0.47)
      ..quadraticBezierTo(w * 0.36, h * 0.53, w * 0.30, h * 0.53)
      ..lineTo(w * 0.22, h * 0.53)
      ..lineTo(w * 0.22, h * 0.63)
      ..lineTo(w * 0.14, h * 0.63)
      ..close()
      ..moveTo(w * 0.22, h * 0.46)
      ..lineTo(w * 0.28, h * 0.46)
      ..quadraticBezierTo(w * 0.30, h * 0.46, w * 0.30, h * 0.495)
      ..quadraticBezierTo(w * 0.30, h * 0.51, w * 0.28, h * 0.51)
      ..lineTo(w * 0.22, h * 0.51)
      ..close();

    textPath
      ..moveTo(w * 0.39, h * 0.63)
      ..lineTo(w * 0.39, h * 0.40)
      ..lineTo(w * 0.46, h * 0.40)
      ..lineTo(w * 0.50, h * 0.52)
      ..lineTo(w * 0.54, h * 0.40)
      ..lineTo(w * 0.61, h * 0.40)
      ..lineTo(w * 0.61, h * 0.63)
      ..lineTo(w * 0.54, h * 0.63)
      ..lineTo(w * 0.54, h * 0.48)
      ..lineTo(w * 0.51, h * 0.57)
      ..lineTo(w * 0.49, h * 0.57)
      ..lineTo(w * 0.46, h * 0.48)
      ..lineTo(w * 0.46, h * 0.63)
      ..close();

    textPath
      ..moveTo(w * 0.81, h * 0.45)
      ..lineTo(w * 0.86, h * 0.45)
      ..lineTo(w * 0.86, h * 0.40)
      ..lineTo(w * 0.70, h * 0.40)
      ..quadraticBezierTo(w * 0.64, h * 0.40, w * 0.64, h * 0.51)
      ..quadraticBezierTo(w * 0.64, h * 0.63, w * 0.70, h * 0.63)
      ..lineTo(w * 0.82, h * 0.63)
      ..quadraticBezierTo(w * 0.87, h * 0.63, w * 0.87, h * 0.52)
      ..lineTo(w * 0.76, h * 0.52)
      ..lineTo(w * 0.76, h * 0.57)
      ..lineTo(w * 0.80, h * 0.57)
      ..quadraticBezierTo(w * 0.80, h * 0.59, w * 0.77, h * 0.59)
      ..lineTo(w * 0.71, h * 0.59)
      ..quadraticBezierTo(w * 0.70, h * 0.59, w * 0.70, h * 0.51)
      ..quadraticBezierTo(w * 0.70, h * 0.45, w * 0.75, h * 0.45)
      ..close();

    canvas.drawPath(textPath, fontBorder);
    canvas.drawPath(textPath, fontPaint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
