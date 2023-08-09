//
//  HomeView.swift
//  NodeTaskManager-iOS
//
//  Created by Berkay Dişli on 30.07.2023.
//

import SwiftUI

struct HomeView: View {
    @StateObject private var allTasksViewModel = AllTasksViewModel()
    @State private var searchText = ""
    var body: some View {
        NavigationView {
            List {
                ForEach(searchResults, id:\.id) { task in
                    HStack {
                        Rectangle().fill(getPriorityColor(task: task))
                            .frame(width: 2, height: 30)
                            .padding(.trailing, 4)
                        
                        VStack(alignment: .leading) {
                            Text(task.title)
                                .font(.headline)
                                .fontWeight(.medium)
                            
                            Text(task.details)
                                .font(.caption)
                                .foregroundStyle(.gray)
                        }
                        Spacer()
                        Text(getStatusText(task: task))
                            .font(.caption)
                    }
                    .swipeActions(edge: .leading) {
                        Button {
                            print("DEBUG: TASK status updated to DONE")
                        } label: {
                            Text("Done")
                        }
                        .tint(.green)
                    }
                    .swipeActions(edge: .trailing) {
                        Button {
                            print("DEBUG: TASK should be deleted")
                        } label: {
                            Image(systemName: "trash.fill")
                        }
                        .tint(.red)
                    }
                }
            }
            .navigationTitle("All Tasks")
            .onAppear {
                allTasksViewModel.fetchAllTasks()
            }
            .overlay {
                if allTasksViewModel.isNetworking {
                    ProgressView()
                } else {
                    EmptyView()
                }
            }
        }
        .searchable(text: $searchText, prompt: "Look for a task")
    }
    
    var searchResults: [TaskResponseModel] {
            if searchText.isEmpty {
                return allTasksViewModel.allTasks.sorted {getStatusID(status: $0.status) < getStatusID(status: $1.status)}
            } else {
                let allTaskFiltered = allTasksViewModel.allTasks.sorted {getStatusID(status: $0.status) < getStatusID(status: $1.status)}
                return allTaskFiltered.filter { $0.title.contains(searchText) }
            }
        }
    
    func getPriorityColor(task: TaskResponseModel) -> Color {
        switch task.priority {
        case "low":
            return .green
        case "medium":
            return .yellow
        case "high":
            return .red
        default:
            return .green
        }
    }
    
    func getStatusText(task: TaskResponseModel) -> String {
        switch task.status {
        case "todo":
            return "To-Do"
        case "in-progress":
            return "In Progress"
        case "done":
            return "Done"
        default:
            return ""
        }
    }
    
    func getStatusID(status: String) -> Int {
        switch status {
        case "todo":
            return 0
        case "in-progress":
            return 1
        case "done":
            return 2
        default:
            return -1
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
