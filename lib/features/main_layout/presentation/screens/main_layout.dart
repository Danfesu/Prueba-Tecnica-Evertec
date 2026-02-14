import 'package:evertec_technical_test/features/auth/presentation/cubits/auth_cubit.dart';
import 'package:evertec_technical_test/features/main_layout/presentation/cubits/layout_cubit.dart';
import 'package:evertec_technical_test/features/main_layout/presentation/cubits/layout_state.dart';
import 'package:evertec_technical_test/features/main_layout/presentation/widgets/drawer_item.dart';
import 'package:evertec_technical_test/features/shared/widgets/no_implemented.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class MainLayout extends StatelessWidget {
  final Widget child;
  final scaffoldKey = GlobalKey<ScaffoldState>();

  MainLayout({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buidAppBar(context),
      drawer: _buildDrawer(context),
      key: scaffoldKey,
      body: child,
    );
  }

  Widget _buildDrawer(BuildContext context) {
    return BlocBuilder<LayoutCubit, LayoutState>(
      builder: (context, state) {
        return state.when(
          initial: () => SizedBox.shrink(),
          loading: () => SizedBox.shrink(),
          loaded: (pages) {
            final location = GoRouterState.of(context).uri.toString();

            final selectedIndex = pages.indexWhere(
              (p) => location.startsWith(p.route),
            );

            return NavigationDrawer(
              selectedIndex: selectedIndex < 0 ? null : selectedIndex,
              footer: _buildFooterDrawer(context),
              children: [
                _buildHeaderDrawer(context),
                SizedBox(width: double.infinity, child: Divider()),
                SizedBox(height: 5),
                for (int i = 0; i < pages.length; i++)
                  DrawerItem(
                    icon: pages[i].icon,
                    label: pages[i].label,
                    selected: i == selectedIndex,
                    onTap: () async {
                      final router = GoRouter.of(context);
                      scaffoldKey.currentState?.closeDrawer();
                      await Future.delayed(const Duration(milliseconds: 250));
                      router.go(pages[i].route);
                    },
                  ),
              ],
            );
          },
          error: (message) => NavigationDrawer(children: [Text(message)]),
        );
      },
    );
  }

  Widget _buildHeaderDrawer(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          CircleAvatar(
            radius: 35,
            backgroundColor: Colors.white,
            child: Icon(
              Icons.person,
              size: 40,
              color: Theme.of(context).colorScheme.primary,
            ),
          ),
          SizedBox(height: 10),
          Text("Alex Sterling", style: Theme.of(context).textTheme.titleLarge),
          Text(
            "alex.s@tech-inc.io",
            style: Theme.of(context).textTheme.labelSmall,
          ),
        ],
      ),
    );
  }

  Widget _buildFooterDrawer(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: Column(
        children: [
          ElevatedButton.icon(
            onPressed: () {
              context.read<AuthCubit>().logout();
            },
            label: Text("Cerrar sesión"),
            icon: Icon(Icons.logout),
            style: ElevatedButton.styleFrom(
              padding: EdgeInsets.all(15),
              backgroundColor: Colors.redAccent.withValues(alpha: 0.15),
              foregroundColor: Colors.redAccent,
              minimumSize: Size(double.infinity, 40),
              iconSize: 20,
            ),
          ),
          SizedBox(height: 15),
          Row(
            children: [
              SizedBox(width: 10),
              Text(
                "BUILD 2.4.0",
                style: Theme.of(context).textTheme.labelSmall?.copyWith(
                  color: Theme.of(
                    context,
                  ).colorScheme.onSurface.withValues(alpha: 0.5),
                ),
              ),
              Spacer(),
              Text(
                "v1.0.24",
                style: Theme.of(context).textTheme.labelSmall?.copyWith(
                  color: Theme.of(
                    context,
                  ).colorScheme.onSurface.withValues(alpha: 0.5),
                ),
              ),
              SizedBox(width: 10),
            ],
          ),
          SizedBox(height: 40),
        ],
      ),
    );
  }

  PreferredSizeWidget _buidAppBar(BuildContext context) {
    return AppBar(
      forceMaterialTransparency: true,
      title: Text("Productos"),
      leading: IconButton(
        onPressed: () {
          scaffoldKey.currentState?.openDrawer();
        },
        icon: Icon(Icons.grid_view_rounded, color: Colors.blue),
      ),
      actions: [
        IconButton(
          onPressed: () {
            NoImplemented.showNotImplementedDialog(context);
          },
          icon: Icon(Icons.notifications),
        ),
        PopupMenuButton<String>(
          offset: Offset(0, 50),
          onSelected: (value) {
            if (value == 'logout') {
              showDialog(
                context: context,
                builder: (context) {
                  return AlertDialog(
                    title: const Text('¿Quieres cerrar sesión?'),
                    actionsOverflowDirection: VerticalDirection.down,
                    actions: [
                      SizedBox(
                        width: double.infinity,
                        child: FilledButton(
                          onPressed: () {
                            context.read<AuthCubit>().logout();
                            Navigator.pop(context);
                          },
                          child: const Text('Aceptar'),
                        ),
                      ),
                      SizedBox(
                        width: double.infinity,
                        child: OutlinedButton(
                          style: OutlinedButton.styleFrom(
                            side: BorderSide(color: Colors.blue, width: 2.0),
                            foregroundColor: Colors.blue,
                          ),
                          onPressed: () => Navigator.pop(context),
                          child: const Text('Cancelar'),
                        ),
                      ),
                    ],
                  );
                },
              );
            }
          },
          itemBuilder: (context) => [
            PopupMenuItem(value: 'logout', child: Text('Cerrar sesión')),
          ],
          icon: const Icon(Icons.account_circle),
        ),
      ],
    );
  }
}
