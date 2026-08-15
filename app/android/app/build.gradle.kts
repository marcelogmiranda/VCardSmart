import java.io.File
import java.util.Properties

plugins {
    id("com.android.application")
    id("kotlin-android")
    id("dev.flutter.flutter-gradle-plugin")
}

android {
    namespace = "com.vcardsmart.app"
    compileSdk = flutter.compileSdkVersion
    ndkVersion = "27.0.12077973"

    compileOptions {
        sourceCompatibility = JavaVersion.VERSION_11
        targetCompatibility = JavaVersion.VERSION_11
    }

    kotlinOptions {
        jvmTarget = JavaVersion.VERSION_11.toString()
    }

    defaultConfig {
        applicationId = "com.vcardsmart.app"
        minSdk = flutter.minSdkVersion
        targetSdk = 36
        versionCode = flutter.versionCode
        versionName = flutter.versionName
    }

    signingConfigs {
        create("release") {
            val keystoreFile = rootProject.file("key.properties")
            if (keystoreFile.exists()) {
                val properties = Properties()
                keystoreFile.inputStream().use { properties.load(it) }
                val storeFilePath = properties.getProperty("storeFile", "keystore.jks")
                val sf = if (File(storeFilePath).isAbsolute) {
                    File(storeFilePath)
                } else {
                    rootProject.file(storeFilePath)
                }
                storeFile = sf
                storePassword = properties.getProperty("storePassword", "")
                keyAlias = properties.getProperty("keyAlias", "")
                keyPassword = properties.getProperty("keyPassword", "")
            }
        }
    }

    buildTypes {
        release {
            signingConfig = if (rootProject.file("key.properties").exists()) {
                signingConfigs.getByName("release")
            } else {
                signingConfigs.getByName("debug")
            }
            isMinifyEnabled = true
            isShrinkResources = true
            proguardFiles(getDefaultProguardFile("proguard-android-optimize.txt"), "proguard-rules.pro")
        }
    }
}

// Força versões com bibliotecas nativas alinhadas a 16 KB (requisito Google Play
// para apps com targetSdk 35+). O mobile_scanner 3.5.7 traz MLKit barcode-scanning
// 17.2.0 e CameraX 1.3.1, cujas libs (libbarhopper_v3.so, libimage_processing_util_jni.so)
// têm segmentos ELF alinhados a 4 KB. MLKit 17.3.0 e CameraX 1.5.3 já emitem libs
// alinhadas a 16 KB. Mantém-se android:extractNativeLibs="true" no manifest
// (libs compactadas/extraídas) para preservar o fix de crash "VM snapshot invalid"
// em Android 10/MIUI — o ELF-alignment das libs é o que o Play valida.
dependencies {
    implementation("com.google.mlkit:barcode-scanning:17.3.0")
    implementation("androidx.camera:camera-core:1.5.3")
    implementation("androidx.camera:camera-camera2:1.5.3")
    implementation("androidx.camera:camera-lifecycle:1.5.3")
}

flutter {
    source = "../.."
}
