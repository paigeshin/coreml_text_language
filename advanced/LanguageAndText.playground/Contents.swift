import UIKit
import NaturalLanguage
import CoreML

private func predictLanguage(text: String) -> String? {
    let tagger = NSLinguisticTagger(tagSchemes: [.language], options: 0)
    tagger.string = text
    guard let language = tagger.dominantLanguage else { return "Unknown language"}
    let locale = NSLocale(localeIdentifier: "en")
    return locale.localizedString(forLanguageCode: language)
}


["My name is John and I love to visit Australia", "My name is Mary and I work for Google","Yesterday, I went to Costa Rica and also met with James who works at Exxon", "Holla Comos Estas"].forEach { text in
        
        if let language = predictLanguage(text: text) {
            print(language)
        }
    
    
}
