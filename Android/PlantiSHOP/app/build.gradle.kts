plugins {
    alias(libs.plugins.android.application)
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
}

dependencies {

    implementation(libs.appcompat)
    implementation(libs.material)
    implementation(libs.activity)
    implementation(libs.constraintlayout)
    implementation(files("libs\\javax.mail.jar"))
    implementation(files("libs\\mysql-connector-j-8.2.0.jar"))
    implementation(files("libs\\JRI.jar"))
    implementation(files("libs\\JRIEngine.jar"))
    implementation(files("libs\\REngine.jar"))
    testImplementation(libs.junit)
    androidTestImplementation(libs.ext.junit)
    androidTestImplementation(libs.espresso.core)
}