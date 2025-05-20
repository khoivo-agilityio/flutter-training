![][image1]

[www.agilityio.com](http://www.agilityio.com)

# Dart & Flutter training practice plan

## **16th May 2025**

# **OVERVIEW**

This advanced Dart & Flutter training plan is designed to help experienced developers deepen their expertise with Flutter 3.29.0 and Dart 3.7, focusing on advanced application architecture, performance optimization, and platform-specific integrations. Trainees will work through comprehensive, hands-on projects and best practices, gaining the skills to build and maintain robust, production-grade Android and iOS applications.

# **SUMMARY**

- [Flutter advance](#bookmark=kix.jw4krce2imhz)

  - Practice: **4 weeks**

# **ENVIRONMENTS**

- [Install Dart & Flutter SDKs channel stable](https://docs.flutter.dev/get-started/install/macos)

- [Puro](https://puro.dev/reference/manual/)

- [Analyzer for Dart](https://pub.dev/packages/analyzer)

- IDE

  - VSCode

  - Android Studio

  - XCode

# **FLUTTER ADVANCE**

## **TIMELINE**

- [Flutter advance](#bookmark=kix.jw4krce2imhz)

  - Practice: **4 weeks**

## **TARGET & TIMELINE DETAIL**

**\*\*\*** is the IMPORTANT TARGETS

|    STT    | Technical Aspects of Flutter | Description        | Estimated (days) | Status |
| :-------: | :--------------------------: | ------------------ | :--------------: | ------ |
|     1     |  **State management\*\*\***  | Focus on Form BLoC |                  |        |
|     2     |   **Accessibility\*\*\***    |                    |                  |        |
|     3     |     **Native features**      |                    |                  |        |
|     4     |      **Notifications**       |                    |                  |        |
|     5     |  **App performance\*\*\***   | Lazy loading       |                  |        |
|     6     |          **CI/CD**           |                    |                  |        |
| **Total** |                              |                    |                  |        |

##

## **TARGETS**

- Dart, flutter: Reading the updates and new features from the latest versions of Dart 3.7 and Flutter 3.29.0

- State management: Understand and apply advanced state management with BLoC, focus on Form BLoC

- Error handling: Work with APIs (asynchronous) and apply robust error-handling techniques

- Accessibility: Apply at least the A & AA level follow WCAG, for example the list below:

| Rule                                                                | Description                                               | WCAG Level |
| ------------------------------------------------------------------- | --------------------------------------------------------- | :--------: |
| Use semantic widgets (Text, ElevatedButton, Checkbox, etc.)         | Avoid custom-painted elements unless wrapped in Semantics |     A      |
| Add semanticLabel to images/icons                                   | Especially for Image.asset, Icon, and custom components   |     A      |
| Use labelText in TextFormField                                      | Ensures proper form field description                     |     A      |
| Add validator \+ helperText for form errors and guidance            | Provides error identification and suggestion              |   A / AA   |
| Support FocusTraversalGroup or FocusNode for keyboard nav           | Makes custom UIs accessible via keyboard                  |     A      |
| Ensure AppBar and major sections have descriptive titles            | Logical navigation and headings                           |   A / AA   |
| Maintain contrast ratio ≥ 4.5:1 between text and background         | Use tools like contrast checkers                          |     AA     |
| Support text scaling with MediaQuery.textScaleFactorOf(context)     | Avoid hardcoded font sizes                                |     AA     |
| Avoid using only color to indicate state (errors, status, etc.)     | Use icons or text as additional cues                      |     AA     |
| Ensure buttons/links have descriptive labels (Submit, View Profile) | Avoid ambiguous actions like “Click here”                 |     AA     |
| Test with screen reader (TalkBack, VoiceOver)                       | Manually validate accessibility                           |    A/AA    |

- Native Features: Understand and implement advanced permission handling, including runtime permissions, background permissions, and permission rationale dialogs for both Android and iOS platforms, while ensuring compliance with platform-specific guidelines and user privacy standards

- App performance: Lazy Loading \+ Local Database

- CI/CD: Set up and automate GitHub Actions for building, testing, and deploying Flutter applications

## **FEATURES**

- **Login**

- **Logout**

- **HomePage**

- **Buy/Sell**

- **Farm Setting**

- **Notifications**

- **CI/CD**

[image1]: data:image/png;base64,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
