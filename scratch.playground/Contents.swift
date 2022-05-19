import UIKit

var greeting = "Hello, playground"
print(greeting)





// write func travel
/*
 takes closure as argument, returns nothing
 */
func travel(action: (String) -> Void) {
    print("x")
    action("London")
    print("y")
}


// call func travel with the closure as a parameter
// what is inside the {} here is what is called from the action in the func above
// effectively passed this as a func to the func

travel { (place: String) in
    print("I'm going to \(place)")
}


func foo(closure bar: () -> Int) -> Int {
    return bar()
}

print(foo(closure: {return 1}))
print(foo {return 1})

func foo2(bar: () -> Int, baz: (Int) -> Int) -> Int {
    return baz(bar())
}

foo2(bar: {return 1}, baz: {x in return x + 1})

foo2(bar: {return 1}) {x in return x + 1}

foo2 {return 1} baz: {x in return x + 1}
 var x = 3


protocol HasEngine {
    func startEngine()
}
protocol HasTrunk {
    func openTrunk()
}

protocol Car2: HasEngine, HasTrunk {}

struct Car: HasEngine, HasTrunk {
    func startEngine() {
        print("x")
    }
    
    func openTrunk() {
        print("x")
    }
}

class Animal {}

class Dog: Animal {}

class Retriever: Dog {}


var weatherForecast: String = "sunny"
if let forecast = weatherForecast {
    print("The forecast is \(forecast).")
} else {
    print("No forecast available.")
}
