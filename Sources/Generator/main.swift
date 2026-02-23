import SystemPackage
import BinaryParsing

var path = try programFilesX86Path()
path.append(["Windows Kits", "10", "References"])

let latestVersion = DirectoryItems(in: path)
	.sorted {
		$0.compare($1, options: .numeric) == .orderedDescending
	}.first

struct WindowsSDKNotFound: Error {}

guard let latestVersion else {
	throw WindowsSDKNotFound()
}

extension FilePath {
	/// Appends String components assuming they are valid
	mutating func appendUnsafe<C>(_ components: C) where C : Collection, C.Element == String {
		self.append(components.map { FilePath.Component($0)! })
	}
}

let api = "Windows.System.Power.Thermal.PowerThermalApiContract"

path.appendUnsafe([
	latestVersion,
	api,
	"1.0.0.0",
	"\(api).winmd"
])

let data = try MetadataDB(at: path)
