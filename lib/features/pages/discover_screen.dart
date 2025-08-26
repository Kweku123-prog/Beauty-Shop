import 'package:beauty/features/component/fllter_component.dart';
import 'package:beauty/data/bloc/discover_bloc/discover_event_bloc.dart';

import 'package:beauty/features/pages/professional_details_screen.dart';
import 'package:beauty/theme/theme_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shimmer_animation/shimmer_animation.dart';


class DiscoverScreen extends StatelessWidget {
  const DiscoverScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
 appBar: AppBar(
  title: const Text("Discover"),
  actions: [
    IconButton(
      icon: const Icon(Icons.brightness_6),
      onPressed: () {
        context.read<ThemeCubit>().toggleTheme();
      },
    ),
  ],
),

      body: Column(
        children: [
          FiltersBar(), // 👈 add the filters bar
          Expanded(
            child: RefreshIndicator(
              onRefresh: () async {
                context.read<DiscoverEventBloc>().add(LoadProfessionals());
              },
              child: BlocBuilder<DiscoverEventBloc, DiscoverState>(
                builder: (context, state) {


if (state is DiscoverLoading) {
  return ListView.builder(
    itemCount: 6, // show 6 shimmer placeholders
    itemBuilder: (context, index) {
      return Shimmer(
        duration: const Duration(seconds: 2), // animation speed
        interval: const Duration(milliseconds: 300),
        color: Colors.grey.shade300,
        colorOpacity: 0.4,
        enabled: true,
        child: Card(
          margin: const EdgeInsets.all(8),
          child: ListTile(
            leading: Container(
              width: 48,
              height: 48,
              color: Colors.white,
            ),
            title: Container(
              height: 16,
              color: Colors.white,
              margin: const EdgeInsets.only(bottom: 8),
            ),
            subtitle: Container(
              height: 14,
              color: Colors.white,
            ),
          ),
        ),
      );
    },
  );
}
 else if (state is DiscoverError) {
                    return Center(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(state.message),
                          const SizedBox(height: 8),
                          ElevatedButton(
                            onPressed: () {
                              context
                                  .read<DiscoverEventBloc>()
                                  .add(LoadProfessionals());
                            },
                            child: const Text("Retry"),
                          )
                        ],
                      ),
                    );
                  } else if (state is DiscoverEmpty) {
                    return const Center(child: Text("🙁 No professionals found"));
                  } else if (state is DiscoverLoaded) {
                    return ListView.builder(
                      itemCount: state.professionals.length,
                      itemBuilder: (context, index) {
                        final pro = state.professionals[index];
                        return Card(
                          margin: const EdgeInsets.all(8),
                          child: ListTile(
                            title: Text(pro.name),
                            subtitle: Text(
                                "${pro.category} • from \$${pro.minPrice} • ${pro.travelMode}"),
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (_) =>
                                      ProfessionalDetailsScreen(pro: pro),
                                ),
                              );
                            },
                          ),
                        );
                    
                    
                      },
                    );
                  }
                  return const SizedBox();
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
