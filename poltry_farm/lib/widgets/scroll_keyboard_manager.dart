import 'package:flutter/material.dart';

class ScrollKeyboardManager extends StatefulWidget {
  const ScrollKeyboardManager({
    required this.child,
    required this.focusNodes,
    this.readOnlyFocusNodes,
    this.scrollController,
    super.key,
  });
  final Widget child;
  final List<FocusNode> focusNodes;
  // when these focusNode has focus, it'll not trigger the keyboard
  final List<FocusNode>? readOnlyFocusNodes;
  final ScrollController? scrollController;

  @override
  State<ScrollKeyboardManager> createState() => _ScrollKeyboardManagerState();
}

class _ScrollKeyboardManagerState extends State<ScrollKeyboardManager> {
  late final ScrollController _internalScrollController;
  ScrollController get _controller =>
      widget.scrollController ?? _internalScrollController;

  @override
  void initState() {
    super.initState();

    // Initialize the internal scroll controller if none is provided
    if (widget.scrollController == null) {
      _internalScrollController = ScrollController();
    }

    // Add listeners for focus nodes
    for (final focusNode in widget.focusNodes) {
      focusNode.addListener(() {
        if (focusNode.hasFocus) {
          Future.delayed(const Duration(milliseconds: 100), () {
            _scrollToFocused(focusNode);
          });
        }
      });
    }

    if (widget.readOnlyFocusNodes?.isNotEmpty ?? false) {
      // Add listeners for focus nodes
      for (final readOnlyFocusNode in widget.readOnlyFocusNodes!) {
        readOnlyFocusNode.addListener(() {
          if (readOnlyFocusNode.hasFocus) {
            Future.delayed(const Duration(milliseconds: 100), () {
              _scrollToReadOnlyFocused(readOnlyFocusNode);
            });
          }
        });
      }
    }
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _adjustScrollForKeyboard();
    });
  }

  // Scroll to ensure the focused widget is visible at the top of the screen
  void _scrollToReadOnlyFocused(FocusNode readOnlyFocusNode) {
    final context = readOnlyFocusNode.context;
    if (context == null || !_controller.hasClients) return;

    // Find the position of the focused widget
    final renderObject = context.findRenderObject();
    if (renderObject is RenderBox) {
      final offset = renderObject.localToGlobal(Offset.zero);
      final currentScrollOffset = _controller.offset;
      final maxHeight = MediaQuery.of(context).size.height;
      final bottomPadding = MediaQuery.of(context).padding.bottom;

      final scrollHeight = offset.dy - (maxHeight - 220 - 44 - bottomPadding);

      if (scrollHeight > 0) {
        _controller.animateTo(
          currentScrollOffset + scrollHeight,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOut,
        );
      }
    }
  }

  // Scroll to ensure the focused widget is visible at the top of the screen
  void _scrollToFocused(FocusNode focusNode) {
    final context = focusNode.context;
    if (context == null || !_controller.hasClients) return;

    // Find the position of the focused widget
    final renderObject = context.findRenderObject();
    if (renderObject is RenderBox) {
      final offset = renderObject.localToGlobal(Offset.zero);
      final currentScrollOffset = _controller.offset;

      // Calculate desired scroll offset to bring the widget to the top
      final desiredScrollOffset =
          currentScrollOffset + offset.dy + 600 - kToolbarHeight;

      // Clamp the scroll offset within valid bounds
      final clampedScrollOffset = desiredScrollOffset.clamp(
        0.0,
        // Add 120 to ensure the menu is not overlapped by the keyboard
        _controller.position.maxScrollExtent + 120,
      );

      // Scroll to the calculated offset
      _controller.animateTo(
        clampedScrollOffset,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeOut,
      );
    }
  }

  // Adjust scroll when the keyboard is visible
  void _adjustScrollForKeyboard() {
    final isKeyboardVisible = View.of(context).viewInsets.bottom > 0;
    if (isKeyboardVisible) {
      for (final focusNode in widget.focusNodes) {
        if (focusNode.hasFocus) {
          _scrollToFocused(focusNode);
          break;
        }
      }
    }
  }

  @override
  void dispose() {
    // Dispose internal scroll controller if it was created here
    if (widget.scrollController == null) {
      _internalScrollController.dispose();
    }
    for (final focusNode in widget.focusNodes) {
      focusNode.dispose();
    }
    if (widget.readOnlyFocusNodes?.isNotEmpty ?? false) {
      for (final focusNode in widget.readOnlyFocusNodes!) {
        focusNode.dispose();
      }
    }

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      controller: _controller,
      child: widget.child,
    );
  }
}
