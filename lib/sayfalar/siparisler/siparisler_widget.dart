
import '/auth/firebase_auth/auth_util.dart';
import '/backend/backend.dart';
import '/backend/order_service.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/services.dart';
import 'siparisler_model.dart';
export 'siparisler_model.dart';

class SiparislerWidget extends StatefulWidget {
  const SiparislerWidget({
    super.key,
    this.ordersStream,
  });

  final Stream<List<OrdersRecord>>? ordersStream;

  @override
  State<SiparislerWidget> createState() => _SiparislerWidgetState();
}

class _SiparislerWidgetState extends State<SiparislerWidget> {
  late SiparislerModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => SiparislerModel());

    logFirebaseEvent('screen_view', parameters: {'screen_name': 'Siparisler'});
    SchedulerBinding.instance.addPostFrameCallback((_) async {
      logFirebaseEvent('SIPARISLER_PAGE_Siparisler_ON_INIT_STATE');
      HapticFeedback.mediumImpact();
    });

    WidgetsBinding.instance.addPostFrameCallback((_) => safeSetState(() {}));
  }

  @override
  void dispose() {
    _model.dispose();

    super.dispose();
  }

  int _statusIndex(String status) {
    switch (status) {
      case 'Haz\u0131rlan\u0131yor':
        return 0;
      case 'Paketlendi':
        return 1;
      case 'Yolda':
        return 2;
      case 'Teslim':
        return 3;
      default:
        return 0;
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = FlutterFlowTheme.of(context);
    final userRef = currentUserReference;
    final ordersStream = widget.ordersStream ??
        (userRef == null ? null : OrderService.streamOrders(userRef));

    return Title(
        title: 'Sipari\u015fler',
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
              child: ordersStream == null
                  ? Padding(
                      padding: const EdgeInsetsDirectional.fromSTEB(
                          24.0, 16.0, 24.0, 0.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            FFLocalizations.of(context).getVariableText(
                              trText: 'Sipari\u015fler',
                              enText: 'Orders',
                            ),
                            style: theme.displaySmall.override(
                              fontFamily: 'Sora',
                              letterSpacing: -0.5,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsetsDirectional.fromSTEB(
                                0.0, 16.0, 0.0, 0.0),
                            child: Container(
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
                                      'Sipari\u015flerini g\u00f6rmek i\u00e7in giri\u015f yapmal\u0131s\u0131n.',
                                  enText:
                                      'Please sign in to view your orders.',
                                ),
                                style: theme.labelLarge.override(
                                  fontFamily: 'Sora',
                                  letterSpacing: 0.0,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    )
                  : StreamBuilder<List<OrdersRecord>>(
                      stream: ordersStream,
                      builder: (context, snapshot) {
                        if (!snapshot.hasData) {
                          return Center(
                            child: SizedBox(
                              width: 28.0,
                              height: 28.0,
                              child: CircularProgressIndicator(
                                valueColor: AlwaysStoppedAnimation<Color>(
                                  theme.primary,
                                ),
                              ),
                            ),
                          );
                        }

                        final orders = snapshot.data ?? [];
                        OrdersRecord? activeOrder;
                        for (final order in orders) {
                          if (order.status != 'Teslim') {
                            activeOrder = order;
                            break;
                          }
                        }
                        final activeStatus = activeOrder?.status ?? '';
                        final historyOrders = orders
                            .where((order) => order.status == 'Teslim')
                            .toList();

                        return SingleChildScrollView(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: const EdgeInsetsDirectional.fromSTEB(
                                    24.0, 16.0, 24.0, 0.0),
                                child: Text(
                                  FFLocalizations.of(context).getVariableText(
                                    trText: 'Sipari\u015fler',
                                    enText: 'Orders',
                                  ),
                                  style: theme.displaySmall.override(
                                    fontFamily: 'Sora',
                                    letterSpacing: -0.5,
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsetsDirectional.fromSTEB(
                                    24.0, 20.0, 24.0, 0.0),
                                child: Text(
                                  FFLocalizations.of(context).getVariableText(
                                    trText: 'Aktif sipari\u015f',
                                    enText: 'Active order',
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
                                child: activeOrder == null
                                    ? Container(
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
                                        child: Text(
                                          FFLocalizations.of(context)
                                              .getVariableText(
                                            trText:
                                                'Aktif sipari\u015fin yok. Plan\u0131ndan sipari\u015f olu\u015fturabilirsin.',
                                            enText:
                                                'No active order yet. Create one from your plan.',
                                          ),
                                          style: theme.labelLarge.override(
                                            fontFamily: 'Sora',
                                            letterSpacing: 0.0,
                                          ),
                                        ),
                                      )
                                    : Container(
                                        width: double.infinity,
                                        decoration: BoxDecoration(
                                          color: theme.secondaryBackground,
                                          borderRadius:
                                              BorderRadius.circular(20.0),
                                          border: Border.all(
                                            color: theme.accent4,
                                          ),
                                          boxShadow: [
                                            BoxShadow(
                                              blurRadius: 16.0,
                                              color: theme.primaryText
                                                  .withAlpha(15),
                                              offset: const Offset(0.0, 8.0),
                                            ),
                                          ],
                                        ),
                                        child: Padding(
                                          padding: const EdgeInsetsDirectional
                                              .fromSTEB(16.0, 16.0, 16.0, 16.0),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Row(
                                                children: [
                                                  Text(
                                                    activeOrder.reference.id,
                                                    style: theme.titleMedium
                                                        .override(
                                                      fontFamily: 'Sora',
                                                      letterSpacing: 0.0,
                                                    ),
                                                  ),
                                                  const Spacer(),
                                                  Container(
                                                    padding:
                                                        const EdgeInsetsDirectional
                                                            .fromSTEB(10.0, 6.0, 10.0, 6.0),
                                                    decoration: BoxDecoration(
                                                      color: theme.accent1,
                                                      borderRadius:
                                                          BorderRadius.circular(16.0),
                                                    ),
                                                    child: Text(
                                                      activeStatus,
                                                      style: theme.labelSmall
                                                          .override(
                                                        fontFamily: 'Sora',
                                                        color: theme.primary,
                                                        letterSpacing: 0.0,
                                                        fontWeight:
                                                            FontWeight.w600,
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              Padding(
                                                padding: const EdgeInsetsDirectional
                                                    .fromSTEB(0.0, 8.0, 0.0, 0.0),
                                                child: Text(
                                                  FFLocalizations.of(context)
                                                      .getVariableText(
                                                    trText:
                                                        'Tahmini teslimat: ${dateTimeFormat("MMM d", activeOrder.eta ?? activeOrder.createdTime, locale: FFLocalizations.of(context).languageCode)}',
                                                    enText:
                                                        'ETA: ${dateTimeFormat("MMM d", activeOrder.eta ?? activeOrder.createdTime, locale: FFLocalizations.of(context).languageCode)}',
                                                  ),
                                                  style: theme.labelLarge.override(
                                                    fontFamily: 'Sora',
                                                    letterSpacing: 0.0,
                                                  ),
                                                ),
                                              ),
                                              Padding(
                                                padding: const EdgeInsetsDirectional
                                                    .fromSTEB(0.0, 10.0, 0.0, 0.0),
                                                child: Row(
                                                  children: [
                                                    Icon(
                                                      Icons.restaurant_menu,
                                                      color: theme.secondaryText,
                                                      size: 18.0,
                                                    ),
                                                    Padding(
                                                      padding:
                                                          const EdgeInsetsDirectional
                                                              .fromSTEB(6.0, 0.0, 12.0, 0.0),
                                                      child: Text(
                                                        '${activeOrder.mealsCount} yemek',
                                                        style: theme.labelLarge
                                                            .override(
                                                          fontFamily: 'Sora',
                                                          letterSpacing: 0.0,
                                                        ),
                                                      ),
                                                    ),
                                                    Icon(
                                                      Icons.people_outline,
                                                      color: theme.secondaryText,
                                                      size: 18.0,
                                                    ),
                                                    Padding(
                                                      padding:
                                                          const EdgeInsetsDirectional
                                                              .fromSTEB(6.0, 0.0, 0.0, 0.0),
                                                      child: Text(
                                                        '${activeOrder.servings} ki\u015fi',
                                                        style: theme.labelLarge
                                                            .override(
                                                          fontFamily: 'Sora',
                                                          letterSpacing: 0.0,
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              Padding(
                                                padding: const EdgeInsetsDirectional
                                                    .fromSTEB(0.0, 12.0, 0.0, 0.0),
                                                child: Row(
                                                  children: List.generate(4, (index) {
                                                    const steps = [
                                                      'Haz\u0131rlan\u0131yor',
                                                      'Paketlendi',
                                                      'Yolda',
                                                      'Teslim',
                                                    ];
                                                    final activeStep =
                                                        _statusIndex(
                                                            activeStatus);
                                                    final isActive =
                                                        index <= activeStep;
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
                                                            size: 18.0,
                                                          ),
                                                          Padding(
                                                            padding:
                                                                const EdgeInsetsDirectional
                                                                    .fromSTEB(0.0, 6.0, 0.0, 0.0),
                                                            child: Text(
                                                              steps[index],
                                                              textAlign:
                                                                  TextAlign.center,
                                                              style: theme.labelSmall
                                                                  .override(
                                                                fontFamily: 'Sora',
                                                                color: isActive
                                                                    ? theme
                                                                        .primaryText
                                                                    : theme
                                                                        .secondaryText,
                                                                letterSpacing:
                                                                    0.0,
                                                              ),
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    );
                                                  }),
                                                ),
                                              ),
                                              Padding(
                                                padding: const EdgeInsetsDirectional
                                                    .fromSTEB(0.0, 12.0, 0.0, 0.0),
                                                child: FFButtonWidget(
                                                  onPressed: () async {
                                                    showSnackbar(
                                                      context,
                                                      FFLocalizations.of(context)
                                                          .getVariableText(
                                                        trText:
                                                            'Sipari\u015f takibi a\u00e7\u0131ld\u0131.',
                                                        enText:
                                                            'Tracking opened.',
                                                      ),
                                                    );
                                                  },
                                                  text: FFLocalizations.of(context)
                                                      .getVariableText(
                                                    trText: 'Takip et',
                                                    enText: 'Track order',
                                                  ),
                                                  options: FFButtonOptions(
                                                    height: 40.0,
                                                    padding:
                                                        const EdgeInsetsDirectional
                                                            .fromSTEB(16.0, 0.0, 16.0, 0.0),
                                                    color: theme.primary,
                                                    textStyle: theme.bodyMedium
                                                        .override(
                                                      fontFamily: 'Sora',
                                                      color:
                                                          theme.secondaryBackground,
                                                      letterSpacing: 0.0,
                                                      fontWeight:
                                                          FontWeight.w600,
                                                    ),
                                                    elevation: 0.0,
                                                    borderSide:
                                                        const BorderSide(
                                                      color: Colors.transparent,
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
                                      ),
                              ),
                              Padding(
                                padding: const EdgeInsetsDirectional.fromSTEB(
                                    24.0, 24.0, 24.0, 0.0),
                                child: Text(
                                  FFLocalizations.of(context).getVariableText(
                                    trText: 'Ge\u00e7mi\u015f sipari\u015fler',
                                    enText: 'Order history',
                                  ),
                                  style: theme.titleLarge.override(
                                    fontFamily: 'Sora',
                                    letterSpacing: 0.0,
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsetsDirectional.fromSTEB(
                                    24.0, 12.0, 24.0, 32.0),
                                child: historyOrders.isEmpty
                                    ? Container(
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
                                        child: Text(
                                          FFLocalizations.of(context)
                                              .getVariableText(
                                            trText:
                                                'Ge\u00e7mi\u015f sipari\u015f bulunamad\u0131.',
                                            enText: 'No past orders yet.',
                                          ),
                                          style: theme.labelLarge.override(
                                            fontFamily: 'Sora',
                                            letterSpacing: 0.0,
                                          ),
                                        ),
                                      )
                                    : Column(
                                        children: historyOrders.map((order) {
                                          return Padding(
                                            padding:
                                                const EdgeInsetsDirectional.fromSTEB(
                                                    0.0, 0.0, 0.0, 12.0),
                                            child: Container(
                                              decoration: BoxDecoration(
                                                color: theme.secondaryBackground,
                                                borderRadius:
                                                    BorderRadius.circular(16.0),
                                                border: Border.all(
                                                  color: theme.accent4,
                                                ),
                                              ),
                                              child: Padding(
                                                padding:
                                                    const EdgeInsetsDirectional.fromSTEB(
                                                        14.0, 12.0, 14.0, 12.0),
                                                child: Row(
                                                  children: [
                                                    Expanded(
                                                      child: Column(
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment.start,
                                                        children: [
                                                          Text(
                                                            order.reference.id,
                                                            style: theme.bodyMedium
                                                                .override(
                                                              fontFamily: 'Sora',
                                                              letterSpacing: 0.0,
                                                              fontWeight:
                                                                  FontWeight.w600,
                                                            ),
                                                          ),
                                                          Padding(
                                                            padding:
                                                                const EdgeInsetsDirectional
                                                                    .fromSTEB(0.0, 6.0, 0.0, 0.0),
                                                            child: Text(
                                                              dateTimeFormat(
                                                                "MMM d",
                                                                order.createdTime ??
                                                                    order.eta ??
                                                                    DateTime.now(),
                                                                locale: FFLocalizations
                                                                        .of(context)
                                                                    .languageCode,
                                                              ),
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
                                                    Container(
                                                      padding:
                                                          const EdgeInsetsDirectional
                                                              .fromSTEB(10.0, 6.0, 10.0, 6.0),
                                                      decoration: BoxDecoration(
                                                        color: theme.accent2,
                                                        borderRadius:
                                                            BorderRadius.circular(16.0),
                                                      ),
                                                      child: Text(
                                                        order.status,
                                                        style: theme.labelSmall
                                                            .override(
                                                          fontFamily: 'Sora',
                                                          letterSpacing: 0.0,
                                                          fontWeight:
                                                              FontWeight.w600,
                                                        ),
                                                      ),
                                                    ),
                                                    Padding(
                                                      padding:
                                                          const EdgeInsetsDirectional
                                                              .fromSTEB(12.0, 0.0, 0.0, 0.0),
                                                      child: Text(
                                                        '${order.price} TL',
                                                        style: theme.bodyMedium
                                                            .override(
                                                          fontFamily: 'Sora',
                                                          letterSpacing: 0.0,
                                                          fontWeight:
                                                              FontWeight.w600,
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          );
                                        }).toList(),
                                      ),
                              ),
                            ],
                          ),
                        );
                      },
                    ),
            ),
          ),
        ));
  }
}
