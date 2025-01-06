import '/auth/firebase_auth/auth_util.dart';
import '/backend/backend.dart';
import '/bilesenlercomp/diet_item/diet_item_widget.dart';
import '/bilesenlercomp/preference_item/preference_item_widget.dart';
import '/components/custom_appbar_widget.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/services.dart';
import 'tercihleri_duzenle_model.dart';
export 'tercihleri_duzenle_model.dart';

class TercihleriDuzenleWidget extends StatefulWidget {
  const TercihleriDuzenleWidget({
    super.key,
    required this.page,
  });

  final int? page;

  @override
  State<TercihleriDuzenleWidget> createState() =>
      _TercihleriDuzenleWidgetState();
}

class _TercihleriDuzenleWidgetState extends State<TercihleriDuzenleWidget> {
  late TercihleriDuzenleModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => TercihleriDuzenleModel());

    logFirebaseEvent('screen_view',
        parameters: {'screen_name': 'TercihleriDuzenle'});
    // On page load action.
    SchedulerBinding.instance.addPostFrameCallback((_) async {
      logFirebaseEvent('TERCIHLERI_DUZENLE_TercihleriDuzenle_ON_');
      logFirebaseEvent('TercihleriDuzenle_update_page_state');
      _model.allergenSelection =
          (currentUserDocument?.allergens.toList() ?? [])
              .toList()
              .cast<String>();
      _model.dietSelection = valueOrDefault(currentUserDocument?.diet, '');
      _model.ingredientSelection =
          (currentUserDocument?.ingredientDislikes.toList() ?? [])
              .toList()
              .cast<String>();
      safeSetState(() {});
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
    return StreamBuilder<List<OnboardingOptionsRecord>>(
      stream: queryOnboardingOptionsRecord(
        singleRecord: true,
      ),
      builder: (context, snapshot) {
        // Customize what your widget looks like when it's loading.
        if (!snapshot.hasData) {
          return Scaffold(
            backgroundColor: FlutterFlowTheme.of(context).primaryBackground,
            body: Center(
              child: SizedBox(
                width: 25.0,
                height: 25.0,
                child: CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(
                    FlutterFlowTheme.of(context).primary,
                  ),
                ),
              ),
            ),
          );
        }
        List<OnboardingOptionsRecord>
            tercihleriDuzenleOnboardingOptionsRecordList = snapshot.data!;
        // Return an empty Container when the item does not exist.
        if (snapshot.data!.isEmpty) {
          return Container();
        }
        final tercihleriDuzenleOnboardingOptionsRecord =
            tercihleriDuzenleOnboardingOptionsRecordList.isNotEmpty
                ? tercihleriDuzenleOnboardingOptionsRecordList.first
                : null;

        return Title(
            title: 'TercihleriDuzenle',
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
                    children: [
                      Expanded(
                        child: Align(
                          alignment: const AlignmentDirectional(0.0, 0.0),
                          child: Padding(
                            padding: const EdgeInsets.all(24.0),
                            child: Column(
                              mainAxisSize: MainAxisSize.max,
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                wrapWithModel(
                                  model: _model.customAppbarModel,
                                  updateCallback: () => safeSetState(() {}),
                                  child: CustomAppbarWidget(
                                    backButton: true,
                                    actionButton: false,
                                    optionsButton: false,
                                    actionButtonAction: () async {},
                                    optionsButtonAction: () async {},
                                  ),
                                ),
                                Expanded(
                                  child: SizedBox(
                                    width: double.infinity,
                                    height: 500.0,
                                    child: PageView(
                                      physics:
                                          const NeverScrollableScrollPhysics(),
                                      controller: _model.pageViewController ??=
                                          PageController(
                                              initialPage: max(
                                                  0,
                                                  min(
                                                      valueOrDefault<int>(
                                                        widget.page,
                                                        0,
                                                      ),
                                                      2))),
                                      scrollDirection: Axis.horizontal,
                                      children: [
                                        Column(
                                          mainAxisSize: MainAxisSize.max,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Padding(
                                              padding: const EdgeInsetsDirectional
                                                  .fromSTEB(
                                                      0.0, 24.0, 0.0, 0.0),
                                              child: Text(
                                                FFLocalizations.of(context)
                                                    .getText(
                                                  'lu3dj396' /* Diyeti güncelleyin */,
                                                ),
                                                style:
                                                    FlutterFlowTheme.of(context)
                                                        .displaySmall
                                                        .override(
                                                          fontFamily: 'Inter',
                                                          letterSpacing: 0.0,
                                                        ),
                                              ),
                                            ),
                                            Padding(
                                              padding: const EdgeInsetsDirectional
                                                  .fromSTEB(
                                                      0.0, 18.0, 0.0, 0.0),
                                              child: Builder(
                                                builder: (context) {
                                                  final diet =
                                                      tercihleriDuzenleOnboardingOptionsRecord
                                                              ?.dietOptions
                                                              .toList() ??
                                                          [];

                                                  return Column(
                                                    mainAxisSize:
                                                        MainAxisSize.min,
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: List.generate(
                                                        diet.length,
                                                        (dietIndex) {
                                                      final dietItem =
                                                          diet[dietIndex];
                                                      return DietItemWidget(
                                                        key: Key(
                                                            'Keynmz_${dietIndex}_of_${diet.length}'),
                                                        dietType:
                                                            dietItem.dietName,
                                                        selectedDiet: _model
                                                            .dietSelection!,
                                                        dietTagline: dietItem
                                                            .dietTagline,
                                                        action: () async {
                                                          logFirebaseEvent(
                                                              'TERCIHLERI_DUZENLE_Container_nmzhibnb_CA');
                                                          logFirebaseEvent(
                                                              'dietItem_haptic_feedback');
                                                          HapticFeedback
                                                              .selectionClick();
                                                          logFirebaseEvent(
                                                              'dietItem_update_page_state');
                                                          _model.dietSelection =
                                                              dietItem.dietName;
                                                          safeSetState(() {});
                                                        },
                                                      );
                                                    }).divide(
                                                        const SizedBox(height: 8.0)),
                                                  );
                                                },
                                              ),
                                            ),
                                          ],
                                        ),
                                        Column(
                                          mainAxisSize: MainAxisSize.max,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Padding(
                                              padding: const EdgeInsetsDirectional
                                                  .fromSTEB(
                                                      0.0, 24.0, 0.0, 0.0),
                                              child: Text(
                                                FFLocalizations.of(context)
                                                    .getText(
                                                  '3czgpbc4' /* Update allergies */,
                                                ),
                                                style:
                                                    FlutterFlowTheme.of(context)
                                                        .displaySmall
                                                        .override(
                                                          fontFamily: 'Inter',
                                                          letterSpacing: 0.0,
                                                        ),
                                              ),
                                            ),
                                            Padding(
                                              padding: const EdgeInsetsDirectional
                                                  .fromSTEB(
                                                      0.0, 18.0, 0.0, 0.0),
                                              child: Column(
                                                mainAxisSize: MainAxisSize.min,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Builder(
                                                    builder: (context) {
                                                      final allergens =
                                                          tercihleriDuzenleOnboardingOptionsRecord
                                                                  ?.allergenOptions
                                                                  .toList() ??
                                                              [];

                                                      return Wrap(
                                                        spacing: 8.0,
                                                        runSpacing: 8.0,
                                                        alignment:
                                                            WrapAlignment.start,
                                                        crossAxisAlignment:
                                                            WrapCrossAlignment
                                                                .start,
                                                        direction:
                                                            Axis.horizontal,
                                                        runAlignment:
                                                            WrapAlignment.start,
                                                        verticalDirection:
                                                            VerticalDirection
                                                                .down,
                                                        clipBehavior: Clip.none,
                                                        children: List.generate(
                                                            allergens.length,
                                                            (allergensIndex) {
                                                          final allergensItem =
                                                              allergens[
                                                                  allergensIndex];
                                                          return PreferenceItemWidget(
                                                            key: Key(
                                                                'Key2pp_${allergensIndex}_of_${allergens.length}'),
                                                            text: allergensItem,
                                                            selectedItems: _model
                                                                .allergenSelection,
                                                            action: () async {
                                                              logFirebaseEvent(
                                                                  'TERCIHLERI_DUZENLE_Container_2pp5tbdq_CA');
                                                              if (_model
                                                                  .allergenSelection
                                                                  .contains(
                                                                      allergensItem)) {
                                                                logFirebaseEvent(
                                                                    'preferenceItem_haptic_feedback');
                                                                HapticFeedback
                                                                    .selectionClick();
                                                                logFirebaseEvent(
                                                                    'preferenceItem_update_page_state');
                                                                _model.removeFromAllergenSelection(
                                                                    allergensItem);
                                                                safeSetState(
                                                                    () {});
                                                              } else {
                                                                logFirebaseEvent(
                                                                    'preferenceItem_haptic_feedback');
                                                                HapticFeedback
                                                                    .selectionClick();
                                                                logFirebaseEvent(
                                                                    'preferenceItem_update_page_state');
                                                                _model.addToAllergenSelection(
                                                                    allergensItem);
                                                                safeSetState(
                                                                    () {});
                                                              }
                                                            },
                                                          );
                                                        }),
                                                      );
                                                    },
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                        Column(
                                          mainAxisSize: MainAxisSize.max,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Padding(
                                              padding: const EdgeInsetsDirectional
                                                  .fromSTEB(
                                                      0.0, 24.0, 0.0, 0.0),
                                              child: Text(
                                                FFLocalizations.of(context)
                                                    .getText(
                                                  '1d7qfql6' /* Update dislikes */,
                                                ),
                                                style:
                                                    FlutterFlowTheme.of(context)
                                                        .displaySmall
                                                        .override(
                                                          fontFamily: 'Inter',
                                                          letterSpacing: 0.0,
                                                        ),
                                              ),
                                            ),
                                            Padding(
                                              padding: const EdgeInsetsDirectional
                                                  .fromSTEB(
                                                      0.0, 18.0, 0.0, 0.0),
                                              child: Column(
                                                mainAxisSize: MainAxisSize.min,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Builder(
                                                    builder: (context) {
                                                      final dislikes =
                                                          tercihleriDuzenleOnboardingOptionsRecord
                                                                  ?.ingredientOptions
                                                                  .toList() ??
                                                              [];

                                                      return Wrap(
                                                        spacing: 8.0,
                                                        runSpacing: 8.0,
                                                        alignment:
                                                            WrapAlignment.start,
                                                        crossAxisAlignment:
                                                            WrapCrossAlignment
                                                                .start,
                                                        direction:
                                                            Axis.horizontal,
                                                        runAlignment:
                                                            WrapAlignment.start,
                                                        verticalDirection:
                                                            VerticalDirection
                                                                .down,
                                                        clipBehavior: Clip.none,
                                                        children: List.generate(
                                                            dislikes.length,
                                                            (dislikesIndex) {
                                                          final dislikesItem =
                                                              dislikes[
                                                                  dislikesIndex];
                                                          return PreferenceItemWidget(
                                                            key: Key(
                                                                'Keyarx_${dislikesIndex}_of_${dislikes.length}'),
                                                            text: dislikesItem,
                                                            selectedItems: _model
                                                                .ingredientSelection,
                                                            action: () async {
                                                              logFirebaseEvent(
                                                                  'TERCIHLERI_DUZENLE_Container_arxiy5m7_CA');
                                                              if (_model
                                                                  .ingredientSelection
                                                                  .contains(
                                                                      dislikesItem)) {
                                                                logFirebaseEvent(
                                                                    'preferenceItem_haptic_feedback');
                                                                HapticFeedback
                                                                    .selectionClick();
                                                                logFirebaseEvent(
                                                                    'preferenceItem_update_page_state');
                                                                _model.removeFromIngredientSelection(
                                                                    dislikesItem);
                                                                safeSetState(
                                                                    () {});
                                                              } else {
                                                                logFirebaseEvent(
                                                                    'preferenceItem_haptic_feedback');
                                                                HapticFeedback
                                                                    .selectionClick();
                                                                logFirebaseEvent(
                                                                    'preferenceItem_update_page_state');
                                                                _model.addToIngredientSelection(
                                                                    dislikesItem);
                                                                safeSetState(
                                                                    () {});
                                                              }
                                                            },
                                                          );
                                                        }),
                                                      );
                                                    },
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
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
                            24.0, 0.0, 24.0, 12.0),
                        child: FFButtonWidget(
                          onPressed: () async {
                            logFirebaseEvent(
                                'TERCIHLERI_DUZENLE_UPDATE_BTN_ON_TAP');
                            logFirebaseEvent('Button_haptic_feedback');
                            HapticFeedback.lightImpact();
                            logFirebaseEvent('Button_backend_call');

                            await currentUserReference!.update({
                              ...createUsersRecordData(
                                diet: _model.dietSelection,
                              ),
                              ...mapToFirestore(
                                {
                                  'allergens': _model.allergenSelection,
                                  'ingredient_dislikes':
                                      _model.ingredientSelection,
                                },
                              ),
                            });
                            logFirebaseEvent('Button_navigate_back');
                            context.pop();
                          },
                          text: FFLocalizations.of(context).getText(
                            'b1h6hi6e' /* Update */,
                          ),
                          options: FFButtonOptions(
                            width: double.infinity,
                            height: 50.0,
                            padding: const EdgeInsetsDirectional.fromSTEB(
                                0.0, 0.0, 0.0, 0.0),
                            iconPadding: const EdgeInsetsDirectional.fromSTEB(
                                0.0, 0.0, 0.0, 0.0),
                            color: FlutterFlowTheme.of(context).primary,
                            textStyle: FlutterFlowTheme.of(context)
                                .titleSmall
                                .override(
                                  fontFamily: 'Inter',
                                  letterSpacing: 0.0,
                                ),
                            elevation: 0.0,
                            borderSide: const BorderSide(
                              color: Colors.transparent,
                              width: 1.0,
                            ),
                            borderRadius: BorderRadius.circular(25.0),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ));
      },
    );
  }
}
