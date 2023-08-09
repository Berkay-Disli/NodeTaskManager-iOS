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
    
    @Published var allTasks: [TaskResponseModel] = []
    
    func fetchAllTasks() {
        guard let url = URL(string: Constants.baseApi + Constants.GET_ALL_TASKS_URL_PATH) else {
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
                    }
                } catch {
                    print("PATLADIK 1")
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
}
