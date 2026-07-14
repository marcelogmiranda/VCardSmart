# VCardSmart ProGuard Rules

# Keep Hive
-keep class com.vcardsmart.** { *; }
-keep class io.flutter.** { *; }

# Keep plugin classes
-keep class io.flutter.plugins.** { *; }

# Keep encryption
-keep class javax.crypto.** { *; }
-keep class org.bouncycastle.** { *; }
