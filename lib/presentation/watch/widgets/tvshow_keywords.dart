import 'package:cinelens/common/bloc/generic_state.dart';

import 'package:cinelens/domain/entities/keyword_tvshow.dart';
import 'package:cinelens/presentation/watch/bloc/keywords_tvshow.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class KeywordsTvShow extends StatelessWidget {
  final String? tvshowId;
  const KeywordsTvShow({super.key, this.tvshowId});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => KeywordsTvshowCubit()..getKeywordsTvShow(tvshowId),
      child:
          BlocBuilder<
            KeywordsTvshowCubit,
            BaseState<List<KeywordTvshowEntity>>
          >(
            builder: (context, state) {
              if (state is LoadingState<List<KeywordTvshowEntity>>) {
                return const Center(child: CircularProgressIndicator());
              }

              if (state is LoadedState<List<KeywordTvshowEntity>>) {
                final data = state.data;

                return Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  children: data.take(4).map((keyword) {
                    return Chip(
                      label: Text(
                        keyword.name ?? "",
                        style: const TextStyle(
                          color: Colors.redAccent,
                          fontSize: 13,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      backgroundColor: Colors.redAccent.withOpacity(0.08),
                      side: BorderSide(
                        color: Colors.redAccent.withOpacity(0.7),
                        width: 1,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      padding: const EdgeInsets.symmetric(
                        horizontal: 4,
                        vertical: 2,
                      ),
                      materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                    );
                  }).toList(),
                );
              }

              if (state is FailureState<List<KeywordTvshowEntity>>) {
                return Center(
                  child: Text(
                    ' Error in fetching data: ${state.error}',
                    style: const TextStyle(color: Colors.white),
                  ),
                );
              }

              return const SizedBox();
            },
          ),
    );
  }
}
