import '/bilesenlercomp/accordion_section/accordion_section_widget.dart';
import '/components/custom_appbar_widget.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'destek_merkezi_widget.dart' show DestekMerkeziWidget;
import 'package:flutter/material.dart';

class DestekMerkeziModel extends FlutterFlowModel<DestekMerkeziWidget> {
  ///  State fields for stateful widgets in this page.

  // Model for customAppbar component.
  late CustomAppbarModel customAppbarModel;
  // Model for accordionSection component.
  late AccordionSectionModel accordionSectionModel;

  @override
  void initState(BuildContext context) {
    customAppbarModel = createModel(context, () => CustomAppbarModel());
    accordionSectionModel = createModel(context, () => AccordionSectionModel());
  }

  @override
  void dispose() {
    customAppbarModel.dispose();
    accordionSectionModel.dispose();
  }
}
