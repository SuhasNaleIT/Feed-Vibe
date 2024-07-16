// Flutter imports:
import 'package:flutter/widgets.dart';

// Package imports:
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';

/// {@macro provider.consumer}
class Consumer7<A, B, C, D, E, F, G> extends SingleChildStatelessWidget {
  /// {@macro provider.consumer.constructor}
  const Consumer7({
    required this.builder,
    super.key,
    super.child,
  });

  /// {@macro provider.consumer.builder}
  final Widget Function(
    BuildContext context,
    A value,
    B value2,
    C value3,
    D value4,
    E value5,
    F value6,
    G value7,
    Widget? child,
  ) builder;

  @override
  Widget buildWithChild(BuildContext context, Widget? child) {
    return builder(
      context,
      Provider.of<A>(context),
      Provider.of<B>(context),
      Provider.of<C>(context),
      Provider.of<D>(context),
      Provider.of<E>(context),
      Provider.of<F>(context),
      Provider.of<G>(context),
      child,
    );
  }
}
