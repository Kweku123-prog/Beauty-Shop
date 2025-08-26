import 'package:beauty/data/bloc/discover_bloc/discover_event_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FiltersBar extends StatefulWidget {
  const FiltersBar({super.key});

  @override
  State<FiltersBar> createState() => _FiltersBarState();
}

class _FiltersBarState extends State<FiltersBar> {
  final List<String> categories = ['All', 'Hair', 'Barber'];
  final List<String> travelModes = ['Any', 'Home Service', 'In-Shop'];

  String selectedCategory = 'All';
  double selectedPrice = 40;
  String selectedMode = 'Any';

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context); // 👈 grab current theme

    return Container(
      color: theme.cardColor, // 👈 adapts to light/dark
      padding: const EdgeInsets.all(8),
      child: Row(
        children: [
          // Category dropdown
          DropdownButton<String>(
            dropdownColor: theme.cardColor, // 👈 dropdown matches theme
            value: selectedCategory,
            style: theme.textTheme.bodyMedium, // 👈 text adapts to theme
            items: categories
                .map((c) => DropdownMenuItem(
                      value: c,
                      child: Text(c),
                    ))
                .toList(),
            onChanged: (val) {
              if (val != null) {
                setState(() => selectedCategory = val);
                context.read<DiscoverEventBloc>().add(
                      ApplyFilters(
                        category: selectedCategory,
                        maxPrice: selectedPrice,
                        travelMode: selectedMode,
                      ),
                    );
              }
            },
          ),
          const SizedBox(width: 10),

          // Price slider
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Max \$${selectedPrice.toInt()}",
                  style: theme.textTheme.bodyMedium,
                ),
                Slider(
                  value: selectedPrice,
                  min: 0,
                  max: 100,
                  divisions: 50,
                  activeColor: theme.colorScheme.primary, // 👈 theme color
                  label: selectedPrice.toInt().toString(),
                  onChanged: (val) {
                    setState(() => selectedPrice = val);
                    context.read<DiscoverEventBloc>().add(
                          ApplyFilters(
                            category: selectedCategory,
                            maxPrice: selectedPrice,
                            travelMode: selectedMode,
                          ),
                        );
                  },
                ),
              ],
            ),
          ),

          // Travel mode dropdown
          DropdownButton<String>(
            dropdownColor: theme.cardColor,
            value: selectedMode,
            style: theme.textTheme.bodyMedium,
            items: travelModes
                .map((m) => DropdownMenuItem(value: m, child: Text(m)))
                .toList(),
            onChanged: (val) {
              if (val != null) {
                setState(() => selectedMode = val);
                context.read<DiscoverEventBloc>().add(
                      ApplyFilters(
                        category: selectedCategory,
                        maxPrice: selectedPrice,
                        travelMode: selectedMode,
                      ),
                    );
              }
            },
          ),
        ],
      ),
    );
  }
}
