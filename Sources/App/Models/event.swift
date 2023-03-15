//
//  event.swift
//  
//
//  Created by Doaa on 13/03/2023.
//

import Fluent
import Vapor
import FluentPostgresDriver

final class Event: Model, Content {

    static let schema = "events"
    
    @ID(key: .id)
    var id: UUID?

    @Field(key: "title")
    var title: String
    
    init() { }
    
    init (id: UUID? = nil, title: String) {
        self.id = id
        self.title = title
    }


}
