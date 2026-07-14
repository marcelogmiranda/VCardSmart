plugins {
    id("com.android.application")
    id("kotlin-android")
    id("dev.flutter.flutter-gradle-plugin")
}

android {
    namespace = "com.vcardsmart.app"
    compileSdk = flutter.compileSdkVersion
    ndkVersion = flutter.ndkVersion

    compileOptions {
        sourceCompatibility = JavaVersion.VERSION_11
        targetCompatibility = JavaVersion.VERSION_11
    }

    kotlinOptions {
        jvmTarget = JavaVersion.VERSION_11.toString()
    }

    defaultConfig {
        applicationId = "com.vcardsmart.app"
        minSdk = 21
        targetSdk = 34
        versionCode = flutter.versionCode
        versionName = flutter.versionName
    }

    signingConfigs {
        create("release") {
            val keystoreFile = rootProject.file("key.properties")
            if (keystoreFile.exists()) {
                val properties = java.util.Properties()
                keystoreFile.inputStream().use { properties.load(it) }
                storeFile = file(properties.getProperty("storeFile", "keystore.jks"))
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

flutter {
    source = "../.."
}
