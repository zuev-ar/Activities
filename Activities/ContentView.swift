//
//  ContentView.swift
//  Activities
//
//  Created by Arkasha Zuev on 27.05.2021.
//

import SwiftUI

struct ActivityItem: Identifiable, Codable {
    var id = UUID()
    var title: String
    var description: String
}

class Activities: ObservableObject {
    @Published var items = [ActivityItem]() {
        didSet {
            let encoder = JSONEncoder()
            if let encoded = try? encoder.encode(items) {
                UserDefaults.standard.setValue(encoded, forKey: "Items")
            }
        }
    }
    
    init() {
        if let items = UserDefaults.standard.data(forKey: "Items") {
            let decoder = JSONDecoder()
            if let decoded = try? decoder.decode([ActivityItem].self, from: items) {
                self.items = decoded
            }
        } else {
            self.items = []
        }
    }
}

struct ContentView: View {
    @State var showAddActivity = false
    @ObservedObject var activities = Activities()
    
    var body: some View {
        NavigationView {
            List {
                ForEach(activities.items) { item in
                    Text(item.title)
                        .font(.title2)
                }
                .onDelete(perform: removeItem)
            }
            .navigationBarTitle("Activities")
            .navigationBarItems(leading: EditButton(), trailing: Button(action: {
                showAddActivity.toggle()
            }, label: {
                Image(systemName: "plus")
            }))
        }
        .sheet(isPresented: $showAddActivity) {
            AddActivity(activities: activities)
        }
    }
    
    func removeItem(at offsets: IndexSet) {
        activities.items.remove(atOffsets: offsets)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
