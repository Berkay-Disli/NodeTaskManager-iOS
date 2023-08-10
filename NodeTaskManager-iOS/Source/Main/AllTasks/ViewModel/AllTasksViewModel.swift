//
//  AllTasksViewModel.swift
//  NodeTaskManager-iOS
//
//  Created by Berkay Dişli on 9.08.2023.
//

import Foundation

class AllTasksViewModel: ObservableObject {
    @Published var isNetworking: Bool = false
    @Published var operationFailed: Bool = false
    @Published var errorTitle: String = ""
    @Published var errorMessage: String = ""
    @Published var tasksFetched: Bool = false
    @Published var taskCreated: Bool = false
    @Published var allTasks: [TaskResponseModel] = []
    
    func fetchAllTasks() {
        tasksFetched = false
        guard let url = URL(string: Constants.baseApi + Constants.MAIN_TASKS_URL_PATH) else {
            return
        }
        guard let accessToken = UserDefaults.standard.string(forKey: Constants.accessTokenKey) else { return }
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("Bearer \(accessToken)", forHTTPHeaderField: "Authorization")
        
        self.isNetworking = true
        let task = URLSession.shared.dataTask(with: request) { [weak self] (data, response, error) in
            guard let data = data, let httpResponse = response as? HTTPURLResponse, error == nil else {
                return
            }
            
            if httpResponse.statusCode >= 200 && httpResponse.statusCode <= 299 {
                do {
                    let response = try JSONDecoder().decode([TaskResponseModel].self, from: data)
                    DispatchQueue.main.async {
                        self?.allTasks = response
                        self?.tasksFetched = true
                    }
                } catch let error {
                    print(error)
                }
            } else {
                do {
                    let error = try JSONDecoder().decode(AuthErrorResponse.self, from: data)
                    self?.errorTitle = error.title
                    self?.errorMessage = error.message
                    self?.operationFailed = true
                } catch {
                }
            }
            self?.isNetworking = false
        }
        task.resume()
    }
    
    func updateTask(_ task: TaskResponseModel, toStatus: String) {
        guard let url = URL(string: Constants.baseApi + Constants.MAIN_TASKS_URL_PATH + task.id) else {
            return
        }
        guard let accessToken = UserDefaults.standard.string(forKey: Constants.accessTokenKey) else { return }
        
        var request = URLRequest(url: url)
        request.httpMethod = "PUT"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("Bearer \(accessToken)", forHTTPHeaderField: "Authorization")
        
        
        let requestBody: [String: Any] = ["status": toStatus]
        do {
            request.httpBody = try JSONSerialization.data(withJSONObject: requestBody)
        } catch {
            print("DEBUG Error creating request body: \(error)")
            return
        }
        
        self.isNetworking = true
        
        let task = URLSession.shared.dataTask(with: request) { [weak self] (data, response, error) in
            guard let httpResponse = response as? HTTPURLResponse, error == nil else {
                return
            }
            
            if httpResponse.statusCode >= 200 && httpResponse.statusCode <= 299 {
                print("DEBUG UPDATE DONE, FETCHING ALL TASKS")
                self?.fetchAllTasks()
            } else {
                self?.errorTitle = "Failed"
                self?.errorMessage = "Could not update task."
                self?.operationFailed = true
            }
            self?.isNetworking = false
        }
        task.resume()
    }
    
    func deleteTask(task: TaskResponseModel) {
        guard let url = URL(string: Constants.baseApi + Constants.MAIN_TASKS_URL_PATH + task.id) else {
            return
        }
        guard let accessToken = UserDefaults.standard.string(forKey: Constants.accessTokenKey) else { return }
        
        var request = URLRequest(url: url)
        request.httpMethod = "DELETE"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("Bearer \(accessToken)", forHTTPHeaderField: "Authorization")
        
        self.isNetworking = true
        
        let task = URLSession.shared.dataTask(with: request) { [weak self] (data, response, error) in
            guard let httpResponse = response as? HTTPURLResponse, error == nil else {
                return
            }
            
            if httpResponse.statusCode >= 200 && httpResponse.statusCode <= 299 {
                if let index = self?.allTasks.firstIndex(where: { $0.id == task.id }) {
                    self?.allTasks.remove(at: index)
                }
            } else {
                self?.errorTitle = "Failed"
                self?.errorMessage = "Could not delete task."
                self?.operationFailed = true
            }
            self?.isNetworking = false
        }
        task.resume()
    }
    
    func createTask(task: TaskRequestModel) {
        self.taskCreated = false
        guard let url = URL(string: Constants.baseApi + Constants.MAIN_TASKS_URL_PATH) else {
            return
        }
        guard let accessToken = UserDefaults.standard.string(forKey: Constants.accessTokenKey) else { return }
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("Bearer \(accessToken)", forHTTPHeaderField: "Authorization")
        
        do {
            let jsonData = try JSONEncoder().encode(task)
            request.httpBody = jsonData
        } catch {
            print("DEBUG \(error)")
        }
        
        self.isNetworking = true
        
        let task = URLSession.shared.dataTask(with: request) { [weak self] (data, response, error) in
            guard let httpResponse = response as? HTTPURLResponse, error == nil else { return }
            
            if httpResponse.statusCode >= 200 && httpResponse.statusCode <= 299 {
                self?.taskCreated = true
                self?.fetchAllTasks()
            } else {
                self?.errorTitle = "Failed"
                self?.errorMessage = "Could not delete task."
                self?.operationFailed = true
            }
            self?.isNetworking = false
        }
        task.resume()
    }
}
