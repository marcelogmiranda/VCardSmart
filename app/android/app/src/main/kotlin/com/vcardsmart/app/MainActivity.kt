package com.vcardsmart.app

import android.os.Build
import android.os.Bundle
import androidx.core.view.WindowCompat
import io.flutter.embedding.android.FlutterActivity

class MainActivity : FlutterActivity() {
    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        // Android 15+ (API 35) e o targetSdk 36 forçam edge-to-edge. Nos API 30-34
        // adotamos explicitamente (equivalente a enableEdgeToEdge()) para que o
        // Flutter lide com os insets de status bar / barra de navegação de forma
        // consistente. O Flutter já renderiza atrás das barras de sistema e o
        // framework aplica as safe areas via MediaQuery/SafeArea.
        if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.R) {
            WindowCompat.setDecorFitsSystemWindows(window, false)
        }
    }
}
