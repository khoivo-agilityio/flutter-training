import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:poltry_farm/shared/form_models.dart';
import 'package:poltry_farm/widgets/dropdown.dart';
import 'package:poltry_farm/widgets/forms/form_validators.dart';
import 'package:poltry_farm/widgets/search_textfield.dart';
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
        if (textController.text != formState.text) {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            textController
              ..text = formState.text
              ..selection = TextSelection.collapsed(
                offset: formState.text.length.clamp(0, formState.text.length),
              );
          });
        }

        return PfTextField(
          semanticsLabel: formState.semanticsLabel,
          controller: textController,
          keyboardType: formState.keyboardType,
          focusNode: focusNode ?? formState.focusNode,
          validator: PfFormValidators.compose(formState.validators ?? []),
          label: formState.label,
          hintText: formState.hintText,
          onChanged: onChanged,
          textInputAction: formState.textInputAction,
        );
      },
    );
  }

  static BlocSelector<T, V, PfDropdownFormFieldSubState>
      dropdownBloc<T extends BlocBase<V>, V>({
    required PfDropdownFormFieldSubState Function(V state) selector,
    ValueChanged<String?>? onChanged,
    ValueChanged<String?>? onSelected,
    Future<List<PfDropdownSearchItem<String>>> Function()? onFetchItems,
    List<TextInputFormatter>? inputFormatters,
    TextEditingController? controller,
    FocusNode? focusNode,
    bool enableErrorMessage = true,
  }) {
    final textController = controller ?? TextEditingController();

    return _baseControl<T, V, PfDropdownFormFieldSubState>(
      selector: selector,
      controlBuilder: (context, formState) {
        WidgetsBinding.instance.addPostFrameCallback((_) {
          if (textController.text != formState.text) {
            textController
              ..text = formState.text
              ..selection = TextSelection.collapsed(
                offset: formState.text.length.clamp(0, formState.text.length),
              );
          }
        });

        return PfDropdownSearch<String>(
          name: formState.label,
          controller: textController,
          keyboardType: formState.keyboardType,
          focusNode: focusNode ?? formState.focusNode,
          label: formState.label,
          onChanged: onChanged,
          onSelected: onSelected,
          onFetchItems: onFetchItems,
          placeholder: formState.hintText,
        );
      },
    );
  }

  static BlocSelector<T, V, PfSearchTextFormFieldSubState>
      searchTextBloc<T extends BlocBase<V>, V>({
    required PfSearchTextFormFieldSubState Function(V state) selector,
    void Function(String?)? onChanged,
    void Function()? onChangeVisibility,
    List<TextInputFormatter>? inputFormatters,
    TextEditingController? controller,
    FocusNode? focusNode,
    bool enableErrorMessage = true,
  }) {
    final textController = controller ?? TextEditingController();

    return _baseControl<T, V, PfSearchTextFormFieldSubState>(
      selector: selector,
      controlBuilder: (context, formState) {
        WidgetsBinding.instance.addPostFrameCallback((_) {
          if (textController.text != formState.text) {
            textController
              ..text = formState.text
              ..selection = TextSelection.collapsed(
                offset: formState.text.length.clamp(0, formState.text.length),
              );
          }
        });

        return PfSearchTextField(
          semanticsLabel: formState.semanticsLabel,
          controller: textController,
          focusNode: focusNode ?? formState.focusNode,
          hintText: formState.hintText,
          onChanged: onChanged,
          suggestions: formState.suggestions ?? [],
        );
      },
    );
  }
}
