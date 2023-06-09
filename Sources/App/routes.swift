import Fluent
import Vapor
import FluentPostgresDriver
func routes(_ app: Application) throws {
    app.get { req async in
        "It works!"
    }

    app.get("hello") { req async -> String in
        "Hello, world!"
    }
//----------http://127.0.0.1:8080/hello/doaa --------- answer : Hello, doaa!
//    app.get("hello", ":name") { req -> String in
//        let name = req.parameters.get("name")!
//        return "Hello, \(name)!"
//    }
    //-------- other way get  -------
//    app.get("Event") { req -> EventLoopFutuer<[Event]> in
//        return Event.query(on: req.db).all
        
    try app.register(collection: eventcontroller())
    try app.register(collection: personcontroller())
    
}
