import 'dart:async';

import 'package:cinelens/presentation/search/bloc/search_cubit.dart';
import 'package:cinelens/presentation/search/bloc/switching_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TextfieldSearch extends StatefulWidget {
  const TextfieldSearch({super.key});

  @override
  State<TextfieldSearch> createState() => _TextfieldSearchState();
}

class _TextfieldSearchState extends State<TextfieldSearch> {
  final TextEditingController _controller = TextEditingController();
  Timer? _debounce;

  void _onSearchChanged(String query) {
    if (_debounce?.isActive ?? false) _debounce!.cancel();

    // Debounce for 300ms to avoid firing requests on every keystroke
    _debounce = Timer(const Duration(milliseconds: 300), () {
      _executeSearch(query);
    });
  }

  void _executeSearch(String query) {
    if (query.trim().isEmpty) return;

    final currentCategory = context.read<SwitchingCubit>().state;

    if (currentCategory == States.movie) {
      context.read<SearchCubit>().getDataByquery(query, false);
    } else {
      context.read<SearchCubit>().getDataByquery(query, true);
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    _debounce?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<SwitchingCubit, States>(
      // Re-trigger search when switching tabs if the textfield is not empty
      listener: (context, state) {
        if (_controller.text.trim().isNotEmpty) {
          _executeSearch(_controller.text);
        }
      },
      child: TextField(
        controller: _controller,
        onChanged: _onSearchChanged,
        style: const TextStyle(color: Colors.white),
        decoration: InputDecoration(
          hintText: 'Search movies or TV shows...',
          hintStyle: const TextStyle(color: Colors.grey),
          prefixIcon: const Icon(Icons.search, color: Colors.white),
          suffixIcon: _controller.text.isNotEmpty
              ? IconButton(
                  icon: const Icon(Icons.clear, color: Colors.white),
                  onPressed: () {
                    _controller.clear();
                    setState(() {});
                  },
                )
              : null,
          // filled: true,
          // fillColor: Colors.grey[900],
          // border: OutlineInputBorder(
          //   borderRadius: BorderRadius.circular(12),
          //   borderSide: BorderSide.none,
          // ),
        ),
      ),
    );
  }
}
