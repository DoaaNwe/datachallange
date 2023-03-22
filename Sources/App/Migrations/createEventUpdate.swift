//
//  File.swift
//  
//
//  Created by Doaa on 21/03/2023.
//

import Vapor
import Fluent
import FluentPostgresDriver

struct createEventUpdate: Migration {
    func prepare(on database: FluentKit.Database) -> NIOCore.EventLoopFuture<Void> {
        return database.schema("eventS")
            .id()
            .field("title",.string, .required)
            .field("time",.date, .required)
            .field("event_id", .uuid, .references("eventS", "id"))
            .create()
//            .update()
    }
    //------ Undo -----
    func revert(on database: FluentKit.Database) -> NIOCore.EventLoopFuture<Void> {
        return database.schema("eventS").delete()
       
    }
    
    
    
}
