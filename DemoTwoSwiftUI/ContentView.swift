//
//  ContentView.swift
//  DemoTwoSwiftUI
//
//  Created by RajayGoms on 5/28/25.
//

import SwiftUI

struct ContentView: View {
    @State var isShowingSettings: Bool = false
    @StateObject var vm = ViewModel()
            var body: some View {
                TabView {
                    Group {
                        CharacterView()
                            .tabItem {
                            Label("Character", systemImage: "movieclapper")
                            }
                        
                        BookView()
                            .tabItem {
                                Label("Books", systemImage: "books.vertical.fill")
                            }
                    }
                }
            }
}


#Preview {
    ContentView()
}

struct CharacterView: View {
    @StateObject var vm = ViewModel()
    @State var searchText = ""
    var body: some View {
        NavigationStack {
            VStack {
                List {
                    ForEach(searchResult, id: \.ids) { charData in
                        HStack {
                            AsyncImage(url: URL(string: charData.imageUrl ?? "")) { image in
                                image
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                            } placeholder: {
                                ProgressView()
                            }
                            .frame(width: 70, height: 100)
                            VStack(alignment:.leading) {
                                Text("Film: \(charData.name ?? "")").font(.title3).tint(.red).fontWeight(.bold)
                                Text("CreatedAt:\(charData.createdAt ?? "")")
                                Text("URL:\(charData.url ?? "")")
                            }
                        }
                    }
                }
                if vm.isLoading {
                    ProgressView()
                }
            }.navigationTitle("Disney Characters")
        }
        //.searchable(text: $searchText)
        .searchable(text: $searchText, placement: .navigationBarDrawer(displayMode: .always), prompt: "Search Activities")

        .task {
            do {
                await vm.fetchCharacterInformation()
            } catch {
                print( "error")
            }
        }
        
    }
    
    var searchResult : [CharacterDatum] {
        if searchText.isEmpty {
            return vm.characterData?.data ?? []
        } else {
            return vm.characterData?.data?.filter {$0.name == searchText } ?? []
        }
    }

}

struct BookView: View {
    @StateObject var vm = ViewModel()
    var idName: String = ""
    var body: some View {
        NavigationStack {
            VStack {
                List {
                    ForEach(vm.bookData?.data ?? [], id: \.ids) { book in
                        VStack {
                            HStack {
                                Image("book").resizable().aspectRatio(contentMode: .fit).frame(width: 80, height: 100)
                                VStack(alignment: .leading) {
                                    Text(book.title ?? "").font(.title3).foregroundColor(.red).fontWeight(.bold)
                                    Text("Publisher: \(book.publisher ?? "")")
                                    Text("Pages: \(book.pages ?? 0)")
                                    Text("Year: \(book.year ?? 0)")
                                    Text("ISBN: \(book.isbn ?? "")")
                                    NavigationLink("Id:book.ids", destination: BookDetailView())
                                }
                            }
                        }
                    }
                }
            } .task {
                vm.fetchStephenKingBookInformation()
            }
        }
    }
}

struct BookDetailView: View {
    var body: some View {
        /*@START_MENU_TOKEN@*//*@PLACEHOLDER=Hello, world!@*/Text("Hello, world!")/*@END_MENU_TOKEN@*/
    }
}
