import '/bilesenlercomp/loader_item/loader_item_widget.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'package:flutter/material.dart';
import 'meal_card_loading_model.dart';
export 'meal_card_loading_model.dart';

class MealCardLoadingWidget extends StatefulWidget {
  const MealCardLoadingWidget({super.key});

  @override
  State<MealCardLoadingWidget> createState() => _MealCardLoadingWidgetState();
}

class _MealCardLoadingWidgetState extends State<MealCardLoadingWidget> {
  late MealCardLoadingModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => MealCardLoadingModel());

    WidgetsBinding.instance.addPostFrameCallback((_) => safeSetState(() {}));
  }

  @override
  void dispose() {
    _model.maybeDispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Builder(
      builder: (context) {
        final loaderItems = List.generate(4, (index) => index);

        return GridView.builder(
          padding: EdgeInsets.zero,
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 10.0,
            mainAxisSpacing: 10.0,
            childAspectRatio: 0.68,
          ),
          scrollDirection: Axis.vertical,
          itemCount: loaderItems.length,
          itemBuilder: (context, loaderItemsIndex) {
            return LoaderItemWidget(
              key: Key('Keyi8f_${loaderItemsIndex}_of_${loaderItems.length}'),
            );
          },
        );
      },
    );
  }
}
