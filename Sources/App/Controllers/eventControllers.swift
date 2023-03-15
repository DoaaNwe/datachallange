//
//  eventControllers.swift
//  
//
//  Created by Doaa on 13/03/2023.
//

import Fluent
import Vapor
import FluentPostgresDriver

struct eventcontroller: RouteCollection {
    
    func boot(routes: Vapor.RoutesBuilder) throws {
        let events = routes.grouped("events")
        events.get(use: index)
    }
    // ----- /event route
    func index(req: Request) throws -> EventLoopFuture<[Event]> {
        return Event.query(on: req.db).all()
    }

}
