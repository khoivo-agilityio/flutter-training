import 'dart:developer';
import 'package:flutter/material.dart';

class PfLazyLoadGridView<T> extends StatefulWidget {
  final Future<List<T>> Function(int page) fetchPage;
  final Widget Function(BuildContext context, T item) itemBuilder;
  final int crossAxisCount;
  final double childAspectRatio;
  final double padding;
  final double spacing;
  final int pageSize;
  final Axis scrollDirection;

  const PfLazyLoadGridView({
    super.key,
    required this.fetchPage,
    required this.itemBuilder,
    this.crossAxisCount = 2,
    this.childAspectRatio = 1.0,
    this.padding = 8.0,
    this.spacing = 8.0,
    this.pageSize = 20,
    this.scrollDirection = Axis.vertical,
  });

  @override
  State<PfLazyLoadGridView<T>> createState() => _PfLazyLoadGridViewState<T>();
}

class _PfLazyLoadGridViewState<T> extends State<PfLazyLoadGridView<T>> {
  final ScrollController _scrollController = ScrollController();
  final List<T> _items = [];
  int _currentPage = 1;
  bool _isLoading = false;
  bool _hasMore = true;

  @override
  void initState() {
    super.initState();
    _fetchNextPage(); // Initial load
    _scrollController.addListener(_scrollListener);
  }

  void _scrollListener() {
    if (_scrollController.position.pixels >=
        _scrollController.position.maxScrollExtent - 200) {
      if (!_isLoading && _hasMore) {
        _fetchNextPage();
      }
    }
  }

  Future<List<T>> _fetchNextPage() async {
    setState(() => _isLoading = true);
    try {
      final newItems = await widget.fetchPage(_currentPage);
      setState(() {
        _items.addAll(newItems);
        _hasMore = newItems.length >= widget.pageSize;
        _currentPage++;
      });
      return newItems;
    } catch (e) {
      log('Error fetching data: $e');
      return [];
    } finally {
      setState(() => _isLoading = false);
    }
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final itemCount = _items.length +
        (_hasMore
            ? (widget.crossAxisCount -
                        (_items.length % widget.crossAxisCount)) %
                    widget.crossAxisCount +
                1
            : 0);

    return GridView.builder(
      controller: _scrollController,
      scrollDirection: widget.scrollDirection,
      padding: EdgeInsets.all(widget.padding),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: widget.crossAxisCount,
        crossAxisSpacing: widget.spacing,
        mainAxisSpacing: widget.spacing,
        childAspectRatio: widget.childAspectRatio,
      ),
      itemCount: itemCount,
      itemBuilder: (context, index) {
        if (index < _items.length) {
          return widget.itemBuilder(context, _items[index]);
        }

        final remainder = _items.length % widget.crossAxisCount;
        final emptySlots =
            remainder == 0 ? 0 : widget.crossAxisCount - remainder;

        if (index < _items.length + emptySlots) {
          return const SizedBox.shrink();
        }

        return const Center(child: CircularProgressIndicator());
      },
    );
  }
}
