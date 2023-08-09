//
//  UserManager.swift
//  NodeTaskManager-iOS
//
//  Created by Berkay Dişli on 9.08.2023.
//

import Foundation

class UserManager: ObservableObject {
    @Published var isLoggedIn: Bool = false
    @Published var isNetworking: Bool = false
    @Published var operationFailed: Bool = false
    @Published var errorTitle: String = ""
    @Published var errorMessage: String = ""
    
    init() {
        if let accessToken = UserDefaults.standard.string(forKey: Constants.accessTokenKey) {
            print("ACCESS TOKEN: \(accessToken)")
            // Check if the access token is valid here (e.g., by making an API request)
            getCurrentUser(accessToken: accessToken) { [weak self] result in
                switch result {
                case .success(_):
                    DispatchQueue.main.async {
                        self?.isLoggedIn = true
                    }
                case .failure(let failure):
                    print("DEBUG: Failed inside init func of UserManager!\n\(failure.localizedDescription)")
                }
            }
        }
    }
    
    func register(user: UserModel, completion: @escaping (Result<AuthRegisterResponse, NetworkError>) -> Void) {
        guard let url = URL(string: Constants.baseApi + Constants.REGISTER_URL_PATH) else {
            completion(.failure(.badURL))
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        
        do {
            let jsonData = try JSONEncoder().encode(user)
            request.httpBody = jsonData
        } catch {
            completion(.failure(.unknown))
        }
        
        self.isNetworking = true
        let task = URLSession.shared.dataTask(with: request) { [weak self] (data, response, error) in
            guard let data = data, let httpResponse = response as? HTTPURLResponse, error == nil else {
                completion(.failure(.requestFailed))
                return
            }
            
            
            if httpResponse.statusCode >= 200 && httpResponse.statusCode <= 299 {
                do {
                    let response = try JSONDecoder().decode(AuthRegisterResponse.self, from: data)
                    let userLoginRequest = AuthLoginRequest(email: user.email, password: user.password)
                    self?.login(userLoginRequest: userLoginRequest, completion: { _ in })
                    completion(.success(response))
                } catch {
                    completion(.failure(.unknown))
                }
            } else {
                do {
                    let error = try JSONDecoder().decode(AuthErrorResponse.self, from: data)
                    DispatchQueue.main.async {
                        self?.errorTitle = error.title
                        self?.errorMessage = error.message
                        self?.operationFailed = true
                    }
                    completion(.failure(.requestFailed))
                } catch {
                    completion(.failure(.unknown))
                }
            }
            DispatchQueue.main.async {
                self?.isNetworking = false
            }
        }
        task.resume()
    }
    
    func login(userLoginRequest: AuthLoginRequest, completion: @escaping (Result<Bool, NetworkError>) -> Void) {
        guard let url = URL(string: Constants.baseApi + Constants.LOGIN_URL_PATH) else {
            completion(.failure(.badURL))
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        
        do {
            let jsonData = try JSONEncoder().encode(userLoginRequest)
            request.httpBody = jsonData
        } catch {
            completion(.failure(.unknown))
        }
        
        self.isNetworking = true
        
        let task = URLSession.shared.dataTask(with: request) { [weak self] (data, response, error) in
            guard let data, let httpResponse = response as? HTTPURLResponse, error == nil else {
                completion(.failure(.requestFailed))
                return
            }
            
            if httpResponse.statusCode >= 200 && httpResponse.statusCode <= 299 {
                do {
                    let accessToken = try JSONDecoder().decode(AuthLoginResponse.self, from: data).accessToken
                    UserDefaults.standard.set(accessToken, forKey: Constants.accessTokenKey)
                    DispatchQueue.main.async {
                        self?.isLoggedIn = true
                    }
                    completion(.success(true))
                } catch {
                    completion(.failure(.unknown))
                }
            } else {
                do {
                    let error = try JSONDecoder().decode(AuthErrorResponse.self, from: data)
                    DispatchQueue.main.async {
                        self?.errorTitle = error.title
                        self?.errorMessage = error.message
                        self?.operationFailed = true
                    }
                    completion(.failure(.requestFailed))
                } catch {
                    completion(.failure(.unknown))
                }
            }
            DispatchQueue.main.async {
                self?.isNetworking = false
            }
        }
        
        task.resume()
    }
    
    func getCurrentUser(accessToken: String, completion: @escaping (Result<Bool, NetworkError>) -> Void) {
        guard let url = URL(string: Constants.baseApi + Constants.CURRENT_USER_URL_PATH) else {
            completion(.failure(.badURL))
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("Bearer \(accessToken)", forHTTPHeaderField: "Authorization")
        
        self.isNetworking = true
        
        let task = URLSession.shared.dataTask(with: request) { [weak self] (data, response, error) in
            guard let data = data, error == nil else {
                completion(.failure(.requestFailed))
                print("let task = url session patladı")
                return
            }
            
            do {
                let user = try JSONDecoder().decode(AuthCurrentUserResponse.self, from: data)
                completion(.success(true))
                print("DEBUG: current user email is \(user.email)")
            } catch let decodingError {
                completion(.failure(.unknown))
                print("Decoding error: \(decodingError)")
            }
            
            DispatchQueue.main.async {
                self?.isNetworking = false
            }
        }
        
        task.resume()
    }

    
    func logoutUser() {
        UserDefaults.standard.removeObject(forKey: Constants.accessTokenKey)
        isLoggedIn = false
    }
}

enum NetworkError: Error {
    case badURL, requestFailed, unknown
}
