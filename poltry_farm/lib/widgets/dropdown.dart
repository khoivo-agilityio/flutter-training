import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:poltry_farm/extensions/context_extension.dart';
import 'package:poltry_farm/resources/l10n_generated/l10n.dart';
import 'package:poltry_farm/widgets/text.dart';
import 'package:poltry_farm/widgets/text_field.dart';
import 'package:shimmer_animation/shimmer_animation.dart';

// Dropdown Item
class PfDropdownSearchItem<T> {
  PfDropdownSearchItem({required this.value, required this.label});
  final T value;
  final String label;
}

// Dropdown State
class DropDownSearchState<T> {
  DropDownSearchState({
    required this.isTapped,
    required this.filteredList,
    required this.subFilteredList,
    this.selectedItem,
    this.isLoading = false,
    this.error,
  });

  final bool isTapped;
  final List<PfDropdownSearchItem<T>> filteredList;
  final List<PfDropdownSearchItem<T>> subFilteredList;
  final PfDropdownSearchItem<T>? selectedItem;
  final bool isLoading;
  final String? error;

  DropDownSearchState<T> copyWith({
    bool? isTapped,
    List<PfDropdownSearchItem<T>>? filteredList,
    List<PfDropdownSearchItem<T>>? subFilteredList,
    PfDropdownSearchItem<T>? selectedItem,
    bool? isLoading,
    String? error,
  }) {
    return DropDownSearchState<T>(
      isTapped: isTapped ?? this.isTapped,
      filteredList: filteredList ?? this.filteredList,
      subFilteredList: subFilteredList ?? this.subFilteredList,
      selectedItem: selectedItem ?? this.selectedItem,
      isLoading: isLoading ?? this.isLoading,
      error: error,
    );
  }
}

// Dropdown Cubit
class DropDownSearchCubit<T> extends Cubit<DropDownSearchState<T>> {
  DropDownSearchCubit()
      : super(DropDownSearchState(
            isTapped: false, filteredList: [], subFilteredList: []));

  void toggleDropdown({bool? isTapped}) =>
      emit(state.copyWith(isTapped: isTapped ?? false));

  void filterList(String query) {
    final filtered = state.subFilteredList
        .where((item) => item.label.toLowerCase().contains(query.toLowerCase()))
        .toList();
    emit(state.copyWith(filteredList: filtered));
  }

  void setItems(List<PfDropdownSearchItem<T>> items) {
    emit(state.copyWith(
        filteredList: items, subFilteredList: [...items], error: null));
  }

  Future<void> fetchItems(
      Future<List<PfDropdownSearchItem<T>>> Function() fetcher) async {
    emit(
      state.copyWith(
        isLoading: true,
        error: null,
      ),
    );

    try {
      final items = await fetcher();
      emit(
        state.copyWith(
          filteredList: items,
          subFilteredList: [...items],
          isLoading: false,
        ),
      );
    } catch (_) {
      emit(
        state.copyWith(
          isLoading: false,
          error: 'Failed to load items. Tap to retry.',
        ),
      );
    }
  }

  void selectItem(PfDropdownSearchItem<T> item, {bool enableFilter = false}) {
    final filtered = enableFilter
        ? state.subFilteredList
            .where(
                (i) => i.label.toLowerCase().contains(item.label.toLowerCase()))
            .toList()
        : state.subFilteredList;
    emit(state.copyWith(
        selectedItem: item, isTapped: false, filteredList: filtered));
  }

  void initValue(PfDropdownSearchItem<T> initialItem,
      {bool enableFilter = false}) {
    emit(state.copyWith(
      selectedItem: initialItem,
    ));
  }
}

// Dropdown Widget
class PfDropdownSearch<T> extends StatefulWidget {
  const PfDropdownSearch({
    required this.name,
    this.label,
    this.placeholder,
    this.controller,
    this.focusNode,
    this.trailingIcon,
    this.onChanged,
    this.onSelected,
    this.onFetchItems,
    this.keyboardType,
    this.inputFormatters,
    this.enable = true,
    this.required = false,
    this.enableFilter = false,
    this.hintText,
    this.initialValue,
    super.key,
  });

  final String name;
  final String? label;
  final String? placeholder;
  final TextEditingController? controller;
  final FocusNode? focusNode;
  final Widget? trailingIcon;
  final ValueChanged<T?>? onChanged;
  final ValueChanged<T?>? onSelected;
  final Future<List<PfDropdownSearchItem<T>>> Function()? onFetchItems;
  final TextInputType? keyboardType;
  final List<TextInputFormatter>? inputFormatters;
  final bool? enable;
  final bool? required;
  final bool enableFilter;
  final String? hintText;
  final PfDropdownSearchItem<T>? initialValue;

  @override
  State<PfDropdownSearch<T>> createState() => _PfDropdownSearchState<T>();
}

class _PfDropdownSearchState<T> extends State<PfDropdownSearch<T>> {
  late final DropDownSearchCubit<T> cubit;
  late final TextEditingController _controller;
  late final FocusNode _focusNode;
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    cubit = DropDownSearchCubit<T>();
    _controller = widget.controller ?? TextEditingController();
    _focusNode = widget.focusNode ?? FocusNode();

