// build.gradle.kts (projeto raiz)

buildscript {
    repositories {
        google()
        mavenCentral()
    }
    dependencies {
        // Plugin do Firebase (Google Services)
        classpath("com.google.gms:google-services:4.3.15")

        // Plugin do Android (AGP 8.10.1 compatível com Gradle 8.11.1)
        classpath("com.android.tools.build:gradle:8.10.1")

        // Plugin do Kotlin Android (ajustável conforme a versão usada)
        classpath("org.jetbrains.kotlin:kotlin-gradle-plugin:1.9.22")
    }
}

allprojects {
    repositories {
        google()
        mavenCentral()
    }
}

// Ajuste opcional de diretório build compartilhado
val newBuildDir = rootProject.layout.buildDirectory.dir("../../build").get()
rootProject.layout.buildDirectory.set(newBuildDir)

subprojects {
    val subprojectDir = newBuildDir.dir(project.name)
    layout.buildDirectory.set(subprojectDir)
    evaluationDependsOn(":app")
}

tasks.register<Delete>("clean") {
    delete(rootProject.layout.buildDirectory)
}
