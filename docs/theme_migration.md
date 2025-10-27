# Theme Migration Guide

When converting from FlutterFlowTheme to our AppTheme, use the following mappings:

## Text Styles

FlutterFlowTheme -> AppTheme
- bodyText1 -> textTheme.bodyLarge
- bodyText2 -> textTheme.bodyMedium
- subtitle1 -> textTheme.titleMedium
- subtitle2 -> textTheme.titleSmall
- headline1 -> textTheme.displayLarge
- headline2 -> textTheme.displayMedium
- headline3 -> textTheme.displaySmall
- headline4 -> textTheme.headlineMedium
- headline5 -> textTheme.headlineSmall
- headline6 -> textTheme.titleLarge

## Colors

FlutterFlowTheme -> AppTheme
- primaryText -> textTheme.bodyLarge?.color
- secondaryText -> textTheme.bodyMedium?.color
- primary -> colorScheme.primary
- secondary -> colorScheme.secondary
- tertiary -> colorScheme.tertiary
- alternate -> colorScheme.surface
- primaryBackground -> colorScheme.background
- secondaryBackground -> colorScheme.surface

## Common Patterns

Instead of:
```dart
style: FlutterFlowTheme.of(context).bodyMedium.override(
  font: GoogleFonts.readexPro(),
  color: FlutterFlowTheme.of(context).secondaryText,
)
```

Use:
```dart
style: Theme.of(context).textTheme.bodyMedium?.copyWith(
  fontFamily: GoogleFonts.readexPro().fontFamily,
  color: Theme.of(context).textTheme.bodyMedium?.color,
)
```

Instead of:
```dart
color: FlutterFlowTheme.of(context).primary
```

Use:
```dart
color: Theme.of(context).colorScheme.primary
```