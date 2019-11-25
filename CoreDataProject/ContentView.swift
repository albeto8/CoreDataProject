//
//  ContentView.swift
//  CoreDataProject
//
//  Created by Mario Alberto Barragán Espinosa on 24/11/19.
//  Copyright © 2019 Mario Alberto Barragán Espinosa. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    
    @Environment(\.managedObjectContext) var moc
    @State var lastNameFilter = "A"
    @State var predicateType: PredicateType = .beginsWithCaseSensitive
    
    let sortDescriptors = [
        NSSortDescriptor(keyPath: \Singer.lastName, ascending: true),
        NSSortDescriptor(keyPath: \Singer.firstName, ascending: true)
    ]
    
    var body: some View {
        VStack {
            // list of matching singers
            FilteredList(filterKey: "lastName", filterValue: lastNameFilter, predicateType: predicateType, sortDescriptors: self.sortDescriptors) { (singer: Singer) in
                Text("\(singer.wrappedFirstName) \(singer.wrappedLastName)")
            }

            Button("Add Examples") {
                let taylor = Singer(context: self.moc)
                taylor.firstName = "taylor"
                taylor.lastName = "swift"

                let ed = Singer(context: self.moc)
                ed.firstName = "ed"
                ed.lastName = "sheeran"

                let adele = Singer(context: self.moc)
                adele.firstName = "adele"
                adele.lastName = "adkins"

                try? self.moc.save()
            }

            Button("Begins With 'A' Case Sensitive") {
                self.lastNameFilter = "A"
                self.predicateType = .beginsWithCaseSensitive
            }
            
            Button("Begins With 'A' NO Case Sensitive") {
                self.lastNameFilter = "A"
                self.predicateType = .beginsWithNoSensitive
            }
            
            Button("Begins With 'S' Case Sensitive") {
                self.lastNameFilter = "S"
                self.predicateType = .beginsWithCaseSensitive
            }
            
            Button("Begins With 'S' NO Case Sensitive") {
                self.lastNameFilter = "S"
                self.predicateType = .beginsWithNoSensitive
            }

        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
