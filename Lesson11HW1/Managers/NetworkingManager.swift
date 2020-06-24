//
//  NetworkingManager.swift
//  Lesson11HW1
//
//  Created by vaksakalov on 24.06.2020.
//  Copyright © 2020 Vladimir. All rights reserved.
//

import Alamofire

class NetworkingManager {
    
    static let shared = NetworkingManager()
    
    private init() {}

    func alamofireFetchDataFromDictionaryApi(with word: String, language: String, completion: @escaping (String)->()) {
        
        let jsonUrl = "https://api.dictionaryapi.dev/api/v1/entries/\(language)/\(word.trimmingCharacters(in: [" "]))"
        let urlString = jsonUrl.addingPercentEncoding(withAllowedCharacters: NSCharacterSet.urlQueryAllowed)!              // Для поддержки кириллицы в запросах
        
        AF.request(urlString)
            .validate()
            .responseJSON { response in
                switch response.result {
                case .success(let value):
                    print(value)
                    let wordInDictionary = WordInDictionary.getWords(from: value) ?? []
                    completion("\(wordInDictionary.first?.showResult() ?? "Nothing")")
                case .failure(let error):
                    completion(error.localizedDescription)
                }
        }
    }

}
