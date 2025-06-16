//
//  ServiceManager.swift
//  DemoTwoSwiftUI
//
//  Created by RajayGoms on 5/29/25.
//

import Foundation

class ServiceManager {
    
    static func getCharacterInformationFromRemoteAPIUsingAsync() async throws -> (CharacterModel) {
        
        guard let url = URL(string: Constants.characterUrl) else { throw NetworkError.urlNotFound }
        
        let (data, response) = try await URLSession.shared.data(from: url)
        
        guard let response = response as? HTTPURLResponse, response.statusCode == 200 else { throw NetworkError.dataNotFound }
        
        do {
            let decoder = JSONDecoder()
            return try decoder.decode(CharacterModel.self, from: data)
        } catch {
            throw NetworkError.decoderError
        }
    }
    
    static func getCharacterInformationFromRemoteAPIUsingCompletion(completion: @escaping(([CharacterModel]?, NetworkError?) -> ())) {
        guard let url = URL(string: Constants.characterUrl) else { return }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data, let response = response else { return }
            let decodedData = try? JSONDecoder().decode([CharacterModel].self, from: data)
            if let decode = decodedData { completion(decode, nil)}
        }.resume()
    }
    
    static func getCharacterInformationFromRemoteAPIUsingResult(completion: @escaping((Result<[CharacterModel], NetworkError>)-> Void)) {
        guard let url = URL(string: Constants.characterUrl) else {
            completion(.failure(NetworkError.urlNotFound))
            return
        }
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data, let response = response else { completion(.failure(.dataNotFound))
                return }
            let decodedData = try? JSONDecoder().decode([CharacterModel].self, from: data)
            if let finalData = decodedData {
                completion(.success(finalData))
            } else {
                completion(.failure(.decoderError))
            }
        }.resume()
    }
    
    static func getStephenKingBooksFromtheRemoteAPIUsingResult(completion: @escaping((Result<BookModel, NetworkError>)-> ())) {
        guard let url = URL(string: Constants.bookApi) else { completion(.failure(.urlNotFound))
        return
        }
        URLSession.shared.dataTask(with: url, completionHandler: { data, response , error in
            guard let data = data, let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                completion(.failure(.dataNotFound))
                return }
            if let decodedData = try? JSONDecoder().decode(BookModel.self, from: data) {
                completion(.success(decodedData))
            } else {
                completion(.failure(.decoderError))
            }
        }).resume()
    }
} //(()->())
