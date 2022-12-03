import Foundation

struct App {
    let name: String
    let iconPath: String
    let slug: String
    let releaseNotesPath: String
    let description: String
}

extension App {
    init(name: String, slug: String, description: String) {
        self.init(name: name, iconPath: "apps/\(slug).png", slug: slug, releaseNotesPath: "~/Developer/\(slug)/releasenotes.json", description: description)
    }
}

let apps: [App] = [
    App(name: "Games Keeper", iconPath: "apps/gameskeeper.png", slug: "gameskeeper", releaseNotesPath: "~/Developer/GamesKeeper/releasenotes.json", description: "Score tracking for board games"),
    App(name: "Nano Notes", slug: "nanonotes", description: "Sync notes with Apple Watch"),
    App(name: "Comic Book Day", slug: "comicbookday", description: "Track comic book releases"),
    App(name: "1List", slug: "onelist", description: "Simple reminders list"),
    App(name: "Contact[s]", slug: "contacts", description: "Beautiful address book"),
    App(name: "Mega Moji", slug: "megamoji", description: "Big emoji for iMessage"),
    App(name: "Memorii", slug: "memorii", description: "Study Chinese, Japanese, and Korean"),
    App(name: "WizBox", slug: "wizbox", description: "Magic: The Gathering toolbox"),
    App(name: "D0TS:Echoplex", slug: "echoplex", description: "Music sequencer")
]

/// FROM Trackup
public struct TrackupDocument: Codable {
    public var title: String = ""
    public var versions: [TrackupVersion] = []
    public var website: URL?
}

public struct TrackupVersion: Codable {
    public var title: String = ""
    public var items: [TrackupItem] = []
    public var createdDate: DateComponents?

    func inProgress() -> Bool {
        for item in self.items {
            if (item.state != .unknown) {
                return true
            }
        }

        return false
    }
}

public struct TrackupItem: Codable {
    public var title: String = ""
    public var state: TrackupItemState = .unknown
    public var status: TrackupItemStatus = .unknown
}

public enum TrackupItemState: String, Codable {
    case unknown
    case todo
    case done
}

public enum TrackupItemStatus: String, Codable {
    case unknown
    case major
}
///

let decoder = JSONDecoder()
let appsHTML = apps.map { app in
    // let url = URL(fileURLWithPath: NSString(string: app.releaseNotesPath).expandingTildeInPath)
    // let data = try! Data(contentsOf: url)
    // let releaseNotes = try! decoder.decode(TrackupDocument.self, from: data)
    // let lastVersion = releaseNotes.versions.first!
    // let dateString = DateComponentsFormatter.localizedString(from: lastVersion.createdDate!, unitsStyle: .full)

    return """
        <a class="app" href="https://www.studioamanga.com/\(app.slug)/">
            <img alt="\(app.name) Icon" class="icon" src="img/\(app.iconPath)">
            <div>
                <h3>\(app.name)</h3>
                <div class="subtitle">\(app.description)</div>
            </div>
        </a>
    """ }.joined(separator: "\n")

guard let indexTemplate = try? String(contentsOfFile: "template/index.html") else {
    abort()
}

let indexHTML = indexTemplate.replacingOccurrences(of: "[APPS]", with: appsHTML)
print("\(indexHTML)")
