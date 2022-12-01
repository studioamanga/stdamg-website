import Foundation

struct App {
    let name: String
    let iconPath: String
    let slug: String
    let releaseNotesPath: String
}

let apps: [App] = [
    App(name: "Games Keeper", iconPath: "apps/gameskeeper.png", slug: "gameskeeper", releaseNotesPath: "~/Developer/GamesKeeper/releasenotes.json"),
    App(name: "Comic Book Day", iconPath: "apps/comicbookday.png", slug: "comicbookday", releaseNotesPath: "~/Developer/comicbookday/releasenotes.json"),
    App(name: "1List", iconPath: "apps/onelist.png", slug: "onelist", releaseNotesPath: "~/Developer/onelist/releasenotes.json"),
    App(name: "Contact[s]", iconPath: "apps/contacts.png", slug: "contacts", releaseNotesPath: "~/Developer/contacts/releasenotes.json"),
    App(name: "Mega Moji", iconPath: "apps/megamoji.png", slug: "megamoji", releaseNotesPath: "~/Developer/megamoji/releasenotes.json"),
    App(name: "Memorii", iconPath: "apps/memorii.png", slug: "memorii", releaseNotesPath: "~/Developer/memorii/releasenotes.json"),
    App(name: "Nano Notes", iconPath: "apps/nanonotes.png", slug: "nanonotes", releaseNotesPath: "~/Developer/nanonotes/releasenotes.json"),
    App(name: "WizBox", iconPath: "apps/wizbox.png", slug: "wizbox", releaseNotesPath: "~/Developer/wizbox/releasenotes.json"),
    App(name: "D0TS:Echoplex", iconPath: "apps/echoplex.png", slug: "echoplex", releaseNotesPath: "~/Developer/echoplex/releasenotes.json")
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
            <h3>\(app.name)</h3>
        </a>
    """ }.joined(separator: "\n")

guard let indexTemplate = try? String(contentsOfFile: "template/index.html") else {
    abort()
}

let indexHTML = indexTemplate.replacingOccurrences(of: "[APPS]", with: appsHTML)
print("\(indexHTML)")
