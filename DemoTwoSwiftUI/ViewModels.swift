//
//  ArtModule.swift
//  DemoTwoSwiftUI
//
//  Created by RajayGoms on 5/28/25.
//

import Foundation

enum NetworkError: LocalizedError {
    case urlNotFound
    case dataNotFound
    case decoderError
    case customError(error: String)
}


@MainActor
class ViewModel: ObservableObject {
    @Published var characterData: CharacterModel?
    @Published var characterData2: [CharacterModel]?
    @Published var isLoading: Bool = false
    @Published var customError: NetworkError?
    @Published var bookData: BookModel?
    
    init() {
        characterData = nil
    }
    
    func fetchCharacterInformation() async {
        self.isLoading = true
        do {
            self.characterData = try await ServiceManager.getCharacterInformationFromRemoteAPIUsingAsync()
            self.isLoading = false
        } catch {
            self.customError = NetworkError.customError(error: "Character Data fetching error in viewmodel")
        }
    }
    
    func fetchStephenKingBookInformation(){
        ServiceManager.getStephenKingBooksFromtheRemoteAPIUsingResult { result in
            switch result {
            case .success(let bookdata):
                DispatchQueue.main.async {
                    self.bookData = bookdata
                    print("BOOK SUCCESS")
                }
            case .failure(let error):
                switch error {
                case .urlNotFound: print("URL ERROR")
                case .dataNotFound: print("DATA ERROR")
                case .decoderError: print("DECODER ERROR")
                case .customError(error: let error):
                    print("OTHER ERROR: \(error)")
                }
            }
        }
    }
}
