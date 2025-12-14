import Testing
import VaporTesting

@testable import App

@Suite struct AppTests {
  @Test func helloWorld() async throws {
    try await withApp(configure: configure) { app in
      try await app.testing()
        .test(
          .GET,
          "",
          afterResponse: { res async in
            #expect(res.status == .ok)
            #expect(res.body.string == "Hello, World!")
          }
        )
    }
  }

  @Test func helloMyName() async throws {
    try await withApp(configure: configure) { app in
      try await app.testing()
        .test(.GET, "") { req in
          try req.query.encode(["name": "LemoNade"])
        } afterResponse: { res in
          #expect(res.status == .ok)
          #expect(res.body.string == "Hello, LemoNade!")
        }
    }
  }
}
