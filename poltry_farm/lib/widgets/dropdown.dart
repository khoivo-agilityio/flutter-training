// LazyDropdownField with search and error + retry
import 'package:flutter/material.dart';

class LazyDropdownField<T> extends StatefulWidget {
  final Future<List<T>> Function(int page, String query) onLoadItems;
  final String Function(T item) itemBuilder;
  final ValueChanged<T?> onChanged;
  final T? initialValue;
  final String? hintText;
  final int pageSize;

  const LazyDropdownField({
    super.key,
    required this.onLoadItems,
    required this.itemBuilder,
    required this.onChanged,
    this.initialValue,
    this.hintText,
    this.pageSize = 20,
  });

  @override
  State<LazyDropdownField<T>> createState() => _LazyDropdownFieldState<T>();
}

class _LazyDropdownFieldState<T> extends State<LazyDropdownField<T>> {
  final LayerLink _layerLink = LayerLink();
  final ScrollController _scrollController = ScrollController();
  final TextEditingController _searchController = TextEditingController();

  List<T> _items = [];
  bool _isLoading = false;
  bool _hasMore = true;
  int _page = 1;
  bool _dropdownOpen = false;
  T? _selectedItem;
  String _searchQuery = '';
  String? _error;
  OverlayEntry? _overlayEntry;

  final _dropdownHeight = 300.0;

  @override
  void initState() {
    super.initState();
    _selectedItem = widget.initialValue;

    _scrollController.addListener(() {
      if (_scrollController.position.atEdge &&
          _scrollController.position.pixels != 0 &&
          !_isLoading &&
          _hasMore &&
          _error == null) {
        _loadMore();
      }
    });
  }

  Future<void> _openDropdown() async {
    if (_items.isEmpty && !_isLoading) {
      _page = 1;
      _items = [];
      _hasMore = true;
      _error = null;
      await _loadMore();
    }
    setState(() => _dropdownOpen = true);
    _showOverlay();
  }

  Future<void> _loadMore() async {
    setState(() {
      _isLoading = true;
      _error = null;
    });
    try {
      final result = await widget.onLoadItems(_page, _searchQuery);
      setState(() {
        _items.addAll(result);
        _hasMore = result.length >= widget.pageSize;
        _isLoading = false;
        _page += 1;
      });
    } catch (e) {
      setState(() {
        _isLoading = false;
        _error = 'Failed to load data. Tap to retry.';
      });
    }
  }

  void _showOverlay() {
    _overlayEntry = OverlayEntry(
      builder: (context) => Positioned(
        width: context.size!.width,
        child: CompositedTransformFollower(
          link: _layerLink,
          offset: const Offset(0, 50),
          showWhenUnlinked: false,
          child: Material(
            elevation: 4,
            borderRadius: BorderRadius.circular(8),
            child: Container(
              height: _dropdownHeight,
              decoration: BoxDecoration(
                color: Colors.white,
                border: Border.all(color: Colors.grey.shade300),
              ),
              child: Column(
                children: [
                  Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
                    child: TextField(
                      controller: _searchController,
                      decoration: const InputDecoration(
                        prefixIcon: Icon(Icons.search),
                        hintText: 'Search...',
                        isDense: true,
                      ),
                      onChanged: (value) async {
                        _searchQuery = value;
                        _page = 1;
                        _items.clear();
                        _hasMore = true;
                        await _loadMore();
                      },
                    ),
                  ),
                  if (_error != null)
                    GestureDetector(
                      onTap: _loadMore,
                      child: Padding(
                        padding: const EdgeInsets.all(16),
                        child: Text(_error!,
                            style: const TextStyle(color: Colors.red)),
                      ),
                    )
                  else if (_items.isEmpty && !_isLoading)
                    const Padding(
                      padding: EdgeInsets.all(16),
                      child: Text('No data'),
                    )
                  else
                    Expanded(
                      child: ListView.builder(
                        controller: _scrollController,
                        itemCount: _items.length + (_isLoading ? 1 : 0),
                        itemBuilder: (context, index) {
                          if (index >= _items.length) {
                            return const Padding(
                              padding: EdgeInsets.all(12),
                              child: Center(child: CircularProgressIndicator()),
                            );
                          }
                          final item = _items[index];
                          return ListTile(
                            title: Text(widget.itemBuilder(item)),
                            onTap: () {
                              _selectedItem = item;
                              widget.onChanged(item);
                              _overlayEntry?.remove();
                              setState(() => _dropdownOpen = false);
                            },
                          );
                        },
                      ),
                    ),
                ],
              ),
            ),
          ),
        ),
      ),
    );

    Overlay.of(context).insert(_overlayEntry!);
  }

  @override
  Widget build(BuildContext context) {
    return CompositedTransformTarget(
      link: _layerLink,
      child: GestureDetector(
        onTap: _openDropdown,
        child: InputDecorator(
          decoration: InputDecoration(
            hintText: widget.hintText,
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
            contentPadding:
                const EdgeInsets.symmetric(horizontal: 12, vertical: 14),
            suffixIcon: const Icon(Icons.arrow_drop_down),
          ),
          child: Text(
            _selectedItem != null ? widget.itemBuilder(_selectedItem as T) : '',
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _overlayEntry?.remove();
    _scrollController.dispose();
    _searchController.dispose();
    super.dispose();
  }
}
