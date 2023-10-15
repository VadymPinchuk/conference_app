import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:swag_store_app/routes.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var query = MediaQuery.of(context);
    var size = query.size;
    var padding = query.padding;
    return Material(
      child: GridView.count(
        crossAxisCount: 3,
        childAspectRatio:
            size.width / (size.height - padding.top - padding.bottom),
        children: _buildGridWidgets(context),
      ),
    );
  }

  List<Widget> _buildGridWidgets(BuildContext context) {
    final list = List<Widget>.empty(growable: true);
    final theme = Theme.of(context);
    final scheme = theme.colorScheme;
    final textStyle = theme.textTheme.titleMedium!;
    list
      ..add(
        _itemWidget(
          theme,
          FontAwesomeIcons.store,
          'Products',
          () => context.push('/${Routes.products.name}'),
        ),
      )
      ..add(
        _itemWidget(
          theme,
          FontAwesomeIcons.cartShopping,
          'Cart',
          () => context.push('/${Routes.cart.name}'),
        ),
      )
      ..add(_emptyPoint(context, theme))
      ..add(_emptyPoint(context, theme))
      ..add(_emptyPoint(context, theme))
      ..add(_emptyPoint(context, theme))
      ..add(_emptyPoint(context, theme))
      ..add(_emptyPoint(context, theme))
      ..add(_emptyPoint(context, theme));
    return list;
  }

  Widget _emptyPoint(BuildContext context, ThemeData theme) {
    return _itemWidget(
      theme,
      Icons.dangerous,
      'Empty',
      null,
    );
  }

  Widget _itemWidget(
    ThemeData theme,
    IconData icon,
    String title,
    Function()? onTap,
  ) =>
      Card(
        clipBehavior: Clip.antiAlias,
        color: onTap == null ? theme.colorScheme.secondaryContainer : theme.colorScheme.primaryContainer,
        child: InkWell(
          onTap: onTap,
          highlightColor: theme.colorScheme.primary.withAlpha(50),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              FaIcon(
                icon,
                size: 50,
                color: onTap == null ? theme.colorScheme.secondary : theme.colorScheme.primary,
              ),
              const SizedBox(height: 8),
              Text(
                title,
                style: theme.textTheme.titleMedium!.apply(
                  color: onTap == null ? theme.colorScheme.secondary : theme.colorScheme.secondary,
                ),
              ),
            ],
          ),
        ),
      );
}
