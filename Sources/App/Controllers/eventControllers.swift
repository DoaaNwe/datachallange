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
        
        let eventS = routes.grouped("eventS")
        eventS.get(use: index)
        eventS.post(use: create)
        eventS.group(":eventID") { event in event .put(use: update) }
        eventS.group(":eventID") { event in event .delete(use: delete) }
        
        
    }//boot func
    
    
    
    // ------ get----- /event route
    func index(req: Request) throws -> EventLoopFuture<[Event]> {
        return Event.query(on: req.db).all()
    }//get
    
    
    
    //------ creart -----
    func create(req: Request) throws -> EventLoopFuture<HTTPStatus> {
        let event = try req.content.decode(Event.self)
        return event.save(on: req.db).transform(to: .ok)
        
    }//creat
    
    
    //------ update item ---------
    func update(req: Request) throws -> EventLoopFuture<Event> {
        let eventnew = try req.content.decode(Event.self)
        return Event.find(req.parameters.get("eventID"), on:req.db)
            .unwrap(or: Abort(.notFound))
                .flatMap{ event in
                    event.title = eventnew.title
                    return event.save(on: req.db).map { Event(id: event.id , title: event.title , time: event.time)}
                }
        
                    }//updte
    
    
    //------- delete item ------
    func delete (req : Request) throws -> EventLoopFuture<HTTPStatus> {
        return Event.find(req.parameters.get("eventID"), on:req.db)
            .unwrap(or: Abort(.notFound))
            .flatMap{ $0.delete(on: req.db) }
            .transform(to: .ok)
        
    }//delete
    
    
}
