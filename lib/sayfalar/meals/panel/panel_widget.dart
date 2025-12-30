import '/auth/firebase_auth/auth_util.dart';
import '/backend/backend.dart';
import '/bilesenlercomp/meal_card/meal_card_widget.dart';
import '/bilesenlercomp/meal_card_loading/meal_card_loading_widget.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'panel_model.dart';
export 'panel_model.dart';

class PanelWidget extends StatefulWidget {
  const PanelWidget({super.key});

  @override
  State<PanelWidget> createState() => _PanelWidgetState();
}

class _PanelWidgetState extends State<PanelWidget> {
  late PanelModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => PanelModel());

    logFirebaseEvent('screen_view', parameters: {'screen_name': 'Panel'});
    // On page load action.
    SchedulerBinding.instance.addPostFrameCallback((_) async {
      logFirebaseEvent('PANEL_PAGE_Panel_ON_INIT_STATE');
      logFirebaseEvent('Panel_haptic_feedback');
      HapticFeedback.mediumImpact();
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
    final appState = context.watch<FFAppState>();
    final planMealsPerWeek = appState.planMealsPerWeek;
    final planServings = appState.planServings;
    final planDeliveryDay = appState.planDeliveryDay;
    final preferredDiet = valueOrDefault(currentUserDocument?.diet, '');
    final dietOptions = <String>[
      'T\u00fcm\u00fc',
      'Dengeli',
      'Vegan',
      'Protein',
      'H\u0131zl\u0131',
      'Glutensiz',
    ];
    if (preferredDiet.isNotEmpty && !dietOptions.contains(preferredDiet)) {
      dietOptions.insert(1, preferredDiet);
    }
    final selectedDiet = _model.activeDiet ??
        (preferredDiet.isNotEmpty ? preferredDiet : 'T\u00fcm\u00fc');
    final width = MediaQuery.sizeOf(context).width;
    final crossAxisCount = width > 900
        ? 4
        : width > 640
            ? 3
            : 2;
    final cardAspectRatio = width > 640 ? 0.74 : 0.68;

    return Title(
        title: 'Panel',
        color: theme.primary.withAlpha(0XFF),
        child: GestureDetector(
          onTap: () {
            FocusScope.of(context).unfocus();
            FocusManager.instance.primaryFocus?.unfocus();
          },
          child: Scaffold(
            key: scaffoldKey,
            backgroundColor: theme.primaryBackground,
            body: SafeArea(
              top: true,
              child: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsetsDirectional.fromSTEB(
                          24.0, 16.0, 24.0, 12.0),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  FFLocalizations.of(context).getVariableText(
                                    trText: 'Merhaba',
                                    enText: 'Hi there',
                                  ),
                                  style: theme.labelLarge.override(
                                    fontFamily: 'Sora',
                                    letterSpacing: 0.0,
                                  ),
                                ),
                                AuthUserStreamWidget(
                                  builder: (context) => Text(
                                    valueOrDefault<String>(
                                      currentUserDisplayName,
                                      'Essen',
                                    ),
                                    style: theme.displaySmall.override(
                                      fontFamily: 'Sora',
                                      letterSpacing: -0.5,
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsetsDirectional.fromSTEB(
                                      0.0, 6.0, 0.0, 0.0),
                                  child: Text(
                                    FFLocalizations.of(context)
                                        .getVariableText(
                                      trText:
                                          'Bu hafta taptaze tariflerle sofran\u0131 planla.',
                                      enText:
                                          'Plan your table with fresh recipes this week.',
                                    ),
                                    style: theme.labelLarge.override(
                                      fontFamily: 'Sora',
                                      letterSpacing: 0.0,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Container(
                            width: 44.0,
                            height: 44.0,
                            decoration: BoxDecoration(
                              color: theme.accent1,
                              shape: BoxShape.circle,
                              border: Border.all(
                                color: theme.accent4,
                              ),
                            ),
                            child: Icon(
                              Icons.local_fire_department_rounded,
                              color: theme.primary,
                              size: 22.0,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsetsDirectional.fromSTEB(
                          24.0, 0.0, 24.0, 20.0),
                      child: Container(
                        width: double.infinity,
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: [
                              theme.primary,
                              theme.secondary,
                            ],
                            begin: const AlignmentDirectional(-1.0, -1.0),
                            end: const AlignmentDirectional(1.0, 1.0),
                          ),
                          borderRadius: BorderRadius.circular(24.0),
                          boxShadow: [
                            BoxShadow(
                              blurRadius: 24.0,
                              color: theme.primary.withAlpha(64),
                              offset: const Offset(0.0, 14.0),
                            ),
                          ],
                        ),
                        child: Stack(
                          children: [
                            Positioned(
                              right: -40.0,
                              top: -30.0,
                              child: Container(
                                width: 140.0,
                                height: 140.0,
                                decoration: BoxDecoration(
                                  color: theme.secondaryBackground
                                      .withAlpha(46),
                                  shape: BoxShape.circle,
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsetsDirectional.fromSTEB(
                                  20.0, 18.0, 20.0, 18.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    FFLocalizations.of(context).getVariableText(
                                      trText: 'Haftal\u0131k plan',
                                      enText: 'Weekly plan',
                                    ),
                                    style: theme.labelLarge.override(
                                      fontFamily: 'Sora',
                                      color: theme.secondaryBackground,
                                      letterSpacing: 0.0,
                                    ),
                                  ),
                                  Padding(
                                    padding:
                                        const EdgeInsetsDirectional.fromSTEB(
                                            0.0, 6.0, 0.0, 12.0),
                                    child: Text(
                                      FFLocalizations.of(context)
                                          .getVariableText(
                                        trText:
                                            '$planMealsPerWeek yemek - $planServings ki\u015fi',
                                        enText:
                                            '$planMealsPerWeek meals - $planServings servings',
                                      ),
                                      style: theme.headlineMedium.override(
                                        fontFamily: 'Sora',
                                        color: theme.secondaryBackground,
                                        letterSpacing: -0.4,
                                      ),
                                    ),
                                  ),
                                  Row(
                                    children: [
                                      Icon(
                                        Icons.local_shipping_outlined,
                                        color: theme.secondaryBackground,
                                        size: 18.0,
                                      ),
                                      Padding(
                                        padding: const EdgeInsetsDirectional
                                            .fromSTEB(8.0, 0.0, 0.0, 0.0),
                                        child: Text(
                                          FFLocalizations.of(context)
                                              .getVariableText(
                                            trText: 'Teslimat: $planDeliveryDay',
                                            enText:
                                                'Delivery: $planDeliveryDay',
                                          ),
                                          style: theme.labelLarge.override(
                                            fontFamily: 'Sora',
                                            color: theme.secondaryBackground,
                                            letterSpacing: 0.0,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  Padding(
                                    padding:
                                        const EdgeInsetsDirectional.fromSTEB(
                                            0.0, 16.0, 0.0, 0.0),
                                    child: FFButtonWidget(
                                      onPressed: () async {
                                        logFirebaseEvent(
                                            'PANEL_PAGE_PlanButton_ON_TAP');
                                        context.pushNamed('Plan');
                                      },
                                      text: FFLocalizations.of(context)
                                          .getVariableText(
                                        trText: 'Plan\u0131 y\u00f6net',
                                        enText: 'Manage plan',
                                      ),
                                      options: FFButtonOptions(
                                        height: 40.0,
                                        padding: const EdgeInsetsDirectional
                                            .fromSTEB(18.0, 0.0, 18.0, 0.0),
                                        color: theme.secondaryBackground,
                                        textStyle: theme.bodyMedium.override(
                                          fontFamily: 'Sora',
                                          color: theme.primaryText,
                                          letterSpacing: 0.0,
                                          fontWeight: FontWeight.w600,
                                        ),
                                        elevation: 0.0,
                                        borderSide: BorderSide(
                                          color: theme.secondaryBackground,
                                          width: 1.0,
                                        ),
                                        borderRadius:
                                            BorderRadius.circular(20.0),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsetsDirectional.fromSTEB(
                          24.0, 0.0, 24.0, 10.0),
                      child: Text(
                        FFLocalizations.of(context).getVariableText(
                          trText: 'Ke\u015ffet',
                          enText: 'Explore',
                        ),
                        style: theme.titleLarge.override(
                          fontFamily: 'Sora',
                          letterSpacing: 0.0,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 48.0,
                      child: ListView.separated(
                        padding: const EdgeInsetsDirectional.fromSTEB(
                            24.0, 0.0, 24.0, 0.0),
                        scrollDirection: Axis.horizontal,
                        itemCount: dietOptions.length,
                        separatorBuilder: (_, __) => const SizedBox(width: 10.0),
                        itemBuilder: (context, index) {
                          final option = dietOptions[index];
                          final isSelected = option == selectedDiet;
                          return InkWell(
                            splashColor: Colors.transparent,
                            focusColor: Colors.transparent,
                            hoverColor: Colors.transparent,
                            highlightColor: Colors.transparent,
                            onTap: () async {
                              logFirebaseEvent(
                                  'PANEL_PAGE_DietChip_ON_TAP');
                              safeSetState(() => _model.activeDiet = option);
                            },
                            child: Container(
                              padding: const EdgeInsetsDirectional.fromSTEB(
                                  16.0, 10.0, 16.0, 10.0),
                              decoration: BoxDecoration(
                                color: isSelected
                                    ? theme.primary
                                    : theme.secondaryBackground,
                                borderRadius: BorderRadius.circular(24.0),
                                border: Border.all(
                                  color: isSelected
                                      ? theme.primary
                                      : theme.accent4,
                                ),
                              ),
                              child: Text(
                                option,
                                style: theme.labelLarge.override(
                                  fontFamily: 'Sora',
                                  color: isSelected
                                      ? theme.primaryBackground
                                      : theme.primaryText,
                                  letterSpacing: 0.0,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                    if (currentUserReference != null)
                      Padding(
                        padding: const EdgeInsetsDirectional.fromSTEB(
                            24.0, 24.0, 24.0, 0.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              FFLocalizations.of(context).getVariableText(
                                trText: 'Favoriler',
                                enText: 'Favorites',
                              ),
                              style: theme.titleLarge.override(
                                fontFamily: 'Sora',
                                letterSpacing: 0.0,
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsetsDirectional.fromSTEB(
                                  0.0, 12.0, 0.0, 0.0),
                              child: StreamBuilder<List<MealsRecord>>(
                                stream: queryMealsRecord(
                                  queryBuilder: (mealsRecord) => mealsRecord
                                      .where(
                                        'meal_favorites',
                                        arrayContains: currentUserReference,
                                      )
                                      .limit(6),
                                ),
                                builder: (context, snapshot) {
                                  if (!snapshot.hasData) {
                                    return SizedBox(
                                      height: 110.0,
                                      child: Center(
                                        child: SizedBox(
                                          width: 28.0,
                                          height: 28.0,
                                          child: CircularProgressIndicator(
                                            valueColor:
                                                AlwaysStoppedAnimation<Color>(
                                              theme.primary,
                                            ),
                                          ),
                                        ),
                                      ),
                                    );
                                  }
                                  final favorites = snapshot.data ?? [];
                                  if (favorites.isEmpty) {
                                    return Container(
                                      width: double.infinity,
                                      padding:
                                          const EdgeInsetsDirectional.fromSTEB(
                                              16.0, 14.0, 16.0, 14.0),
                                      decoration: BoxDecoration(
                                        color: theme.secondaryBackground,
                                        borderRadius:
                                            BorderRadius.circular(16.0),
                                        border: Border.all(
                                          color: theme.accent4,
                                        ),
                                      ),
                                      child: Row(
                                        children: [
                                          Icon(
                                            Icons.favorite_border_rounded,
                                            color: theme.secondaryText,
                                          ),
                                          Padding(
                                            padding: const EdgeInsetsDirectional
                                                .fromSTEB(10.0, 0.0, 0.0, 0.0),
                                            child: Text(
                                              FFLocalizations.of(context)
                                                  .getVariableText(
                                                trText:
                                                    'Favori eklemek i\u00e7in bir tarife dokun.',
                                                enText:
                                                    'Tap a recipe to add favorites.',
                                              ),
                                              style: theme.labelLarge.override(
                                                fontFamily: 'Sora',
                                                letterSpacing: 0.0,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    );
                                  }
                                  return SizedBox(
                                    height: 120.0,
                                    child: ListView.separated(
                                      scrollDirection: Axis.horizontal,
                                      itemCount: favorites.length,
                                      separatorBuilder: (_, __) =>
                                          const SizedBox(width: 12.0),
                                      itemBuilder: (context, index) {
                                        final meal = favorites[index];
                                        return InkWell(
                                          splashColor: Colors.transparent,
                                          focusColor: Colors.transparent,
                                          hoverColor: Colors.transparent,
                                          highlightColor: Colors.transparent,
                                          onTap: () async {
                                            logFirebaseEvent(
                                                'PANEL_PAGE_FavoriteCard_ON_TAP');
                                            context.pushNamed(
                                              'YemekDetaylar',
                                              pathParameters: {
                                                'mealRef': serializeParam(
                                                  meal,
                                                  ParamType.Document,
                                                ),
                                              }.withoutNulls,
                                              extra: <String, dynamic>{
                                                'mealRef': meal,
                                              },
                                            );
                                          },
                                          child: Container(
                                            width: 230.0,
                                            decoration: BoxDecoration(
                                              color: theme.secondaryBackground,
                                              borderRadius:
                                                  BorderRadius.circular(18.0),
                                              boxShadow: [
                                                BoxShadow(
                                                  blurRadius: 16.0,
                                                  color: theme.primaryText
                                                      .withAlpha(15),
                                                  offset:
                                                      const Offset(0.0, 8.0),
                                                ),
                                              ],
                                              border: Border.all(
                                                color: theme.accent4,
                                              ),
                                            ),
                                            child: Row(
                                              children: [
                                                ClipRRect(
                                                  borderRadius:
                                                      const BorderRadius.only(
                                                    topLeft:
                                                        Radius.circular(18.0),
                                                    bottomLeft:
                                                        Radius.circular(18.0),
                                                  ),
                                                  child: Image.network(
                                                    valueOrDefault<String>(
                                                      meal.mealImage,
                                                      'https://images.pexels.com/photos/2097090/pexels-photo-2097090.jpeg?auto=compress&cs=tinysrgb&w=600',
                                                    ),
                                                    width: 86.0,
                                                    height: double.infinity,
                                                    fit: BoxFit.cover,
                                                  ),
                                                ),
                                                Expanded(
                                                  child: Padding(
                                                    padding:
                                                        const EdgeInsetsDirectional
                                                            .fromSTEB(12.0,
                                                                12.0, 12.0, 12.0),
                                                    child: Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .center,
                                                      children: [
                                                        Text(
                                                          meal.mealName,
                                                          maxLines: 2,
                                                          overflow: TextOverflow
                                                              .ellipsis,
                                                          style: theme.bodyMedium
                                                              .override(
                                                            fontFamily: 'Sora',
                                                            letterSpacing: 0.0,
                                                            fontWeight:
                                                                FontWeight.w600,
                                                          ),
                                                        ),
                                                        if (meal.mealCalories !=
                                                            0)
                                                          Padding(
                                                            padding:
                                                                const EdgeInsetsDirectional
                                                                    .fromSTEB(
                                                                        0.0,
                                                                        6.0,
                                                                        0.0,
                                                                        0.0),
                                                            child: Text(
                                                              '${meal.mealCalories} kalori',
                                                              style: theme
                                                                  .labelMedium
                                                                  .override(
                                                                fontFamily:
                                                                    'Sora',
                                                                letterSpacing:
                                                                    0.0,
                                                              ),
                                                            ),
                                                          ),
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        );
                                      },
                                    ),
                                  );
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                    Padding(
                      padding: const EdgeInsetsDirectional.fromSTEB(
                          24.0, 24.0, 24.0, 0.0),
                      child: Text(
                        FFLocalizations.of(context).getVariableText(
                          trText: 'Bu haftan\u0131n men\u00fcs\u00fc',
                          enText: 'This week\'s menu',
                        ),
                        style: theme.titleLarge.override(
                          fontFamily: 'Sora',
                          letterSpacing: 0.0,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsetsDirectional.fromSTEB(
                          24.0, 12.0, 24.0, 24.0),
                      child: AuthUserStreamWidget(
                        builder: (context) => StreamBuilder<List<MealsRecord>>(
                          stream: queryMealsRecord(
                            queryBuilder: (mealsRecord) =>
                                selectedDiet == 'T\u00fcm\u00fc'
                                    ? mealsRecord
                                    : mealsRecord.where(
                                        'meal_diet',
                                        arrayContains: selectedDiet,
                                      ),
                          ),
                          builder: (context, snapshot) {
                            if (!snapshot.hasData) {
                              return const MealCardLoadingWidget();
                            }
                            final meals = snapshot.data ?? [];
                            if (meals.isEmpty) {
                              return Container(
                                width: double.infinity,
                                padding:
                                    const EdgeInsetsDirectional.fromSTEB(
                                        16.0, 16.0, 16.0, 16.0),
                                decoration: BoxDecoration(
                                  color: theme.secondaryBackground,
                                  borderRadius: BorderRadius.circular(16.0),
                                  border: Border.all(
                                    color: theme.accent4,
                                  ),
                                ),
                                child: Text(
                                  FFLocalizations.of(context).getVariableText(
                                    trText:
                                        'Bu kategori i\u00e7in men\u00fc bulunamad\u0131.',
                                    enText: 'No meals found for this category.',
                                  ),
                                  style: theme.labelLarge.override(
                                    fontFamily: 'Sora',
                                    letterSpacing: 0.0,
                                  ),
                                ),
                              );
                            }

                            return GridView.builder(
                              padding: EdgeInsets.zero,
                              physics: const NeverScrollableScrollPhysics(),
                              shrinkWrap: true,
                              gridDelegate:
                                  SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: crossAxisCount,
                                crossAxisSpacing: 14.0,
                                mainAxisSpacing: 14.0,
                                childAspectRatio: cardAspectRatio,
                              ),
                              itemCount: meals.length,
                              itemBuilder: (context, index) {
                                final meal = meals[index];
                                return MealCardWidget(
                                  key: Key('Keykia_${index}_of_${meals.length}'),
                                  mealRef: meal,
                                );
                              },
                            );
                          },
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ));
  }
}
