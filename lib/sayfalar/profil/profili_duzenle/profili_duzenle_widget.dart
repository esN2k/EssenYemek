// ignore_for_file: use_build_context_synchronously

import '/auth/firebase_auth/auth_util.dart';
import '/backend/backend.dart';
import '/bilesenlercomp/title_with_subtitle/title_with_subtitle_widget.dart';
import '/components/custom_appbar_widget.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'package:easy_debounce/easy_debounce.dart';
import 'package:flutter/material.dart';
import 'profili_duzenle_model.dart';
export 'profili_duzenle_model.dart';

class ProfiliDuzenleWidget extends StatefulWidget {
  const ProfiliDuzenleWidget({super.key});

  @override
  State<ProfiliDuzenleWidget> createState() => _ProfiliDuzenleWidgetState();
}

class _ProfiliDuzenleWidgetState extends State<ProfiliDuzenleWidget> {
  late ProfiliDuzenleModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => ProfiliDuzenleModel());

    logFirebaseEvent('screen_view',
        parameters: {'screen_name': 'ProfiliDuzenle'});
    _model.fullNameTextController ??= TextEditingController(
        text: valueOrDefault<String>(
      currentUserDisplayName,
      '[Gözüken İsim]',
    ));
    _model.fullNameFocusNode ??= FocusNode();

    _model.emailAddressTextController ??=
        TextEditingController(text: currentUserEmail);
    _model.emailAddressFocusNode ??= FocusNode();

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
        title: 'ProfiliDuzenle',
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
                          actionButton: true,
                          actionButtonText: 'Save',
                          actionButtonAction: () async {
                            logFirebaseEvent(
                                'PROFILI_DUZENLE_Container_or1jni5i_CALLB');
                            logFirebaseEvent('customAppbar_backend_call');

                            await currentUserReference!
                                .update(createUsersRecordData(
                              displayName: _model.fullNameTextController.text,
                            ));
                            logFirebaseEvent('customAppbar_update_page_state');
                            _model.unsavedChanges = false;
                            safeSetState(() {});
                          },
                          optionsButtonAction: () async {},
                        ),
                      ),
                      Padding(
                        padding:
                            const EdgeInsetsDirectional.fromSTEB(0.0, 24.0, 0.0, 0.0),
                        child: Text(
                          FFLocalizations.of(context).getText(
                            'h5o4ato9' /* Profili Düzenle */,
                          ),
                          style: FlutterFlowTheme.of(context)
                              .displaySmall
                              .override(
                                fontFamily: 'Sora',
                                letterSpacing: 0.0,
                              ),
                        ),
                      ),
                      Column(
                        mainAxisSize: MainAxisSize.max,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsetsDirectional.fromSTEB(
                                0.0, 18.0, 0.0, 0.0),
                            child: Column(
                              mainAxisSize: MainAxisSize.max,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: const EdgeInsetsDirectional.fromSTEB(
                                      0.0, 0.0, 0.0, 4.0),
                                  child: Text(
                                    FFLocalizations.of(context).getText(
                                      '3o2812gv' /* Ad Soyad */,
                                    ),
                                    style: FlutterFlowTheme.of(context)
                                        .bodyLarge
                                        .override(
                                          fontFamily: 'Sora',
                                          letterSpacing: 0.0,
                                        ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsetsDirectional.fromSTEB(
                                      0.0, 4.0, 0.0, 0.0),
                                  child: AuthUserStreamWidget(
                                    builder: (context) => TextFormField(
                                      controller: _model.fullNameTextController,
                                      focusNode: _model.fullNameFocusNode,
                                      onChanged: (_) => EasyDebounce.debounce(
                                        '_model.fullNameTextController',
                                        const Duration(milliseconds: 2000),
                                        () async {
                                          logFirebaseEvent(
                                              'PROFILI_DUZENLE_fullName_ON_TEXTFIELD_CH');
                                          logFirebaseEvent(
                                              'fullName_update_page_state');
                                          _model.unsavedChanges = true;
                                          safeSetState(() {});
                                        },
                                      ),
                                      autofocus: false,
                                      autofillHints: const [AutofillHints.name],
                                      textCapitalization:
                                          TextCapitalization.words,
                                      textInputAction: TextInputAction.next,
                                      obscureText: false,
                                      decoration: InputDecoration(
                                        enabledBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                            color: FlutterFlowTheme.of(context)
                                                .secondaryBackground,
                                            width: 1.0,
                                          ),
                                          borderRadius:
                                              BorderRadius.circular(8.0),
                                        ),
                                        focusedBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                            color: FlutterFlowTheme.of(context)
                                                .primary,
                                            width: 1.0,
                                          ),
                                          borderRadius:
                                              BorderRadius.circular(8.0),
                                        ),
                                        errorBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                            color: FlutterFlowTheme.of(context)
                                                .error,
                                            width: 1.0,
                                          ),
                                          borderRadius:
                                              BorderRadius.circular(8.0),
                                        ),
                                        focusedErrorBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                            color: FlutterFlowTheme.of(context)
                                                .error,
                                            width: 1.0,
                                          ),
                                          borderRadius:
                                              BorderRadius.circular(8.0),
                                        ),
                                        filled: true,
                                        fillColor: FlutterFlowTheme.of(context)
                                            .secondaryBackground,
                                      ),
                                      style: FlutterFlowTheme.of(context)
                                          .bodyMedium
                                          .override(
                                            fontFamily: 'Sora',
                                            fontSize: 16.0,
                                            letterSpacing: 0.0,
                                            fontWeight: FontWeight.w500,
                                            lineHeight: 1.0,
                                          ),
                                      minLines: 1,
                                      cursorColor:
                                          FlutterFlowTheme.of(context).primary,
                                      validator: _model
                                          .fullNameTextControllerValidator
                                          .asValidator(context),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      wrapWithModel(
                        model: _model.titleWithSubtitleModel1,
                        updateCallback: () => safeSetState(() {}),
                        child: const TitleWithSubtitleWidget(
                          title: 'Şifre Sıfırlama',
                          subtitle:
                              'Şifrenizi sıfırlamak için e-posta yoluyla bir bağlantı alın.',
                        ),
                      ),
                      Padding(
                        padding:
                            const EdgeInsetsDirectional.fromSTEB(0.0, 12.0, 0.0, 0.0),
                        child: FFButtonWidget(
                          onPressed: () async {
                            logFirebaseEvent(
                                'PROFILI_DUZENLE_IFRE_SIFIRLAMA_BTN_ON_TA');
                            logFirebaseEvent('Button_auth');
                            if (_model
                                .emailAddressTextController.text.isEmpty) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text(
                                    FFLocalizations.of(context).getText(
                                      '1ecm4fwf' /* E-posta gerekli! */,
                                    ),
                                  ),
                                ),
                              );
                              return;
                            }
                            await authManager.resetPassword(
                              email: _model.emailAddressTextController.text,
                              context: context,
                            );
                          },
                          text: FFLocalizations.of(context).getText(
                            'hr2y9oa3' /* Şifre Sıfırlama */,
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
                                .bodyMedium
                                .override(
                                  fontFamily: 'Sora',
                                  color: FlutterFlowTheme.of(context)
                                      .primaryBackground,
                                  letterSpacing: 0.0,
                                  fontWeight: FontWeight.w600,
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
                      wrapWithModel(
                        model: _model.titleWithSubtitleModel2,
                        updateCallback: () => safeSetState(() {}),
                        child: const TitleWithSubtitleWidget(
                          title: 'Hesabı Sil',
                          subtitle: 'Hesabınızdaki veriler silinecektir.',
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsetsDirectional.fromSTEB(
                            0.0, 12.0, 0.0, 48.0),
                        child: FFButtonWidget(
                          onPressed: () async {
                            logFirebaseEvent(
                                'PROFILI_DUZENLE_HESABI_SIL_BTN_ON_TAP');
                            logFirebaseEvent('Button_auth');
                            await authManager.deleteUser(context);
                            logFirebaseEvent('Button_navigate_to');

                            context.goNamed(
                              'Splash',
                              extra: <String, dynamic>{
                                kTransitionInfoKey: const TransitionInfo(
                                  hasTransition: true,
                                  transitionType: PageTransitionType.fade,
                                  duration: Duration(milliseconds: 0),
                                ),
                              },
                            );
                          },
                          text: FFLocalizations.of(context).getText(
                            'q3h3nqv8' /* Hesabı Sil */,
                          ),
                          options: FFButtonOptions(
                            width: double.infinity,
                            height: 50.0,
                            padding: const EdgeInsetsDirectional.fromSTEB(
                                0.0, 0.0, 0.0, 0.0),
                            iconPadding: const EdgeInsetsDirectional.fromSTEB(
                                0.0, 0.0, 0.0, 0.0),
                            color: const Color(0xFFFFD4D4),
                            textStyle: FlutterFlowTheme.of(context)
                                .bodyMedium
                                .override(
                                  fontFamily: 'Sora',
                                  color: const Color(0xFFB74D4D),
                                  letterSpacing: 0.0,
                                  fontWeight: FontWeight.w600,
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
                      TextFormField(
                        controller: _model.emailAddressTextController,
                        focusNode: _model.emailAddressFocusNode,
                        autofocus: false,
                        textCapitalization: TextCapitalization.words,
                        readOnly: true,
                        obscureText: false,
                        decoration: const InputDecoration(
                          isDense: true,
                          enabledBorder: InputBorder.none,
                          focusedBorder: InputBorder.none,
                          errorBorder: InputBorder.none,
                          focusedErrorBorder: InputBorder.none,
                        ),
                        style: FlutterFlowTheme.of(context).bodyMedium.override(
                              fontFamily: 'Sora',
                              color: FlutterFlowTheme.of(context)
                                  .primaryBackground,
                              fontSize: 1.0,
                              letterSpacing: 0.0,
                              fontWeight: FontWeight.w500,
                              lineHeight: 1.0,
                            ),
                        minLines: 1,
                        validator: _model.emailAddressTextControllerValidator
                            .asValidator(context),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ));
  }
}
