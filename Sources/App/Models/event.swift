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

    static let schema = "eventS"
    
    @ID(key: .id)
    var id: UUID?

    @Field(key: "title")
    var title: String
    
    @Field(key: "time")
    var time: Date
    
    init() { }
    
    init (id: UUID? = nil, title: String ,time: Date) {
        self.id = id
        self.title = title
        self.time = time
    }


}
