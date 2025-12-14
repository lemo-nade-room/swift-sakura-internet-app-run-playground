import Vapor

func configure(_ app: Application) async throws {
  app.get { req in
    if let name: String = try? req.query.get(at: "name") {
      "Hello, \(name)!"
    } else {
      "Hello, World!"
    }
  }
}
