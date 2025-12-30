import '/auth/firebase_auth/auth_util.dart';
import '/backend/backend.dart';
import '/backend/order_service.dart';
import '/backend/plan_service.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'plan_model.dart';
export 'plan_model.dart';

class PlanWidget extends StatefulWidget {
  const PlanWidget({super.key});

  @override
  State<PlanWidget> createState() => _PlanWidgetState();
}

class _PlanWidgetState extends State<PlanWidget> {
  late PlanModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => PlanModel());

    logFirebaseEvent('screen_view', parameters: {'screen_name': 'Plan'});
    SchedulerBinding.instance.addPostFrameCallback((_) async {
      logFirebaseEvent('PLAN_PAGE_Plan_ON_INIT_STATE');
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
    final planMeals = appState.planMeals;
    final planType = appState.planType;
    final planMealsPerWeek = appState.planMealsPerWeek;
    final planServings = appState.planServings;
    final planDeliveryDay = appState.planDeliveryDay;
    final deliveryDays = <String>[
      'Pazartesi',
      'Sal\u0131',
      '\u00c7ar\u015famba',
      'Per\u015fembe',
      'Cuma',
      'Cumartesi',
      'Pazar',
    ];
    final planTotal = planMealsPerWeek * planServings * 79;
    final nextDelivery = PlanService.nextDeliveryDate(planDeliveryDay);

    return Title(
        title: 'Plan',
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
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsetsDirectional.fromSTEB(
                          24.0, 16.0, 24.0, 0.0),
                      child: Text(
                        FFLocalizations.of(context).getVariableText(
                          trText: 'Plan\u0131n',
                          enText: 'Your plan',
                        ),
                        style: theme.displaySmall.override(
                          fontFamily: 'Sora',
                          letterSpacing: -0.5,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsetsDirectional.fromSTEB(
                          24.0, 16.0, 24.0, 0.0),
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
                        child: Padding(
                          padding: const EdgeInsetsDirectional.fromSTEB(
                              20.0, 18.0, 20.0, 18.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                planType,
                                style: theme.labelLarge.override(
                                  fontFamily: 'Sora',
                                  color: theme.secondaryBackground,
                                  letterSpacing: 0.0,
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsetsDirectional.fromSTEB(
                                    0.0, 8.0, 0.0, 12.0),
                                child: Text(
                                  '$planMealsPerWeek yemek - $planServings ki\u015fi',
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
                                    padding: const EdgeInsetsDirectional.fromSTEB(
                                        8.0, 0.0, 0.0, 0.0),
                                    child: Text(
                                      FFLocalizations.of(context)
                                          .getVariableText(
                                        trText:
                                            'Sonraki teslimat: ${dateTimeFormat("MMM d", nextDelivery, locale: FFLocalizations.of(context).languageCode)}',
                                        enText:
                                            'Next delivery: ${dateTimeFormat("MMM d", nextDelivery, locale: FFLocalizations.of(context).languageCode)}',
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
                                padding: const EdgeInsetsDirectional.fromSTEB(
                                    0.0, 12.0, 0.0, 0.0),
                                child: Text(
                                  FFLocalizations.of(context).getVariableText(
                                    trText:
                                        'Tahmini tutar: ${formatNumber(planTotal, formatType: FormatType.decimal)} TL',
                                    enText:
                                        'Estimated total: ${formatNumber(planTotal, formatType: FormatType.decimal)} TL',
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
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsetsDirectional.fromSTEB(
                          24.0, 24.0, 24.0, 0.0),
                      child: Text(
                        FFLocalizations.of(context).getVariableText(
                          trText: 'Plan detaylar\u0131',
                          enText: 'Plan details',
                        ),
                        style: theme.titleLarge.override(
                          fontFamily: 'Sora',
                          letterSpacing: 0.0,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsetsDirectional.fromSTEB(
                          24.0, 12.0, 24.0, 0.0),
                      child: Wrap(
                        spacing: 10.0,
                        runSpacing: 10.0,
                        children: [
                          'Dengeli',
                          'Fit',
                          'Vegan',
                          'H\u0131zl\u0131',
                        ].map((option) {
                          final isSelected = option == planType;
                          return InkWell(
                            onTap: () async {
                              FFAppState().update(() {
                                FFAppState().planType = option;
                              });
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
                        }).toList(),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsetsDirectional.fromSTEB(
                          24.0, 16.0, 24.0, 0.0),
                      child: Text(
                        FFLocalizations.of(context).getVariableText(
                          trText: 'Haftal\u0131k yemek say\u0131s\u0131',
                          enText: 'Meals per week',
                        ),
                        style: theme.titleSmall.override(
                          fontFamily: 'Sora',
                          letterSpacing: 0.0,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsetsDirectional.fromSTEB(
                          24.0, 8.0, 24.0, 0.0),
                      child: Wrap(
                        spacing: 10.0,
                        runSpacing: 10.0,
                        children: [3, 4, 5, 6].map((mealCount) {
                          final isSelected = mealCount == planMealsPerWeek;
                          return InkWell(
                            onTap: () async {
                              FFAppState().update(() {
                                FFAppState().planMealsPerWeek = mealCount;
                              });
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
                                '$mealCount',
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
                        }).toList(),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsetsDirectional.fromSTEB(
                          24.0, 16.0, 24.0, 0.0),
                      child: Text(
                        FFLocalizations.of(context).getVariableText(
                          trText: 'Ka\u00e7 ki\u015fi',
                          enText: 'Servings',
                        ),
                        style: theme.titleSmall.override(
                          fontFamily: 'Sora',
                          letterSpacing: 0.0,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsetsDirectional.fromSTEB(
                          24.0, 8.0, 24.0, 0.0),
                      child: Wrap(
                        spacing: 10.0,
                        runSpacing: 10.0,
                        children: [1, 2, 4].map((servingCount) {
                          final isSelected = servingCount == planServings;
                          return InkWell(
                            onTap: () async {
                              FFAppState().update(() {
                                FFAppState().planServings = servingCount;
                              });
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
                                '$servingCount',
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
                        }).toList(),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsetsDirectional.fromSTEB(
                          24.0, 16.0, 24.0, 0.0),
                      child: Text(
                        FFLocalizations.of(context).getVariableText(
                          trText: 'Teslimat g\u00fcn\u00fc',
                          enText: 'Delivery day',
                        ),
                        style: theme.titleSmall.override(
                          fontFamily: 'Sora',
                          letterSpacing: 0.0,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsetsDirectional.fromSTEB(
                          24.0, 8.0, 24.0, 0.0),
                      child: DropdownButtonFormField<String>(
                        key: ValueKey(planDeliveryDay),
                        initialValue: planDeliveryDay,
                        items: deliveryDays
                            .map((day) => DropdownMenuItem<String>(
                                  value: day,
                                  child: Text(day),
                                ))
                            .toList(),
                        onChanged: (value) {
                          if (value == null) {
                            return;
                          }
                          FFAppState().update(() {
                            FFAppState().planDeliveryDay = value;
                          });
                        },
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: theme.secondaryBackground,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(16.0),
                            borderSide: BorderSide(color: theme.accent4),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(16.0),
                            borderSide: BorderSide(color: theme.accent4),
                          ),
                          contentPadding: const EdgeInsetsDirectional.fromSTEB(
                              12.0, 12.0, 12.0, 12.0),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsetsDirectional.fromSTEB(
                          24.0, 24.0, 24.0, 0.0),
                      child: Text(
                        FFLocalizations.of(context).getVariableText(
                          trText: 'Se\u00e7ilen yemekler',
                          enText: 'Selected meals',
                        ),
                        style: theme.titleLarge.override(
                          fontFamily: 'Sora',
                          letterSpacing: 0.0,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsetsDirectional.fromSTEB(
                          24.0, 6.0, 24.0, 0.0),
                      child: Text(
                        '${planMeals.length}/$planMealsPerWeek yemek se\u00e7ildi',
                        style: theme.labelLarge.override(
                          fontFamily: 'Sora',
                          letterSpacing: 0.0,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsetsDirectional.fromSTEB(
                          24.0, 12.0, 24.0, 0.0),
                      child: planMeals.isEmpty
                          ? Container(
                              width: double.infinity,
                              padding: const EdgeInsetsDirectional.fromSTEB(
                                  16.0, 14.0, 16.0, 14.0),
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
                                      'Men\u00fc sayfas\u0131ndan yemek ekleyebilirsin.',
                                  enText:
                                      'Add meals from the menu to fill your plan.',
                                ),
                                style: theme.labelLarge.override(
                                  fontFamily: 'Sora',
                                  letterSpacing: 0.0,
                                ),
                              ),
                            )
                          : Column(
                              children: planMeals.map((mealRef) {
                                return Padding(
                                  padding: const EdgeInsetsDirectional.fromSTEB(
                                      0.0, 0.0, 0.0, 12.0),
                                  child: StreamBuilder<MealsRecord>(
                                    stream:
                                        MealsRecord.getDocument(mealRef),
                                    builder: (context, snapshot) {
                                      if (!snapshot.hasData) {
                                        return Container(
                                          height: 84.0,
                                          decoration: BoxDecoration(
                                            color: theme.secondaryBackground,
                                            borderRadius:
                                                BorderRadius.circular(16.0),
                                            border: Border.all(
                                              color: theme.accent4,
                                            ),
                                          ),
                                        );
                                      }
                                      final meal = snapshot.data!;
                                      return Container(
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
                                            ClipRRect(
                                              borderRadius:
                                                  const BorderRadius.only(
                                                topLeft: Radius.circular(16.0),
                                                bottomLeft:
                                                    Radius.circular(16.0),
                                              ),
                                              child: Image.network(
                                                valueOrDefault<String>(
                                                  meal.mealImage,
                                                  'https://images.pexels.com/photos/2097090/pexels-photo-2097090.jpeg?auto=compress&cs=tinysrgb&w=300',
                                                ),
                                                width: 84.0,
                                                height: 84.0,
                                                fit: BoxFit.cover,
                                              ),
                                            ),
                                            Expanded(
                                              child: Padding(
                                                padding:
                                                    const EdgeInsetsDirectional
                                                        .fromSTEB(12.0, 12.0, 12.0, 12.0),
                                                child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Text(
                                                      meal.mealName,
                                                      maxLines: 2,
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                      style: theme.bodyMedium
                                                          .override(
                                                        fontFamily: 'Sora',
                                                        letterSpacing: 0.0,
                                                        fontWeight:
                                                            FontWeight.w600,
                                                      ),
                                                    ),
                                                    if (meal.mealCalories != 0)
                                                      Padding(
                                                        padding:
                                                            const EdgeInsetsDirectional
                                                                .fromSTEB(0.0, 6.0, 0.0, 0.0),
                                                        child: Text(
                                                          '${meal.mealCalories} kalori',
                                                          style: theme
                                                              .labelMedium
                                                              .override(
                                                            fontFamily: 'Sora',
                                                            letterSpacing: 0.0,
                                                          ),
                                                        ),
                                                      ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                            IconButton(
                                              onPressed: () async {
                                                FFAppState().update(() {
                                                  FFAppState()
                                                      .removeFromPlanMeals(
                                                          meal.reference);
                                                });
                                                final userRef =
                                                    currentUserReference;
                                                if (userRef != null) {
                                                  await PlanService
                                                      .savePlanFromState(
                                                    state: FFAppState(),
                                                    userRef: userRef,
                                                  );
                                                }
                                              },
                                              icon: Icon(
                                                Icons.close_rounded,
                                                color: theme.secondaryText,
                                              ),
                                            ),
                                          ],
                                        ),
                                      );
                                    },
                                  ),
                                );
                              }).toList(),
                            ),
                    ),
                    Padding(
                      padding: const EdgeInsetsDirectional.fromSTEB(
                          24.0, 24.0, 24.0, 0.0),
                      child: Text(
                        FFLocalizations.of(context).getVariableText(
                          trText: 'Teslimat takibi',
                          enText: 'Delivery tracking',
                        ),
                        style: theme.titleLarge.override(
                          fontFamily: 'Sora',
                          letterSpacing: 0.0,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsetsDirectional.fromSTEB(
                          24.0, 12.0, 24.0, 0.0),
                      child: Container(
                        decoration: BoxDecoration(
                          color: theme.secondaryBackground,
                          borderRadius: BorderRadius.circular(20.0),
                          border: Border.all(
                            color: theme.accent4,
                          ),
                        ),
                        child: Padding(
                          padding: const EdgeInsetsDirectional.fromSTEB(
                              16.0, 16.0, 16.0, 16.0),
                          child: Row(
                            children: List.generate(4, (index) {
                              const steps = [
                                'Haz\u0131rlan\u0131yor',
                                'Paketlendi',
                                'Yolda',
                                'Teslim',
                              ];
                              const currentStep = 1;
                              final isActive = index <= currentStep;
                              return Expanded(
                                child: Column(
                                  children: [
                                    Icon(
                                      isActive
                                          ? Icons.check_circle
                                          : Icons.radio_button_unchecked,
                                      color: isActive
                                          ? theme.primary
                                          : theme.accent4,
                                      size: 20.0,
                                    ),
                                    Padding(
                                      padding:
                                          const EdgeInsetsDirectional.fromSTEB(
                                              0.0, 6.0, 0.0, 0.0),
                                      child: Text(
                                        steps[index],
                                        textAlign: TextAlign.center,
                                        style: theme.labelSmall.override(
                                          fontFamily: 'Sora',
                                          color: isActive
                                              ? theme.primaryText
                                              : theme.secondaryText,
                                          letterSpacing: 0.0,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            }),
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsetsDirectional.fromSTEB(
                          24.0, 24.0, 24.0, 32.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          FFButtonWidget(
                            onPressed: () async {
                              logFirebaseEvent('PLAN_PAGE_OrderButton_ON_TAP');
                              final userRef = currentUserReference;
                              if (userRef == null) {
                                showSnackbar(
                                  context,
                                  FFLocalizations.of(context).getVariableText(
                                    trText:
                                        'Sipari\u015f vermek i\u00e7in giri\u015f yapmal\u0131s\u0131n.',
                                    enText: 'Please sign in to place an order.',
                                  ),
                                );
                                return;
                              }
                              if (planMeals.length < planMealsPerWeek) {
                                showSnackbar(
                                  context,
                                  FFLocalizations.of(context).getVariableText(
                                    trText:
                                        'Sipari\u015f i\u00e7in t\u00fcm yemekleri se\u00e7.',
                                    enText:
                                        'Select all meals before ordering.',
                                  ),
                                );
                                return;
                              }
                              await PlanService.savePlanFromState(
                                state: FFAppState(),
                                userRef: userRef,
                              );
                              await OrderService.createOrderFromPlan(
                                userRef: userRef,
                                state: FFAppState(),
                              );
                              if (!context.mounted) {
                                return;
                              }
                              showSnackbar(
                                context,
                                FFLocalizations.of(context).getVariableText(
                                  trText: 'Sipari\u015f olu\u015fturuldu.',
                                  enText: 'Order created.',
                                ),
                              );
                              context.pushNamed('Siparisler');
                            },
                            text: FFLocalizations.of(context).getVariableText(
                              trText: 'Sipari\u015f ver',
                              enText: 'Place order',
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
                          Padding(
                            padding: const EdgeInsetsDirectional.fromSTEB(
                                0.0, 12.0, 0.0, 0.0),
                            child: FFButtonWidget(
                              onPressed: () async {
                                logFirebaseEvent(
                                    'PLAN_PAGE_UpdateButton_ON_TAP');
                                final userRef = currentUserReference;
                              if (userRef != null) {
                                await PlanService.savePlanFromState(
                                  state: FFAppState(),
                                  userRef: userRef,
                                );
                              }
                              if (!context.mounted) {
                                return;
                              }
                              showSnackbar(
                                context,
                                FFLocalizations.of(context).getVariableText(
                                    trText: 'Plan g\u00fcncellendi.',
                                    enText: 'Plan updated.',
                                  ),
                                );
                              },
                              text: FFLocalizations.of(context)
                                  .getVariableText(
                                trText: 'Plan\u0131 g\u00fcncelle',
                                enText: 'Update plan',
                              ),
                              options: FFButtonOptions(
                                height: 48.0,
                                padding: const EdgeInsetsDirectional.fromSTEB(
                                    16.0, 0.0, 16.0, 0.0),
                                color: theme.secondaryBackground,
                                textStyle: theme.bodyMedium.override(
                                  fontFamily: 'Sora',
                                  color: theme.primaryText,
                                  letterSpacing: 0.0,
                                  fontWeight: FontWeight.w600,
                                ),
                                elevation: 0.0,
                                borderSide: BorderSide(
                                  color: theme.accent4,
                                  width: 1.0,
                                ),
                                borderRadius: BorderRadius.circular(24.0),
                              ),
                            ),
                          ),
                          if (kDebugMode)
                            Padding(
                              padding: const EdgeInsetsDirectional.fromSTEB(
                                  0.0, 12.0, 0.0, 0.0),
                              child: FFButtonWidget(
                                onPressed: () async {
                                  final userRef = currentUserReference;
                                  if (userRef == null) {
                                    return;
                                  }
                                  await PlanService.seedSamplePlan(
                                    userRef: userRef,
                                  );
                                  await OrderService.seedSampleOrders(
                                    userRef: userRef,
                                  );
                                  if (!context.mounted) {
                                    return;
                                  }
                                  showSnackbar(
                                    context,
                                    FFLocalizations.of(context).getVariableText(
                                      trText: 'Demo verileri eklendi.',
                                      enText: 'Demo data seeded.',
                                    ),
                                  );
                                },
                                text: FFLocalizations.of(context)
                                    .getVariableText(
                                  trText: 'Demo verisi olu\u015ftur',
                                  enText: 'Seed demo data',
                                ),
                                options: FFButtonOptions(
                                  height: 44.0,
                                  padding:
                                      const EdgeInsetsDirectional.fromSTEB(
                                          16.0, 0.0, 16.0, 0.0),
                                  color: theme.accent1,
                                  textStyle: theme.bodyMedium.override(
                                    fontFamily: 'Sora',
                                    color: theme.primaryText,
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
                        ],
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
