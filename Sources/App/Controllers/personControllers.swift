//
//  File.swift
//  
//
//  Created by Doaa on 21/03/2023.
//

import Fluent
import Vapor
import FluentPostgresDriver

struct personcontroller: RouteCollection {
    
    func boot(routes: Vapor.RoutesBuilder) throws {
        
        let personS = routes.grouped("personS")
        personS.get(use: index)
        personS.post(use: create)
        personS.group(":personID") { event in event .put(use: update) }
        personS.group(":personID") { event in event .delete(use: delete) }
        
        
    }//boot func
    
    
    
    // ------ get----- /event route
    func index(req: Request) throws -> EventLoopFuture<[Person]> {
        return Person.query(on: req.db).all()
    }//get
    
    
    
    //------ creart -----
    func create(req: Request) throws -> EventLoopFuture<HTTPStatus> {
        let person = try req.content.decode(Person.self)
        return person.save(on: req.db).transform(to: .ok)
        
    }//creat
    
    
//    func update(req: Request) throws -> EventLoopFuture<Person> {
//        let personnew = try req.content.decode(Person.self)
//        return Person.find(req.parameters.get("personID"), on:req.db)
//            .unwrap(or: Abort(.notFound))
//                .flatMap{ person in
//                    person.name = personnew.name
//                    return person.save(on: req.db).map { Person(id: person.id , name: person.name , ticket: person.ticket, eventID: <#UUID#>)}
//                }
//
//                    }//updte
    
    
    
//    ------ update item ---------saba
    func update(req: Request) throws -> EventLoopFuture<HTTPStatus> {
        let personnew = try req.content.decode(Person.self)
        return Person.find(personnew.id , on:req.db)
            .unwrap(or: Abort(.notFound))
            .flatMap{
                
                $0.name = personnew.name
                $0.ticket = personnew.ticket
                $0.event_id = personnew.event_id
                return $0.update(on: req.db).transform(to: .ok)}

                    }//updte
    
    
    //------- delete item ------
    func delete (req : Request) throws -> EventLoopFuture<HTTPStatus> {
        return Person.find(req.parameters.get("PersonID"), on:req.db)
            .unwrap(or: Abort(.notFound))
            .flatMap{ $0.delete(on: req.db) }
            .transform(to: .ok)
        
    }//delete
    
    
}
