plugins {
    alias(libs.plugins.android.application)
    id("com.google.android.libraries.mapsplatform.secrets-gradle-plugin")
}

android {
    namespace = "com.example.plantishop"
    compileSdk = 35

    defaultConfig {
        applicationId = "com.example.plantishop"
        minSdk = 26
        targetSdk = 35
        versionCode = 1
        versionName = "1.0"

        testInstrumentationRunner = "androidx.test.runner.AndroidJUnitRunner"
    }

    buildTypes {
        release {
            isMinifyEnabled = false
            proguardFiles(
                getDefaultProguardFile("proguard-android-optimize.txt"),
                "proguard-rules.pro"
            )
        }
    }
    compileOptions {
        sourceCompatibility = JavaVersion.VERSION_11
        targetCompatibility = JavaVersion.VERSION_11
    }
    buildFeatures {
        buildConfig = true
    }
}

dependencies {

    implementation(libs.appcompat)
    implementation(libs.material)
    implementation(libs.activity)
    implementation(libs.constraintlayout)
    implementation("com.mysql:mysql-connector-j:8.2.0")
    implementation("mx.openpay:openpay-api-client:1.7.0")
    implementation("com.google.maps:google-maps-services:2.2.0")
    implementation("org.slf4j:slf4j-simple:1.7.25")
    implementation("com.google.android.gms:play-services-maps:18.2.0")
    implementation(files("libs/javax.mail.jar"))
    implementation(files("libs/REngine.jar"))
    implementation(files("libs/Rserve.jar"))
    testImplementation(libs.junit)
    androidTestImplementation(libs.ext.junit)
    androidTestImplementation(libs.espresso.core)
}

secrets {
    propertiesFileName = "secrets.properties"
    defaultPropertiesFileName = "local.defaults.properties"
    ignoreList.add("keyToIgnore")
    ignoreList.add("sdk.*")
}