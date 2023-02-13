import ProjectDescription

let config = Config(
    compatibleXcodeVersions: ["14.2"],
    swiftVersion: "5.4.0",
    generationOptions: [
        .xcodeProjectName("SomePrefix-\(.projectName)-SomeSuffix"),
        .organizationName("Sasha"),
        .developmentRegion("ru")
    ]
)
