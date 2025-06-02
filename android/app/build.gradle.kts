// Plugins aplicados ao módulo app
plugins {
    id("com.android.application")
    id("org.jetbrains.kotlin.android")       // Suporte ao Kotlin Android
    id("dev.flutter.flutter-gradle-plugin") // Plugin do Flutter
    id("com.google.gms.google-services")   // Plugin do Firebase
}

// Configurações específicas do Android
android {
    namespace = "com.halezzi.recyclick"
    compileSdk = flutter.compileSdkVersion
    ndkVersion = "27.0.12077973"

    defaultConfig {
        applicationId = "com.halezzi.recyclick"
        minSdk = 23
        targetSdk = flutter.targetSdkVersion
        versionCode = flutter.versionCode
        versionName = flutter.versionName
    }

    compileOptions {
        // Define a versão da linguagem Java usada no app
        sourceCompatibility = JavaVersion.VERSION_17
        targetCompatibility = JavaVersion.VERSION_17
        // Necessário para usar novas APIs do Java com desugaring
        isCoreLibraryDesugaringEnabled = true
    }

    kotlinOptions {
        jvmTarget = "17" // Compatível com Java 17
    }

    buildTypes {
        release {
            // Para builds de produção, configure seu próprio signingConfig de release.
            signingConfig = signingConfigs.getByName("debug")
        }
    }
}

// Dependências específicas para desugaring
dependencies {
    coreLibraryDesugaring("com.android.tools:desugar_jdk_libs:2.1.5")
}

// Integração com o Flutter
flutter {
    source = "../.."
}
