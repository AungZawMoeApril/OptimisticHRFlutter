# PowerShell script to replace FlutterFlowTheme with standard Flutter Theme

$replacements = @{
    'FlutterFlowTheme.of(context).primary' = 'Theme.of(context).colorScheme.primary'
    'FlutterFlowTheme.of(context).secondary' = 'Theme.of(context).colorScheme.secondary'
    'FlutterFlowTheme.of(context).tertiary' = 'Theme.of(context).colorScheme.tertiary'
    'FlutterFlowTheme.of(context).alternate' = 'Theme.of(context).colorScheme.surface'
    'FlutterFlowTheme.of(context).primaryBackground' = 'Theme.of(context).colorScheme.background'
    'FlutterFlowTheme.of(context).secondaryBackground' = 'Theme.of(context).colorScheme.surface'
    'FlutterFlowTheme.of(context).primaryText' = 'Theme.of(context).textTheme.bodyLarge?.color'
    'FlutterFlowTheme.of(context).secondaryText' = 'Theme.of(context).textTheme.bodyMedium?.color'
    'FlutterFlowTheme.of(context).accent1' = 'Theme.of(context).colorScheme.primaryContainer'
    'FlutterFlowTheme.of(context).accent2' = 'Theme.of(context).colorScheme.secondaryContainer'
    'FlutterFlowTheme.of(context).accent3' = 'Theme.of(context).colorScheme.tertiaryContainer'
    'FlutterFlowTheme.of(context).accent4' = 'Theme.of(context).colorScheme.surfaceVariant'
    'FlutterFlowTheme.of(context).success' = 'Theme.of(context).colorScheme.surfaceTint'
    'FlutterFlowTheme.of(context).error' = 'Theme.of(context).colorScheme.error'
    'FlutterFlowTheme.of(context).warning' = 'Colors.orange'
    'FlutterFlowTheme.of(context).info' = 'Theme.of(context).colorScheme.outline'
    'FlutterFlowTheme.of(context).themeColor' = 'Theme.of(context).colorScheme.primary'
    'FlutterFlowTheme.of(context).displayLarge' = 'Theme.of(context).textTheme.displayLarge'
    'FlutterFlowTheme.of(context).displayMedium' = 'Theme.of(context).textTheme.displayMedium'
    'FlutterFlowTheme.of(context).displaySmall' = 'Theme.of(context).textTheme.displaySmall'
    'FlutterFlowTheme.of(context).headlineLarge' = 'Theme.of(context).textTheme.headlineLarge'
    'FlutterFlowTheme.of(context).headlineMedium' = 'Theme.of(context).textTheme.headlineMedium'
    'FlutterFlowTheme.of(context).headlineSmall' = 'Theme.of(context).textTheme.headlineSmall'
    'FlutterFlowTheme.of(context).titleLarge' = 'Theme.of(context).textTheme.titleLarge'
    'FlutterFlowTheme.of(context).titleMedium' = 'Theme.of(context).textTheme.titleMedium'
    'FlutterFlowTheme.of(context).titleSmall' = 'Theme.of(context).textTheme.titleSmall'
    'FlutterFlowTheme.of(context).bodyLarge' = 'Theme.of(context).textTheme.bodyLarge'
    'FlutterFlowTheme.of(context).bodyMedium' = 'Theme.of(context).textTheme.bodyMedium'
    'FlutterFlowTheme.of(context).bodySmall' = 'Theme.of(context).textTheme.bodySmall'
    "import '/core/theme/flutter_flow_theme.dart';" = ''
    "import '/flutter_flow/flutter_flow_theme.dart';" = ''
}

$files = Get-ChildItem -Path "lib" -Filter *.dart -Recurse

foreach ($file in $files) {
    $content = Get-Content -Path $file.FullName -Raw
    $originalContent = $content
    
    # Apply all replacements
    foreach ($key in $replacements.Keys) {
        $content = $content.Replace($key, $replacements[$key])
    }
    
    # Regex replacements for font styles
    $content = $content -replace 'fontWeight:\s*FlutterFlowTheme\.of\(context\)\.(\w+)\.fontWeight', 'fontWeight: Theme.of(context).textTheme.$1?.fontWeight'
    $content = $content -replace 'fontStyle:\s*FlutterFlowTheme\.of\(context\)\.(\w+)\.fontStyle', 'fontStyle: Theme.of(context).textTheme.$1?.fontStyle'
    
    # Only write if content changed
    if ($content -ne $originalContent) {
        Set-Content -Path $file.FullName -Value $content -NoNewline
        Write-Host "Updated: $($file.FullName)"
    }
}

Write-Host "Replacement complete!"
