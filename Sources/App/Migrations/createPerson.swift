//
//  File.swift
//  
//
//  Created by Doaa on 21/03/2023.
//

import Vapor
import Fluent
import FluentPostgresDriver

struct createPerson: Migration {
    func prepare(on database: FluentKit.Database) -> NIOCore.EventLoopFuture<Void> {
        return database.schema("personS")
            .id()
            .field("name",.string, .required)
            .field("ticket",.string, .required)
            .field("event_id", .uuid, .references("eventS", "id"))
            .create()
    }
    //------ Undo -----
    func revert(on database: FluentKit.Database) -> NIOCore.EventLoopFuture<Void> {
        return database.schema("personS").delete()
       
    }
    
    
    
}
