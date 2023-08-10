//
//  CreateTaskView.swift
//  NodeTaskManager-iOS
//
//  Created by Berkay Dişli on 10.08.2023.
//

import SwiftUI

struct CreateTaskView: View {
    @Environment(\.dismiss) var dismiss
    @Binding var title: String
    @Binding var details: String

    @State private var selectedStatus: TaskStatusModel = .todo
    @State private var selectedPriority: TaskPriorityModel = .low
    
    @ObservedObject var allTasksViewModel: AllTasksViewModel
    
    var body: some View {
        NavigationView {
            VStack {
                VStack {
                    TextField("Write a task name", text: $title)
                        .font(.largeTitle)
                    
                    TextField("Details", text: $details)
                }
                
                VStack(spacing: 12) {
                    VStack {
                        Text("Status")
                            .font(.caption)
                            .foregroundStyle(.black)
                            .frame(maxWidth: .infinity, alignment: .leading)
                        Picker("Status", selection: $selectedStatus) {
                            ForEach(TaskStatusModel.allCases, id: \.self) { status in
                                Text(status.title).tag(status)
                            }
                        }
                        .pickerStyle(.segmented)
                    }
                    
                    VStack {
                        Text("Priority")
                            .font(.caption)
                            .foregroundStyle(.black)
                            .frame(maxWidth: .infinity, alignment: .leading)
                        Picker("Priority", selection: $selectedPriority) {
                            ForEach(TaskPriorityModel.allCases, id: \.self) { priority in
                                Text(priority.title).tag(priority)
                            }
                        }
                        .pickerStyle(.segmented)
                    }
                }
                .padding(.vertical, 12)
                
                Button(action: {
                    let task = TaskRequestModel(title: title, details: details, priority: selectedPriority.rawValue, status: selectedStatus.serviceTitle)
                    allTasksViewModel.createTask(task: task)
                }, label: {
                    Text("Create")
                        .padding()
                })
                
                Spacer()
            }
            .onChange(of: allTasksViewModel.taskCreated, perform: { newValue in
                if newValue {
                    dismiss()
                }
            })
            .padding(.horizontal)
            .navigationTitle("Create a task")
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}

#Preview {
    HomeView()
}
