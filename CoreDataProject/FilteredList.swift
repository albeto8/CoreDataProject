//
//  FilteredList.swift
//  CoreDataProject
//
//  Created by Mario Alberto Barragán Espinosa on 24/11/19.
//  Copyright © 2019 Mario Alberto Barragán Espinosa. All rights reserved.
//

import CoreData
import SwiftUI

enum PredicateType: String {
    case beginsWithCaseSensitive = "BEGINSWITH"
    case beginsWithNoSensitive = "BEGINSWITH[c]"
    case containsCaseSensitive = "CONTAINS"
    case containsCaseInsensitive = "CONTAINS[c]"
}

struct FilteredList<T: NSManagedObject, Content: View>: View {
    var fetchRequest: FetchRequest<T>
    var singers: FetchedResults<T> { fetchRequest.wrappedValue }

    // this is our content closure; we'll call this once for each item in the list
    let content: (T) -> Content

    var body: some View {
        List(singers, id: \.self) { singer in
            self.content(singer)
        }
    }

    init(filterKey: String, filterValue: String, predicateType: PredicateType, sortDescriptors: [NSSortDescriptor], @ViewBuilder content: @escaping (T) -> Content) {
        fetchRequest = FetchRequest<T>(entity: T.entity(), sortDescriptors: sortDescriptors, predicate: NSPredicate(format: "%K \(predicateType.rawValue) %@", filterKey, filterValue))
        self.content = content
    }
}

struct FilteredList_Previews: PreviewProvider {
    static var previews: some View {
        FilteredList(filterKey: "lastName", filterValue: "A", predicateType: .beginsWithCaseSensitive, sortDescriptors: []) { (singer: Singer) in
            Text("\(singer.wrappedFirstName) \(singer.wrappedLastName)")
        }
    }
}
