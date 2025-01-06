import '/auth/firebase_auth/auth_util.dart';
import '/backend/backend.dart';
import '/bilesenlercomp/meal_card/meal_card_widget.dart';
import '/bilesenlercomp/meal_card_loading/meal_card_loading_widget.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/services.dart';
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
    return Title(
        title: 'Panel',
        color: FlutterFlowTheme.of(context).primary.withAlpha(0XFF),
        child: GestureDetector(
          onTap: () {
            FocusScope.of(context).unfocus();
            FocusManager.instance.primaryFocus?.unfocus();
          },
          child: Scaffold(
            key: scaffoldKey,
            backgroundColor: FlutterFlowTheme.of(context).primaryBackground,
            body: SafeArea(
              top: true,
              child: Column(
                mainAxisSize: MainAxisSize.max,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding:
                        const EdgeInsetsDirectional.fromSTEB(16.0, 32.0, 16.0, 16.0),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          FFLocalizations.of(context).getText(
                            'c4t4o3xf' /* Bu haftanın yemekleri */,
                          ),
                          style: FlutterFlowTheme.of(context)
                              .displaySmall
                              .override(
                                fontFamily: 'Inter',
                                letterSpacing: 0.0,
                                fontWeight: FontWeight.w600,
                              ),
                        ),
                        Padding(
                          padding: const EdgeInsetsDirectional.fromSTEB(
                              0.0, 6.0, 0.0, 0.0),
                          child: Text(
                            FFLocalizations.of(context).getText(
                              'ypkv73np' /* Her hafta taze malzemelerle si... */,
                            ),
                            style: FlutterFlowTheme.of(context)
                                .labelLarge
                                .override(
                                  fontFamily: 'Inter',
                                  letterSpacing: 0.0,
                                ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(14.0),
                      child: AuthUserStreamWidget(
                        builder: (context) => StreamBuilder<List<MealsRecord>>(
                          stream: queryMealsRecord(
                            queryBuilder: (mealsRecord) => mealsRecord.where(
                              'meal_diet',
                              arrayContains:
                                  valueOrDefault(currentUserDocument?.diet, ''),
                            ),
                          ),
                          builder: (context, snapshot) {
                            // Customize what your widget looks like when it's loading.
                            if (!snapshot.hasData) {
                              return const MealCardLoadingWidget();
                            }
                            List<MealsRecord> gridViewMealsRecordList =
                                snapshot.data!;

                            return GridView.builder(
                              padding: EdgeInsets.zero,
                              gridDelegate:
                                  const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 2,
                                crossAxisSpacing: 10.0,
                                mainAxisSpacing: 10.0,
                                childAspectRatio: 0.78,
                              ),
                              scrollDirection: Axis.vertical,
                              itemCount: gridViewMealsRecordList.length,
                              itemBuilder: (context, gridViewIndex) {
                                final gridViewMealsRecord =
                                    gridViewMealsRecordList[gridViewIndex];
                                return MealCardWidget(
                                  key: Key(
                                      'Keykia_${gridViewIndex}_of_${gridViewMealsRecordList.length}'),
                                  mealRef: gridViewMealsRecord,
                                );
                              },
                            );
                          },
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ));
  }
}
