import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:poltry_farm/extensions/context_extension.dart';
import 'package:poltry_farm/shared/form_models.dart';
import 'package:poltry_farm/widgets/forms/form_validators.dart';
import 'package:poltry_farm/widgets/text_field.dart';

BlocSelector<T, V, Z> _baseControl<T extends BlocBase<V>, V, Z>({
  required Z Function(V state) selector,
  required Widget Function(BuildContext, Z) controlBuilder,
}) {
  return BlocSelector<T, V, Z>(
    selector: selector,
    builder: (context, Z fieldData) {
      return controlBuilder(context, fieldData);
    },
  );
}

class PfFormControls {
  /// Builds a [PfTextField] widget with a [TextInputFormatter] that depends on
  /// the value of [selector] in the [Cubit] & [Bloc] state.
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
      controlBuilder: (context, PfPlainTextFormFieldSubState fieldData) {
        WidgetsBinding.instance.addPostFrameCallback((_) {
          if (textController.text != fieldData.text) {
            final currentSelection = fieldData.text.isEmpty
                ? const TextSelection.collapsed(offset: 0)
                : TextSelection.collapsed(
                    offset:
                        fieldData.text.length.clamp(0, fieldData.text.length),
                  );
            textController
              ..text = fieldData.text
              ..selection = currentSelection;
          }
        });
        return PfTextField(
          semanticsLabel: fieldData.semanticsLabel,
          controller: textController,
          keyboardType: fieldData.keyboardType,
          inputDecoration: InputDecoration(
            constraints: const BoxConstraints(
              minHeight: 40,
            ),
            isDense: true,
            contentPadding: const EdgeInsets.symmetric(
              vertical: 12,
            ),
            prefix: const SizedBox(width: 12),
            suffix: const SizedBox(width: 12),
            errorStyle: context.themeData.textTheme.labelLarge?.copyWith(
              color: context.colorScheme.onErrorContainer,
              fontSize: enableErrorMessage
                  ? context.themeData.textTheme.labelLarge?.fontSize
                  : 1,
            ),
            disabledBorder: OutlineInputBorder(
              borderSide: BorderSide(
                color: context.colorScheme.outline,
              ),
              borderRadius: const BorderRadius.all(
                Radius.circular(8),
              ),
            ),
            fillColor: fieldData.enable
                ? context.colorScheme.primaryContainer
                : context.colorScheme.outline,
            label: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              child: Text(fieldData.placeholder),
            ),
          ),
          validator: PfFormValidators.compose(fieldData.validators ?? []),
          label: fieldData.label,
          focusNode: focusNode ?? fieldData.focusNode,
        );
      },
    );
  }
}
