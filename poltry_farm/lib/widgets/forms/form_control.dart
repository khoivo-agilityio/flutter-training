import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:poltry_farm/extensions/context_extension.dart';
import 'package:poltry_farm/shared/form_models.dart';
import 'package:poltry_farm/widgets/forms/form_validators.dart';
import 'package:poltry_farm/widgets/text_field.dart';

BlocSelector<T, V, Z> _baseControl<T extends BlocBase<V>, V, Z>({
  required Z Function(V state) selector,
  required Widget Function(BuildContext context, Z value) controlBuilder,
}) {
  return BlocSelector<T, V, Z>(
    selector: selector,
    builder: (context, value) => controlBuilder(context, value),
  );
}

class PfFormControls {
  static BlocSelector<T, V, PfPlainTextFormFieldSubState>
      textBloc<T extends BlocBase<V>, V>({
    required PfPlainTextFormFieldSubState Function(V state) selector,
    void Function(String?)? onChanged,
    void Function()? onChangeVisibility,
    List<TextInputFormatter>? inputFormatters,
    TextEditingController? controller,
    FocusNode? focusNode,
    bool enableErrorMessage = true,
  }) {
    final textController = controller ?? TextEditingController();

    return _baseControl<T, V, PfPlainTextFormFieldSubState>(
      selector: selector,
      controlBuilder: (context, formState) {
        _syncControllerWithState(textController, formState);

        return PfTextField(
          semanticsLabel: formState.semanticsLabel,
          controller: textController,
          keyboardType: formState.keyboardType,
          focusNode: focusNode ?? formState.focusNode,
          validator: PfFormValidators.compose(formState.validators ?? []),
          label: formState.label,
          inputDecoration:
              _buildInputDecoration(context, formState, enableErrorMessage),
        );
      },
    );
  }

  static void _syncControllerWithState(TextEditingController controller,
      PfPlainTextFormFieldSubState formState) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (controller.text != formState.text) {
        controller
          ..text = formState.text
          ..selection = TextSelection.collapsed(
            offset: formState.text.length.clamp(0, formState.text.length),
          );
      }
    });
  }

  static InputDecoration _buildInputDecoration(
    BuildContext context,
    PfPlainTextFormFieldSubState state,
    bool enableErrorMessage,
  ) {
    final theme = context.themeData.textTheme;
    final colorScheme = context.colorScheme;

    return InputDecoration(
      constraints: const BoxConstraints(minHeight: 40),
      isDense: true,
      contentPadding: const EdgeInsets.symmetric(vertical: 12),
      prefix: const SizedBox(width: 12),
      suffix: const SizedBox(width: 12),
      label: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12),
        child: Text(state.placeholder),
      ),
      errorStyle: theme.labelLarge?.copyWith(
        color: colorScheme.onErrorContainer,
        fontSize: enableErrorMessage ? theme.labelLarge?.fontSize : 1,
      ),
      disabledBorder: OutlineInputBorder(
        borderSide: BorderSide(color: colorScheme.outline),
        borderRadius: const BorderRadius.all(Radius.circular(8)),
      ),
      fillColor:
          state.enable ? colorScheme.primaryContainer : colorScheme.outline,
    );
  }
}
