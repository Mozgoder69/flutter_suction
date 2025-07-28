# Flutter / embedding
-keep class io.flutter.** { *; }
-keep class io.flutter.plugins.** { *; }
-keep class io.flutter.embedding.** { *; }
-dontwarn io.flutter.**

# Kotlin coroutines and metadata (часто используются зависимостями)
-keepclassmembers class kotlin.Metadata { *; }
-dontwarn kotlinx.coroutines.**

# Riverpod (генерёнка не использует рефлексию, но на всякий случай)
-dontwarn dev.**
-dontwarn riverpod.**

# AndroidX Lifecycle (используется многими плагинами)
-keep class androidx.lifecycle.DefaultLifecycleObserver
-keep interface androidx.lifecycle.DefaultLifecycleObserver
