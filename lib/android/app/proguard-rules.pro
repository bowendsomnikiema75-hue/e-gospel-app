# Règles Proguard/R8 pour la version Release.
# Flutter et le plugin webview_flutter gèrent déjà l'essentiel de leurs
# propres règles ; ce fichier reste volontairement minimal.

-keep class io.flutter.plugins.** { *; }
-keep class io.flutter.plugin.**  { *; }
