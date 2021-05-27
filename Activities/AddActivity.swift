//
//  AddActivity.swift
//  Activities
//
//  Created by Arkasha Zuev on 27.05.2021.
//

import SwiftUI

struct AddActivity: View {
    @State var title: String = ""
    @State var description: String = ""
    @ObservedObject var activities: Activities
    @Environment(\.presentationMode) var presentation
    
    var body: some View {
        NavigationView {
            Form {
                TextField("Title", text: $title)
                TextField("Description", text: $description)
            }
            .navigationBarTitle("Add new activity")
            .navigationBarItems(trailing: Button("Save", action: {
                activities.items.append(ActivityItem(title: title, description: description))
                presentation.wrappedValue.dismiss()
            }))
        }
    }
}

struct AddActivity_Previews: PreviewProvider {
    static var previews: some View {
        AddActivity(activities: Activities())
    }
}
