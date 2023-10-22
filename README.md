### Language Identification

- Determining the language of the text
  ex) Bonjour => French

### Named Entity Recognition

- Identifying elements of text like people, places and organizations

"John is visiting San Francisco in March 2020. He will be visiting Barnes and Nobles"

John => Personal Name

San Francisco => Place Name

Barnes and Nobles => Orginization Name

### Sentiment Analysis

- Determining the positive or negative sentiment in text
- Custom Text Classifiers

### Identify Language

```swift
import UIKit
import NaturalLanguage
import CoreML

private func predictLanguage(text: String) -> String? {

    let locale = Locale(identifier: "en")
    let recognizer = NLLanguageRecognizer()

    recognizer.processString(text)

    guard let language = recognizer.dominantLanguage else {
        return "Unable to predict language"
    }

    print(language)

    return locale.localizedString(forLanguageCode: language.rawValue)

}




["Hello World", "Holla Comos Estas","5%%5","ہیلو آپ کیسے ہیں؟","Hello Holla"].forEach {
    if let prediction = predictLanguage(text: $0) {
        print(prediction)
    }
}
```

### Named Entity Recognition

```swift
import UIKit
import NaturalLanguage
import CoreML

private func printNamedEntities(text: String) {

    let tagger = NSLinguisticTagger(tagSchemes: [.nameType], options: 0)
    tagger.string = text

    let range = NSRange(location: 0, length: text.count)

    let options: NSLinguisticTagger.Options = [.omitPunctuation, .omitWhitespace, .joinNames]

    let tags: [NSLinguisticTag] = [.personalName, .placeName, .organizationName]

    tagger.enumerateTags(in: range, unit: .word, scheme: .nameType, options: options) { tag, tokenRange, stop in

        if let tag = tag, tags.contains(tag) {
            let name = (text as NSString).substring(with: tokenRange)
            print("\(name) is a \(tag.rawValue)")
        }

    }

}


["My name is John and I love to visit Australia", "My name is Mary and I work for Google","Yesterday, I went to Costa Rica and also met with James who works at Exxon", "Holla Comos Estas"].forEach { text in

    printNamedEntities(text: text)

}

```

### Predict Language

```
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

```
