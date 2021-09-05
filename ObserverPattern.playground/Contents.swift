protocol Publisher {
    func subscribe(subscriber: Subscriber)
    func unsubscribe(subscriber: Subscriber)
    func notify(message: String)
}

protocol Subscriber {
    var suscriberIndex: Int { get set }
    func update(message: String)
}

class NewspaperPublisher: Publisher {
    var subscribers = [Subscriber]()
    func subscribe(subscriber: Subscriber) {
        var subscriberInstance = subscriber
        subscriberInstance.suscriberIndex = subscribers.count
        subscribers.append(subscriberInstance)
    }
    
    func unsubscribe(subscriber: Subscriber) {
        subscribers.remove(at: subscriber.suscriberIndex)
    }
    
    func notify(message: String) {
        for eachSubscriber in subscribers {
            eachSubscriber.update(message: message)
        }
    }
}

class Reader: Subscriber {
    var suscriberIndex: Int = 0
    let name: String
    init(name: String) {
        self.name = name
    }
    
    func update(message: String) {
        print("\(name) received: \(message)")
    }
}

class NewspaperStore: Subscriber {
    var suscriberIndex: Int = 0
    let location: String
    init(location: String) {
        self.location = location
    }
    
    func update(message: String) {
        print("\(location) newspaper stand received: \(message)")
    }
}


let publisher = NewspaperPublisher()
let david = Reader(name: "David")
let james  = Reader(name: "James")
let supermarket  = NewspaperStore(location: "Railway station")
let bookshop  = NewspaperStore(location: "Canteen")

publisher.subscribe(subscriber: david)
publisher.subscribe(subscriber: james)
publisher.subscribe(subscriber: supermarket)
publisher.subscribe(subscriber: bookshop)
publisher.unsubscribe(subscriber: james)
publisher.notify(message: "Published newspaper")

