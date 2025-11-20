# SwiftUI-SystemTest
SwiftUI-SystemTest  

~~~swift
import SwiftUI

struct ContentView: View {
    
    let books: [Book] = [Book(auther: "John", title: "abc"), Book(auther: "Meheboob", title: "xyz"), Book(auther: "Goo", title: "ggh")]
    
    @State var paths: [Book] = []
    
    var body: some View {
        NavigationStack(path: $paths) {
            List(books , id:\.self) { book in
                HStack{
                    Text(book.auther)
                    Spacer()
                    Text(book.title)
                }
                .onTapGesture {
                    // selectedAuther = book
                    paths.append(book)
                }
            }
            .navigationTitle("First View")
            .navigationDestination(for: Book.self, destination: { newBook in
                DetailView(title: newBook.title, author: newBook.auther)
            })
        }
    }
}

struct DetailView: View {
    var title: String
    var author: String
    var body: some View {
        VStack {
            Text(title)
            Text(author)
        }
    }
}


struct Book: Hashable {
    let auther: String
    let title: String
}

~~~
