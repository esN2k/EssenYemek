import '/auth/firebase_auth/auth_util.dart';
import '/backend/backend.dart';
import '/flutter_flow/flutter_flow_animations.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'meal_card_model.dart';
export 'meal_card_model.dart';

class MealCardWidget extends StatefulWidget {
  const MealCardWidget({
    super.key,
    this.mealRef,
  });

  final MealsRecord? mealRef;

  @override
  State<MealCardWidget> createState() => _MealCardWidgetState();
}

class _MealCardWidgetState extends State<MealCardWidget>
    with TickerProviderStateMixin {
  late MealCardModel _model;

  final animationsMap = <String, AnimationInfo>{};

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => MealCardModel());

    animationsMap.addAll({
      'iconOnPageLoadAnimation': AnimationInfo(
        trigger: AnimationTrigger.onPageLoad,
        effectsBuilder: () => [
          ScaleEffect(
            curve: Curves.elasticOut,
            delay: 0.0.ms,
            duration: 600.0.ms,
            begin: const Offset(0.0, 0.0),
            end: const Offset(1.0, 1.0),
          ),
        ],
      ),
    });

    WidgetsBinding.instance.addPostFrameCallback((_) => safeSetState(() {}));
  }

  @override
  void dispose() {
    _model.maybeDispose();

    super.dispose();
  }

  Future<void> _toggleFavorite() async {
    if (widget.mealRef == null || currentUserReference == null) {
      return;
    }
    final isFavorite =
        widget.mealRef!.mealFavorites.contains(currentUserReference);
    await widget.mealRef!.reference.update({
      ...mapToFirestore(
        {
          'meal_favorites': isFavorite
              ? FieldValue.arrayRemove([currentUserReference])
              : FieldValue.arrayUnion([currentUserReference]),
        },
      ),
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = FlutterFlowTheme.of(context);
    final meal = widget.mealRef;
    final isFavorite =
        meal?.mealFavorites.contains(currentUserReference) ?? false;

    return InkWell(
      splashColor: Colors.transparent,
      focusColor: Colors.transparent,
      hoverColor: Colors.transparent,
      highlightColor: Colors.transparent,
      onTap: () async {
        logFirebaseEvent('MEAL_CARD_COMP_Column_7nse8gf3_ON_TAP');
        logFirebaseEvent('Column_haptic_feedback');
        HapticFeedback.lightImpact();
        logFirebaseEvent('Column_navigate_to');

        context.pushNamed(
          'YemekDetaylar',
          pathParameters: {
            'mealRef': serializeParam(
              widget.mealRef,
              ParamType.Document,
            ),
          }.withoutNulls,
          extra: <String, dynamic>{
            'mealRef': widget.mealRef,
          },
        );
      },
      onDoubleTap: () async {
        logFirebaseEvent('MEAL_CARD_Container_xsjr6r56_ON_DOUBLE_T');
        logFirebaseEvent('Container_haptic_feedback');
        HapticFeedback.selectionClick();
        await _toggleFavorite();
      },
      child: Container(
        decoration: BoxDecoration(
          color: theme.secondaryBackground,
          borderRadius: BorderRadius.circular(22.0),
          boxShadow: [
            BoxShadow(
              blurRadius: 18.0,
              color: theme.primaryText.withAlpha(20),
              offset: const Offset(0.0, 10.0),
            ),
          ],
          border: Border.all(
            color: theme.accent4,
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Stack(
                children: [
                  ClipRRect(
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(22.0),
                      topRight: Radius.circular(22.0),
                    ),
                    child: Image.network(
                      valueOrDefault<String>(
                        meal?.mealImage,
                        'https://cdn-uploads.mealime.com/uploads/recipe/thumbnail/225/presentation_62aa6b6f-6a95-4798-9091-09f487ad2dc4.jpg',
                      ),
                      width: double.infinity,
                      height: double.infinity,
                      fit: BoxFit.cover,
                    ),
                  ),
                  Positioned.fill(
                    child: DecoratedBox(
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [
                            Colors.transparent,
                            theme.primaryText.withAlpha(153),
                          ],
                          begin: const AlignmentDirectional(0.0, -0.6),
                          end: const AlignmentDirectional(0.0, 1.0),
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    top: 10.0,
                    right: 10.0,
                    child: InkWell(
                      splashColor: Colors.transparent,
                      focusColor: Colors.transparent,
                      hoverColor: Colors.transparent,
                      highlightColor: Colors.transparent,
                      onTap: () async {
                        logFirebaseEvent('MEAL_CARD_COMP_Stack_83960l4l_ON_TAP');
                        logFirebaseEvent('Stack_haptic_feedback');
                        HapticFeedback.selectionClick();
                        await _toggleFavorite();
                      },
                      child: Container(
                        width: 34.0,
                        height: 34.0,
                        decoration: BoxDecoration(
                          color: theme.secondaryBackground.withAlpha(230),
                          shape: BoxShape.circle,
                        ),
                        child: Align(
                          alignment: Alignment.center,
                          child: Icon(
                            isFavorite
                                ? Icons.favorite_rounded
                                : Icons.favorite_border_rounded,
                            color: isFavorite
                                ? const Color(0xFFFF4E59)
                                : theme.secondaryText,
                            size: 18.0,
                          ).animateOnPageLoad(
                              animationsMap['iconOnPageLoadAnimation']!),
                        ),
                      ),
                    ),
                  ),
                  if (meal?.mealCalories != null && meal!.mealCalories != 0)
                    Positioned(
                      left: 10.0,
                      bottom: 10.0,
                      child: Container(
                        padding: const EdgeInsetsDirectional.fromSTEB(
                            10.0, 6.0, 10.0, 6.0),
                        decoration: BoxDecoration(
                          color: theme.secondaryBackground.withAlpha(235),
                          borderRadius: BorderRadius.circular(20.0),
                        ),
                        child: Text(
                          '${meal.mealCalories} kalori',
                          style: theme.labelSmall.override(
                            fontFamily: 'Sora',
                            letterSpacing: 0.0,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),
                ],
              ),
            ),
            Padding(
              padding:
                  const EdgeInsetsDirectional.fromSTEB(12.0, 12.0, 12.0, 12.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    valueOrDefault<String>(
                      meal?.mealName,
                      'Yemek',
                    ).maybeHandleOverflow(
                      maxChars: 40,
                      replacement: '...',
                    ),
                    maxLines: 2,
                    style: theme.bodyMedium.override(
                      fontFamily: 'Sora',
                      letterSpacing: 0.0,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  if (meal?.mealDiet.isNotEmpty ?? false)
                    Padding(
                      padding: const EdgeInsetsDirectional.fromSTEB(
                          0.0, 8.0, 0.0, 0.0),
                      child: Container(
                        decoration: BoxDecoration(
                          color: theme.accent1,
                          borderRadius: BorderRadius.circular(20.0),
                        ),
                        padding: const EdgeInsetsDirectional.fromSTEB(
                            10.0, 6.0, 10.0, 6.0),
                        child: Text(
                          meal!.mealDiet.first,
                          style: theme.labelSmall.override(
                            fontFamily: 'Sora',
                            color: theme.primary,
                            letterSpacing: 0.0,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
