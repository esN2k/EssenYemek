import '/auth/firebase_auth/auth_util.dart';
import '/backend/backend.dart';
import '/backend/plan_service.dart';
import '/bilesenlercomp/meal_bottom_sheet/meal_bottom_sheet_widget.dart';
import '/components/custom_appbar_widget.dart';
import '/flutter_flow/flutter_flow_animations.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'yemek_detaylar_model.dart';
export 'yemek_detaylar_model.dart';

class YemekDetaylarWidget extends StatefulWidget {
  const YemekDetaylarWidget({
    super.key,
    this.mealRef,
  });

  final MealsRecord? mealRef;

  @override
  State<YemekDetaylarWidget> createState() => _YemekDetaylarWidgetState();
}

class _YemekDetaylarWidgetState extends State<YemekDetaylarWidget>
    with TickerProviderStateMixin {
  late YemekDetaylarModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  final animationsMap = <String, AnimationInfo>{};

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => YemekDetaylarModel());

    logFirebaseEvent('screen_view',
        parameters: {'screen_name': 'YemekDetaylar'});
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
    _model.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = FlutterFlowTheme.of(context);
    final meal = widget.mealRef;

    return Title(
        title: 'YemekDetaylar',
        color: theme.primary.withAlpha(0XFF),
        child: GestureDetector(
          onTap: () {
            FocusScope.of(context).unfocus();
            FocusManager.instance.primaryFocus?.unfocus();
          },
          child: Scaffold(
            key: scaffoldKey,
            backgroundColor: theme.primaryBackground,
            body: CustomScrollView(
              slivers: [
                SliverAppBar(
                  backgroundColor: theme.primaryBackground,
                  automaticallyImplyLeading: false,
                  pinned: true,
                  expandedHeight: 320.0,
                  flexibleSpace: FlexibleSpaceBar(
                    background: Stack(
                      children: [
                        Positioned.fill(
                          child: Image.network(
                            valueOrDefault<String>(
                              meal?.mealImage,
                              'https://images.pexels.com/photos/2097090/pexels-photo-2097090.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=2',
                            ),
                            fit: BoxFit.cover,
                          ),
                        ),
                        Positioned.fill(
                          child: DecoratedBox(
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                colors: [
                                  Colors.transparent,
                                  theme.primaryBackground.withAlpha(230),
                                ],
                                begin: const AlignmentDirectional(0.0, -0.6),
                                end: const AlignmentDirectional(0.0, 1.0),
                              ),
                            ),
                          ),
                        ),
                        SafeArea(
                          child: Padding(
                            padding: const EdgeInsetsDirectional.fromSTEB(
                                20.0, 12.0, 20.0, 0.0),
                            child: wrapWithModel(
                              model: _model.customAppbarModel,
                              updateCallback: () => safeSetState(() {}),
                              child: CustomAppbarWidget(
                                backButton: true,
                                actionButton: false,
                                optionsButton: true,
                                actionButtonAction: () async {},
                                optionsButtonAction: () async {
                                  logFirebaseEvent(
                                      'YEMEK_DETAYLAR_OptionsButton_ON_TAP');
                                  await showModalBottomSheet(
                                    isScrollControlled: true,
                                    backgroundColor: const Color(0x00FFFFFF),
                                    barrierColor: const Color(0x00000000),
                                    context: context,
                                    builder: (context) {
                                      return GestureDetector(
                                        onTap: () {
                                          FocusScope.of(context).unfocus();
                                          FocusManager.instance.primaryFocus
                                              ?.unfocus();
                                        },
                                        child: Padding(
                                          padding: MediaQuery.viewInsetsOf(
                                              context),
                                          child: MealBottomSheetWidget(
                                            mealRef: widget.mealRef,
                                          ),
                                        ),
                                      );
                                    },
                                  ).then((value) => safeSetState(() {}));
                                },
                              ),
                            ),
                          ),
                        ),
                        if (meal?.mealCalories != null && meal!.mealCalories != 0)
                          Positioned(
                            left: 24.0,
                            bottom: 24.0,
                            child: Container(
                              padding: const EdgeInsetsDirectional.fromSTEB(
                                  12.0, 6.0, 12.0, 6.0),
                              decoration: BoxDecoration(
                                color: theme.secondaryBackground
                                    .withAlpha(235),
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
                ),
                SliverToBoxAdapter(
                  child: Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: theme.primaryBackground,
                      borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(32.0),
                        topRight: Radius.circular(32.0),
                      ),
                    ),
                    child: Padding(
                      padding: const EdgeInsetsDirectional.fromSTEB(
                          24.0, 24.0, 24.0, 32.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Expanded(
                                child: Text(
                                  valueOrDefault<String>(
                                    meal?.mealName,
                                    'Yemek',
                                  ),
                                  style: theme.displaySmall.override(
                                    fontFamily: 'Sora',
                                    letterSpacing: -0.4,
                                    lineHeight: 1.2,
                                  ),
                                ),
                              ),
                              if (meal != null)
                                Padding(
                                  padding: const EdgeInsetsDirectional.fromSTEB(
                                      12.0, 2.0, 0.0, 0.0),
                                  child: StreamBuilder<MealsRecord>(
                                    stream: MealsRecord.getDocument(
                                        meal.reference),
                                    builder: (context, snapshot) {
                                      if (!snapshot.hasData) {
                                        return SizedBox(
                                          width: 28.0,
                                          height: 28.0,
                                          child: CircularProgressIndicator(
                                            valueColor:
                                                AlwaysStoppedAnimation<Color>(
                                              theme.primary,
                                            ),
                                          ),
                                        );
                                      }
                                      final liveMeal = snapshot.data!;
                                      final isFavorite = liveMeal.mealFavorites
                                          .contains(currentUserReference);
                                      return InkWell(
                                        splashColor: Colors.transparent,
                                        focusColor: Colors.transparent,
                                        hoverColor: Colors.transparent,
                                        highlightColor: Colors.transparent,
                                        onTap: () async {
                                          logFirebaseEvent(
                                              'YEMEK_DETAYLAR_Favorite_ON_TAP');
                                          if (isFavorite) {
                                            HapticFeedback.lightImpact();
                                            await meal.reference.update({
                                              ...mapToFirestore(
                                                {
                                                  'meal_favorites':
                                                      FieldValue.arrayRemove(
                                                          [currentUserReference]),
                                                },
                                              ),
                                            });
                                          } else {
                                            HapticFeedback.selectionClick();
                                            await meal.reference.update({
                                              ...mapToFirestore(
                                                {
                                                  'meal_favorites':
                                                      FieldValue.arrayUnion(
                                                          [currentUserReference]),
                                                },
                                              ),
                                            });
                                          }
                                        },
                                        child: Icon(
                                          isFavorite
                                              ? Icons.favorite_rounded
                                              : Icons.favorite_border_rounded,
                                          color: isFavorite
                                              ? const Color(0xFFFF4E59)
                                              : theme.secondaryText,
                                          size: 28.0,
                                        ).animateOnPageLoad(animationsMap[
                                            'iconOnPageLoadAnimation']!),
                                      );
                                    },
                                  ),
                                ),
                            ],
                          ),
                          if (meal?.mealDiet.isNotEmpty ?? false)
                            Padding(
                              padding: const EdgeInsetsDirectional.fromSTEB(
                                  0.0, 12.0, 0.0, 0.0),
                              child: Wrap(
                                spacing: 8.0,
                                runSpacing: 8.0,
                                children: meal!.mealDiet
                                    .map((diet) => Container(
                                          padding: const EdgeInsetsDirectional
                                              .fromSTEB(12.0, 6.0, 12.0, 6.0),
                                          decoration: BoxDecoration(
                                            color: theme.accent1,
                                            borderRadius:
                                                BorderRadius.circular(20.0),
                                          ),
                                          child: Text(
                                            diet,
                                            style: theme.labelSmall.override(
                                              fontFamily: 'Sora',
                                              color: theme.primary,
                                              letterSpacing: 0.0,
                                              fontWeight: FontWeight.w600,
                                            ),
                                          ),
                                        ))
                                    .toList(),
                              ),
                            ),
                          if (meal?.mealIngredients != null &&
                              meal!.mealIngredients.isNotEmpty)
                            Padding(
                              padding: const EdgeInsetsDirectional.fromSTEB(
                                  0.0, 20.0, 0.0, 0.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    FFLocalizations.of(context)
                                        .getVariableText(
                                      trText: 'Malzemeler',
                                      enText: 'Ingredients',
                                    ),
                                    style: theme.titleSmall.override(
                                      fontFamily: 'Sora',
                                      letterSpacing: 0.0,
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsetsDirectional
                                        .fromSTEB(0.0, 8.0, 0.0, 0.0),
                                    child: Text(
                                      meal.mealIngredients,
                                      style: theme.bodyMedium.override(
                                        fontFamily: 'Sora',
                                        letterSpacing: 0.0,
                                        lineHeight: 1.6,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          if (meal != null && meal.mealAllergens.isNotEmpty)
                            Padding(
                              padding: const EdgeInsetsDirectional.fromSTEB(
                                  0.0, 20.0, 0.0, 0.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    FFLocalizations.of(context)
                                        .getVariableText(
                                      trText: 'Alerjenler',
                                      enText: 'Allergens',
                                    ),
                                    style: theme.titleSmall.override(
                                      fontFamily: 'Sora',
                                      letterSpacing: 0.0,
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsetsDirectional
                                        .fromSTEB(0.0, 8.0, 0.0, 0.0),
                                    child: Wrap(
                                      spacing: 8.0,
                                      runSpacing: 8.0,
                                      children: meal.mealAllergens
                                          .map((allergen) => Container(
                                                padding:
                                                    const EdgeInsetsDirectional
                                                        .fromSTEB(12.0, 6.0, 12.0, 6.0),
                                                decoration: BoxDecoration(
                                                  color: theme.accent2,
                                                  borderRadius:
                                                      BorderRadius.circular(20.0),
                                                ),
                                                child: Text(
                                                  allergen,
                                                  style: theme.labelSmall.override(
                                                    fontFamily: 'Sora',
                                                    color: theme.primaryText,
                                                    letterSpacing: 0.0,
                                                    fontWeight: FontWeight.w600,
                                                  ),
                                                ),
                                              ))
                                          .toList(),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
            bottomNavigationBar: Container(
              decoration: BoxDecoration(
                color: theme.secondaryBackground,
                boxShadow: [
                  BoxShadow(
                    blurRadius: 16.0,
                    color: theme.primaryText.withAlpha(20),
                    offset: const Offset(0.0, -6.0),
                  ),
                ],
              ),
              child: SafeArea(
                top: false,
                child: Padding(
                  padding: const EdgeInsetsDirectional.fromSTEB(
                      24.0, 12.0, 24.0, 12.0),
                  child: FFButtonWidget(
                    onPressed: () async {
                      logFirebaseEvent(
                          'YEMEK_DETAYLAR_AddToPlanButton_ON_TAP');
                      if (meal == null) {
                        return;
                      }
                      final userRef = currentUserReference;
                      if (userRef == null) {
                        showSnackbar(
                          context,
                          FFLocalizations.of(context).getVariableText(
                            trText:
                                'Plan\u0131na eklemek i\u00e7in giri\u015f yapmal\u0131s\u0131n.',
                            enText: 'Please sign in to add to your plan.',
                          ),
                        );
                        return;
                      }
                      final planMeals = FFAppState().planMeals;
                      if (planMeals.contains(meal.reference)) {
                        showSnackbar(
                          context,
                          FFLocalizations.of(context).getVariableText(
                            trText: 'Bu yemek zaten plan\u0131nda.',
                            enText: 'This meal is already in your plan.',
                          ),
                        );
                        return;
                      }
                      if (planMeals.length >= FFAppState().planMealsPerWeek) {
                        showSnackbar(
                          context,
                          FFLocalizations.of(context).getVariableText(
                            trText: 'Plan dolu. Birini \u00e7\u0131kar\u0131p ekleyin.',
                            enText:
                                'Plan is full. Remove one meal to add another.',
                          ),
                        );
                        return;
                      }
                      FFAppState().update(() {
                        FFAppState().addToPlanMeals(meal.reference);
                      });
                      await PlanService.savePlanFromState(
                        state: FFAppState(),
                        userRef: userRef,
                      );
                      if (!context.mounted) {
                        return;
                      }
                      showSnackbar(
                        context,
                        FFLocalizations.of(context).getVariableText(
                          trText: 'Haftal\u0131k plana eklendi.',
                          enText: 'Added to your weekly plan.',
                        ),
                      );
                    },
                    text: FFLocalizations.of(context).getVariableText(
                      trText: 'Haftaya ekle',
                      enText: 'Add to plan',
                    ),
                    options: FFButtonOptions(
                      height: 48.0,
                      padding: const EdgeInsetsDirectional.fromSTEB(
                          16.0, 0.0, 16.0, 0.0),
                      color: theme.primary,
                      textStyle: theme.bodyMedium.override(
                        fontFamily: 'Sora',
                        color: theme.secondaryBackground,
                        letterSpacing: 0.0,
                        fontWeight: FontWeight.w600,
                      ),
                      elevation: 0.0,
                      borderSide: const BorderSide(
                        color: Colors.transparent,
                        width: 1.0,
                      ),
                      borderRadius: BorderRadius.circular(24.0),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ));
  }
}
