allprojects {
    repositories {
        google()
        mavenCentral()
    }
}

val newBuildDir: Directory =
    rootProject.layout.buildDirectory
        .dir("../../build")
        .get()
rootProject.layout.buildDirectory.value(newBuildDir)

subprojects {
    val newSubprojectBuildDir: Directory = newBuildDir.dir(project.name)
    project.layout.buildDirectory.value(newSubprojectBuildDir)
}
subprojects {
   // Avoid forcing evaluation of the :app project here because that can trigger
   // configuration of the Android NDK and fail if the NDK installation is missing
   // or incomplete (e.g. missing source.properties). If you need to evaluate :app
   // for a specific task, do so conditionally from that task or use a Gradle task
   // dependency instead.
}

tasks.register<Delete>("clean") {
    delete(rootProject.layout.buildDirectory)
}
