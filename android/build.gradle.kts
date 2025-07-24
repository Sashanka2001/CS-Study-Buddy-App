 // Top-level build.gradle.kts

buildscript {
    repositories {
        google()
        mavenCentral()
    }
    dependencies {
        classpath("com.android.tools.build:gradle:7.4.1")         // Android Gradle Plugin
        classpath("com.google.gms:google-services:4.3.15")        // Google Services Plugin (Firebase)
        classpath(kotlin("gradle-plugin", version = "1.8.22"))    // Kotlin Gradle plugin (adjust version if needed)
    }
}

allprojects {
    repositories {
        google()
        mavenCentral()
    }
}

// Optional: change build directory (if you want)
val newBuildDir = rootProject.layout.buildDirectory.dir("../../build").get()
rootProject.layout.buildDirectory.value(newBuildDir)

subprojects {
    val newSubprojectBuildDir = newBuildDir.dir(project.name)
    project.layout.buildDirectory.value(newSubprojectBuildDir)

    // Make sure app project is evaluated first
    project.evaluationDependsOn(":app")
}

tasks.register<Delete>("clean") {
    delete(rootProject.layout.buildDirectory)
}
