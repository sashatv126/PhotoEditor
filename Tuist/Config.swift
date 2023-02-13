import ProjectDescription

let config = Config(
    compatibleXcodeVersions: ["12.0"],
    swiftVersion: "5.4.0",
    generationOptions: .options(
        xcodeProjectName: "SomePrefix-\(.projectName)-SomeSuffix",
        organizationName: "Sasha",
        developmentRegion: "ru"
    )
)
