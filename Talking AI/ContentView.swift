//
//  ContentView.swift
//  Talking AI
//
//  Created by Shubham Deshmukh on 21/06/23.
//

import SwiftUI
import OpenAIKit


class ViewModel : ObservableObject {
//    let apiKey = ChatGPTAPI(apiKey: "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")
//    var apiKey: String {
//        ProcessInfo.processInfo.environment["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"]!
//    }

    var organization: String {
        ProcessInfo.processInfo.environment["OPENAI_ORGANIZATION"]!
    }

    func ApiCall() async {
       
        let urlSession = URLSession(configuration: .default)
        let configuration = Configuration(apiKey: "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")//, organization: organization)
        let openAIClient = OpenAIKit.Client(session: urlSession, configuration: configuration)
        
        do{
            let completion = try await openAIClient.completions.create(
                model: Model.GPT3.davinci,
                prompts: ["Write a haiku"]
            )
            
            print(completion)
            
        } catch {
            print(error.localizedDescription)
        }
        
    }
}

struct ContentView: View {
    
    @StateObject var viewModel = ViewModel()
    
    var body: some View {
        VStack {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundColor(.accentColor)
            Text("Hello, world!")
        }
        .onAppear(){
            Task {
               await viewModel.ApiCall()
            }
        }
        .padding()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
