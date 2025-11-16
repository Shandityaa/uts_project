plugins {
    id("com.android.application")
    id("kotlin-android")
    id("dev.flutter.flutter-gradle-plugin")

    // Plugin Google Services (WAJIB)
    id("com.google.gms.google-services")
}

android {
    namespace = "com.example.uts_project"
    compileSdk = 36

    defaultConfig {
        applicationId = "com.example.uts_project"
        minSdk = flutter.minSdkVersion
        targetSdk = 36
        versionCode = 1
        versionName = "1.0"
    }

    compileOptions {
        sourceCompatibility = JavaVersion.VERSION_17
        targetCompatibility = JavaVersion.VERSION_17
    }

    kotlinOptions {
        jvmTarget = "17"
    }

    buildTypes {
        release {
            signingConfig = signingConfigs.getByName("debug")
        }
    }
}

flutter {
    source = "../.."
}

// WAJIB Untuk Firebase di Kotlin DSL
apply(plugin = "com.google.gms.google-services")
