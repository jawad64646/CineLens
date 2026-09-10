import 'package:cinelens/common/widgets/basic_app_bar.dart';
import 'package:cinelens/core/navigation/navigation.dart';
import 'package:cinelens/presentation/search/bloc/search_cubit.dart';
import 'package:cinelens/presentation/search/bloc/switching_state.dart';
import 'package:cinelens/presentation/search/widgets/movies_grid.dart';
import 'package:cinelens/presentation/search/widgets/tvshows_grid.dart';
import 'package:cinelens/presentation/search/widgets/textField_search.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeSearch extends StatelessWidget {
  const HomeSearch({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<SearchCubit>(create: (context) => SearchCubit()),
        BlocProvider<SwitchingCubit>(create: (context) => SwitchingCubit()),
      ],
      child: Scaffold(
        appBar: BasicAppBar(
          title: const Text(
            "Search",
            style: TextStyle(
              color: Colors.white,
              fontSize: 20,
              fontWeight: FontWeight.w500,
            ),
          ),
          back: IconButton(
            icon: const Icon(Icons.arrow_back_rounded, size: 30),
            onPressed: () {
              Navigation.pop(context);
            },
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: .center,
            children: [
              const TextfieldSearch(),
              const SizedBox(height: 12),

              // Category Switching Buttons
              BlocBuilder<SwitchingCubit, States>(
                builder: (context, state) {
                  final isMovieSelected = state == States.movie;
                  final isTvSelected = state == States.tv;

                  return Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      FilledButton(
                        onPressed: () {
                          context.read<SwitchingCubit>().updateState(
                            isTV: false,
                          );
                        },
                        style: FilledButton.styleFrom(
                          backgroundColor: isMovieSelected
                              ? Colors.red
                              : Colors.grey[800],
                        ),
                        child: const Text(
                          "Movies",
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                      const SizedBox(width: 12),
                      FilledButton(
                        onPressed: () {
                          context.read<SwitchingCubit>().updateState(
                            isTV: true,
                          );
                        },
                        style: FilledButton.styleFrom(
                          backgroundColor: isTvSelected
                              ? Colors.red
                              : Colors.grey[800],
                        ),
                        child: const Text(
                          "TV Shows",
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ],
                  );
                },
              ),
              const SizedBox(height: 16),

              // Dynamic Grid Display
              Expanded(
                child: BlocBuilder<SwitchingCubit, States>(
                  builder: (context, state) {
                    return state == States.movie
                        ? const MoviesGrid()
                        : const TVShowsGrid();
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
