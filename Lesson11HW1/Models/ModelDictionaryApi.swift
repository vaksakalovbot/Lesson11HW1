//
//  ModelDictionaryApi.swift
//  Lesson11HW1
//
//  Created by vaksakalov on 24.06.2020.
//  Copyright © 2020 Vladimir. All rights reserved.
//

struct WordInDictionary: Decodable {
    let word: String?
    let phonetic: String?
    let origin: String?
    let meaning: Meaning?
    
    init(dictWord: [String: Any]) {
        word = dictWord["word"] as? String
        phonetic = dictWord["phonetic"] as? String
        origin = dictWord["origin"] as? String
        meaning = Meaning(dictMeaning: dictWord["meaning"] as! [String : Any])
    }
    
    static func getWords(from value: Any) -> [WordInDictionary]? {
        guard let value = value as? [[String: Any]] else { return nil }
        return value.compactMap { WordInDictionary(dictWord: $0) }
    }

    // Здесь такой сложный алгоритм формирования текстовой строки,
    // так как для разных слов структура json не стабильна и многие ключи могут отсутствовать
    func showResult() -> String {
        var resultString = ""
        if let word = word {
            resultString += "Word: \(word)\n"
        }
        if let phonetic = phonetic {
            resultString += "\nPhonetic: \(phonetic)\n"
        }
        if let origin = origin {
            resultString += "\nOrigin: \(origin)\n"
        }
        if let meaning = meaning {
            resultString += "\nMeaning:\n\(meaning.showResult())\n"
        }
        return resultString
    }
}

struct Meaning: Decodable {
    let noun: [Example]?
    let adjective: [Example]?
    let adverb: [Example]?
    let intransitiveVerb: [Example]?
    let exclamation: [Example]?
    let kindRuOne: [Example]?
    let kindRuTwo: [Example]?
    let kindRuThree: [Example]?


    init(dictMeaning: [String: Any]) {
        noun = Example.getExamples(from: dictMeaning["noun"])
        adjective = Example.getExamples(from: dictMeaning["adjective"])
        adverb = Example.getExamples(from: dictMeaning["adverb"])
        intransitiveVerb = Example.getExamples(from: dictMeaning["intransitive verb"])
        exclamation = Example.getExamples(from: dictMeaning["exclamation"])
        kindRuOne = Example.getExamples(from: dictMeaning["Женский род"])
        kindRuTwo = Example.getExamples(from: dictMeaning["Мужской род"])
        kindRuThree = Example.getExamples(from: dictMeaning["Средний род"])
    }
        
    // Здесь такой сложный алгоритм формирования текстовой строки,
    // так как для разных слов структура json не стабильна и многие ключи могут отсутствовать
    func showResult() -> String {
        var resultString = ""
        if let noun = noun {
            resultString += "\nNuon:"
            for example in noun {
                resultString += "\n\(example.showResult())"
            }
        }
        if let adjective = adjective {
            resultString += "\nAdjective:"
            for example in adjective {
                resultString += "\n\(example.showResult())"
            }
        }
        if let adverb = adverb {
            resultString += "\nAdverb:"
            for example in adverb {
                resultString += "\n\(example.showResult())"
            }
        }
        if let intransitiveVerb = intransitiveVerb {
            resultString += "\nIntransitive verb:"
            for example in intransitiveVerb {
                resultString += "\n\(example.showResult())"
            }
        }
        if let exclamation = exclamation {
            resultString += "\nExclamation:"
            for example in exclamation {
                resultString += "\n\(example.showResult())"
            }
        }
        if let kindRuOne = kindRuOne {
            resultString += "\nЖенский род:"
            for example in kindRuOne {
                resultString += "\n\(example.showResult())"
            }
        }
        if let kindRuTwo = kindRuTwo {
            resultString += "\nМужской род:"
            for example in kindRuTwo {
                resultString += "\n\(example.showResult())"
            }
        }
        if let kindRuThree = kindRuThree {
            resultString += "\nСредний род:"
            for example in kindRuThree {
                resultString += "\n\(example.showResult())"
            }
        }
        return resultString
    }
}

struct Example: Decodable {
    let definition: String?
    let example: String?
    let synonyms: [String]?
    let antonyms: [String]?
    
    init(dictExample: [String: Any]) {
        definition = dictExample["definition"] as? String
        example = dictExample["example"] as? String
        synonyms = dictExample["synonyms"] as? [String]
        antonyms = dictExample["antonyms"] as? [String]
    }
    
    static func getExamples(from value: Any?) -> [Example]? {
        guard let value = value as? [[String: Any]] else { return nil }
        return value.compactMap { Example(dictExample: $0) }
    }

    // Здесь такой сложный алгоритм формирования текстовой строки,
    // так как для разных слов структура json не стабильна и многие ключи могут отсутствовать
    func showResult() -> String {
        var resultString = ""
        if let definition = definition {
            resultString += "Definition: \(definition)\n"
        }
        if let example = example {
            if example.count > 0 {
                resultString += "\nExample: \(example)\n"
            }
        }
        if let synonyms = synonyms {
            if synonyms.count > 0 {
                resultString += "\nSynonyms:"
                for item in synonyms {
                    resultString += "\n\(item)"
                }
            }
        }
        if let antonyms = antonyms {
            if antonyms.count > 0 {
                resultString += "\nAntonyms:"
                for item in antonyms {
                    resultString += "\n\(item)"
                }
            }
        }
        return resultString
    }
}

