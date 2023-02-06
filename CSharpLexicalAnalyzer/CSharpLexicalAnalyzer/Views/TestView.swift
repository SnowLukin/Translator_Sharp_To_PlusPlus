//
//  TestView.swift
//  CSharpLexicalAnalyzer
//
//  Created by Snow Lukin on 06.02.2023.
//

import SwiftUI

struct TestView: View {
    @StateObject private var viewModel = TestViewModel()
    
    var body: some View {
        VStack {
            sharpCodeView()
            Divider()
            tokenCodeView()
            Spacer()
        }.frame(height: 400)
            .padding()
            .onAppear {
                viewModel.scan(viewModel.sampleCode)
            }
    }
}

struct TestView_Previews: PreviewProvider {
    static var previews: some View {
        TestView()
    }
}

extension TestView {
    private func sharpCodeView() -> some View {
        VStack(spacing: 15) {
            Text("C# code")
                .font(.title2)
                .fontWeight(.semibold)
            Text(viewModel.sampleCode)
                .font(.body)
                .frame(maxWidth: .infinity, alignment: .leading)
        }
    }
    
    private func tokenCodeView() -> some View {
        VStack(spacing: 15) {
            Text("Token codes")
                .font(.title2)
                .fontWeight(.semibold)
            Text(viewModel.outputCodes.joined(separator: " "))
                .font(.body)
                .frame(maxWidth: .infinity, alignment: .leading)
        }
    }
}
