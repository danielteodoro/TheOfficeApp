//
//  RandomQuoteSwiftUIView.swift
//  TheOfficeApp
//
//  Created by Daniel Teodoro on 23/11/21.
//

import SwiftUI

struct RandomQuoteSwiftUIView: View {
    @ObservedObject var viewModel: RandomQuoteViewModel
    
    var body: some View {
        ZStack {
            VStack (alignment: .center, spacing: 16) {
                Spacer().frame(height: 16)
                Text("Random Quote").font(.title)
                Spacer().frame(height: 32)
                Text(viewModel.content ?? "").onAppear(perform: fetch)
                    .font(.system(size: 24, weight: .regular, design: .default))
                    .multilineTextAlignment(.leading)
                    .padding(16)
                HStack(alignment: .center) {
                    Text(viewModel.characterFullName ?? "").onAppear(perform: fetch)
                        .font(.system(size: 16, weight: .medium, design: .default))
                        .padding(16)
                    Spacer()
                }
                Spacer()
                Button("Get a new quote", action: fetch)
                    .padding(16)
            }.onAppear(perform: fetch)
            if viewModel.isLoading {
                ZStack {
                    Color(.gray)
                        .opacity(0.5)
                        .ignoresSafeArea()
                    ProgressView()
                        .progressViewStyle(CircularProgressViewStyle(tint: .gray))
                        .scaleEffect(2)
                }
            }
        }
    }
    
    func fetch() {
        viewModel.loadRandomQuote()
    }
}

struct RandomQuoteSwiftUIView_Previews: PreviewProvider {
    static var previews: some View {
        let view = RandomQuoteSwiftUIView(viewModel: RandomQuoteViewModel())
        view.viewModel.viewDelegate = view
        return view
    }
}

extension RandomQuoteSwiftUIView: RandomQuoteViewDelegate {
    func didLoadQuote() {
        print("didLoadQuote")
    }
    
    func errorOnLoadingQuote(error: Error) {
        print("error")
    }
    
    func showLoading(_ show: Bool) {
        print("test loading")
    }
}
