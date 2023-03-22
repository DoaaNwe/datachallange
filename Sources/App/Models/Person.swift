//
//  File.swift
//  
//
//  Created by Doaa on 21/03/2023.
//

import Fluent
import Vapor
import FluentPostgresDriver

final class Person: Model, Content {

    static let schema = "personS"
    
    @ID(key: .id)
    var id: UUID?

    @Field(key: "name")
    var name: String
    
    @Field(key: "ticket")
    var ticket : String
    
    @Parent(key: "event_id")
    var event_id: Event
    
    init() { }
    
    init (id: UUID? = nil, name: String, ticket: String , event_id: UUID) {
        self.id = id
        self.name = name
        self.ticket = ticket
        self.$event_id.id = event_id
    }


}
