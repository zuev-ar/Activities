//
//  ActivityView.swift
//  Activities
//
//  Created by Arkasha Zuev on 27.05.2021.
//

import SwiftUI

struct ActivityView: View {
    @State var item: ActivityItem
    @ObservedObject var activities: Activities
    @Environment(\.presentationMode) var presentation
    
    var body: some View {
        VStack {
            Form {
                TextField("Title", text: $item.title)
                TextField("Description", text: $item.description)
            }
            
            Button("Save") {
                presentation.wrappedValue.dismiss()
            }
            .font(.title)
            .foregroundColor(Color.blue)
            .padding()
            .overlay(RoundedRectangle(cornerRadius: 20)
                        .stroke(Color.blue, lineWidth: 5))
        }
    }
}

struct ActivityView_Previews: PreviewProvider {
    static var previews: some View {
        let activities = Activities()
        ActivityView(item: activities.items[0], activities: activities)
    }
}