    // Set initial selected item if provided
    if (widget.initialValue != null) {
      cubit.initValue(widget.initialValue!);
      _controller.text = widget.initialValue!.label;
    }
  }

  @override
  void dispose() {
    if (widget.controller == null) _controller.dispose();
    if (widget.focusNode == null) _focusNode.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  void _handleDropdownToggle() async {
    if (!(widget.enable ?? true)) return;

    final isOpened = cubit.state.isTapped;
    if (!isOpened) {
      _focusNode.requestFocus();
      if (widget.onFetchItems != null && cubit.state.subFilteredList.isEmpty) {
        await cubit.fetchItems(widget.onFetchItems!);
      }
      cubit.toggleDropdown(isTapped: true);
    } else {
      _focusNode.unfocus();
      cubit.toggleDropdown(isTapped: false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => cubit,
      child: Focus(
        onFocusChange: (hasFocus) {
          if (!hasFocus && cubit.state.isTapped) {
            cubit.toggleDropdown(isTapped: false);
          }
        },
        child: GestureDetector(
          behavior: HitTestBehavior.translucent,
          onTap: () {
            FocusScope.of(context).unfocus();
          },
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (widget.label != null) ...[
                Row(
                  children: [
                    PfText(
                      text: widget.label!,
                      variant: PfTextStyleVariant.labelLarge,
                    ),
                    if (widget.required ?? false)
                      PfText(
                        text: ' *',
                        variant: PfTextStyleVariant.labelLarge,
                        color: context.colorScheme.error,
                      ),
                  ],
                ),
              ],
              const SizedBox(height: 8),
              Semantics(
                label: widget.name,
                hint: S.current.formDropdownSemanticHint,
                toggled: cubit.state.isTapped,
                button: true,
                focusable: true,
                focused: _focusNode.hasFocus,
                child: PfTextField(
                  semanticsLabel: widget.name,
                  controller: _controller,
                  focusNode: (widget.enable ?? false) ? _focusNode : null,
                  readOnly: !(widget.enable ?? false),
                  keyboardType: widget.keyboardType,
                  onChanged: (val) {
                    cubit.filterList(val);
                    widget.onChanged?.call(val as T?);
                  },
                  hasValidation: false,
                  hintText: widget.hintText,
                  onTap: _handleDropdownToggle,
                  suffixIcon: GestureDetector(
                    onTap: _handleDropdownToggle,
                    child: BlocBuilder<DropDownSearchCubit<T>,
                        DropDownSearchState<T>>(
                      builder: (_, state) => Padding(
                        padding: const EdgeInsets.only(right: 8.0),
                        child: Icon(
                          state.isTapped
                              ? Icons.arrow_drop_up
                              : Icons.arrow_drop_down,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              BlocBuilder<DropDownSearchCubit<T>, DropDownSearchState<T>>(
                builder: (_, state) {
                  if (!(widget.enable ?? false) || !state.isTapped) {
                    return const SizedBox.shrink();
                  }

                  if (state.isLoading) {
                    return ConstrainedBox(
                      constraints: const BoxConstraints(maxHeight: 200),
                      child: ListView.builder(
                        itemCount: 5,
                        itemBuilder: (_, index) => Shimmer(
                          child: Container(
                            margin: const EdgeInsets.symmetric(
                                vertical: 8, horizontal: 16),
                            height: 20,
                            decoration: BoxDecoration(
                              color: Colors.grey[300],
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                        ),
                      ),
                    );
                  }

                  if (state.error != null) {
                    return Semantics(
                      label: S.current.formDropdownSemanticErrorFetchItems,
                      child: GestureDetector(
                        onTap: () {
                          if (widget.onFetchItems != null) {
                            cubit.fetchItems(widget.onFetchItems!);
                          }
                        },
                        child: Padding(
                          padding: const EdgeInsets.all(16),
                          child: Column(
                            children: [
                              PfText(
                                text: state.error!,
                                variant: PfTextStyleVariant.bodyMedium,
                                color: context.colorScheme.error,
                              ),
                              const SizedBox(height: 8),
                              PfText(
                                text: S.current.formDropdownMenuAction,
                                variant: PfTextStyleVariant.bodyMedium,
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  }

                  if (state.filteredList.isEmpty &&
                      _controller.text.isNotEmpty) {
                    return Padding(
                      padding: const EdgeInsets.all(16),
                      child: PfText(
                        text: S.current.formDropdownEmptyDescription,
                        variant: PfTextStyleVariant.bodyMedium,
                      ),
                    );
                  }

                  return ConstrainedBox(
                    constraints: const BoxConstraints(
                      maxHeight: 200,
                    ),
                    child: ListView.builder(
                      itemCount: state.filteredList.length,
                      shrinkWrap: true,
                      itemBuilder: (_, index) {
                        final item = state.filteredList[index];
                        return GestureDetector(
                          onTap: () {
                            cubit.selectItem(item,
                                enableFilter: widget.enableFilter);
                            _controller.text = item.label;
                            widget.onSelected?.call(item.value);
                            _focusNode.unfocus();
                          },
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 16,
                              vertical: 16,
                            ),
                            child: PfText(
                              text: item.label,
                              variant: PfTextStyleVariant.bodyMedium,
                            ),
                          ),
                        );
                      },
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
