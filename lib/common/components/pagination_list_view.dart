import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:order/common/model/cursor_pagination_model.dart';
import 'package:order/common/model/model_with_id.dart';
import 'package:order/common/utils/pagination_utils.dart';
import 'package:order/provider/pagination_provider.dart';

typedef PaginationWidgetBuilder<T extends IModelWithId> = Widget Function(
    BuildContext context, int index, T model);

class PaginationListView<T extends IModelWithId>
    extends ConsumerStatefulWidget {
  final StateNotifierProvider<PaginationProvider, CursorPaginationBase>
      provider;
  final PaginationWidgetBuilder<T> itemBuilder;

  const PaginationListView({
    super.key,
    required this.provider,
    required this.itemBuilder,
  });

  @override
  ConsumerState<PaginationListView<T>> createState() =>
      _PaginationListViewState<T>();
}

class _PaginationListViewState<T extends IModelWithId>
    extends ConsumerState<PaginationListView<T>> {
  final ScrollController controller = ScrollController();

  @override
  void initState() {
    super.initState();
    controller.addListener(scrollListener);
  }

  void scrollListener() {
    PaginationUtils.paginate(
      controller: controller,
      provider: ref.read(widget.provider.notifier),
    );
  }

  @override
  void dispose() {
    controller.removeListener(scrollListener);
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(widget.provider);

    // 완전 처음 로딩일 때
    if (state is CursorPaginationLoading) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    }

    // 에러일 때
    if (state is CursorPaginationError) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            state.message,
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 16),
          ElevatedButton(
            onPressed: () {
              ref.read(widget.provider.notifier).paginate(
                    forceRefetch: true,
                  );
            },
            child: const Text("다시 시도"),
          )
        ],
      );
    }

    // 남은 세가지 경우는 모두 CursorPagination의 child 클래스
    final cp = state as CursorPagination<T>;

    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: RefreshIndicator(
          onRefresh: () async {
            ref.read(widget.provider.notifier).paginate(
                  forceRefetch: true,
                );
          },
          child: ListView.separated(
            physics: const AlwaysScrollableScrollPhysics(),
            controller: controller,
            itemCount: cp.data.length + 1,
            itemBuilder: (context, index) {
              if (index == cp.data.length) {
                return Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 8,
                  ),
                  child: Center(
                    child: cp is CursorPaginationFetchingMore
                        ? const CircularProgressIndicator()
                        : const Text("마지막 데이터입니다."),
                  ),
                );
              }

              final item = cp.data[index];

              return widget.itemBuilder(context, index, item);
            },
            separatorBuilder: (context, index) {
              return const SizedBox(height: 16);
            },
          ),
        ),
      ),
    );
  }
}
