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
    this.scrollDirection = Axis.vertical, // 👈 NEW
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
    _fetchNextPage();
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

  Future<void> _fetchNextPage() async {
    setState(() => _isLoading = true);
    try {
      final newItems = await widget.fetchPage(_currentPage);
      setState(() {
        _items.addAll(newItems);
        _hasMore = newItems.length >= widget.pageSize;
        _currentPage++;
      });
    } catch (e) {
      setState(() {
        _hasMore = false;
        log('Error fetching data: $e');
      });
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
        itemCount: _items.length +
            (_hasMore
                ? (widget.crossAxisCount -
                            (_items.length % widget.crossAxisCount)) %
                        widget.crossAxisCount +
                    1
                : 0),
        itemBuilder: (context, index) {
          if (index < _items.length) {
            return widget.itemBuilder(context, _items[index]);
          }

          // Calculate position to center loading spinner in the last row
          final remainder = _items.length % widget.crossAxisCount;
          final emptySlots =
              remainder == 0 ? 0 : widget.crossAxisCount - remainder;

          // Return empty slots first
          if (index < _items.length + emptySlots) {
            return const Center(child: CircularProgressIndicator());
          }

          // Center spinner cell
          return const Center(child: CircularProgressIndicator());
        });
  }
}
