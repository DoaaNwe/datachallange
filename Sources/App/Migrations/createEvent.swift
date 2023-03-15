//
//  createEvent.swift
//  
//
//  Created by Doaa on 13/03/2023.
//
import Vapor
import Fluent
import FluentPostgresDriver

struct createEvent: Migration {
    func prepare(on database: FluentKit.Database) -> NIOCore.EventLoopFuture<Void> {
        return database.schema("events")
            .id()
            .field("title",.string, .required)
            .create()
    }
    //------ Undo -----
    func revert(on database: FluentKit.Database) -> NIOCore.EventLoopFuture<Void> {
        return database.schema("events").delete()
       
    }
    
    
    
}
