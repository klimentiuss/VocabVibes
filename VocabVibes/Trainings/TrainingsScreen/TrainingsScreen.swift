//
//  TrainingsScreen.swift
//  VocabVibes
//
//  Created by Daniil Klimenko on 19.04.2023.
//

import SwiftUI

struct TrainingsScreen: View {
    
    @Environment(\.presentationMode) var presentationMode
    @ObservedObject var viewModel: TrainingsScreenViewModel
    
    var body: some View {
        ZStack(alignment: .top) {
            BackgroundView()
            
            VStack(alignment: viewModel.isMain ? .leading : .center) {
                VStack {
                    viewModel.isMain ?
                    Text("Start training")
                        .foregroundColor(.white)
                        .font(.largeTitle)
                        .bold()
                    :
                    Text("Choose training type:")
                        .foregroundColor(.white)
                        .font(.title)
                }
                .padding(.horizontal)
                
                LazyVGrid(
                    columns: viewModel.isMain ? viewModel.flexibleColumns : viewModel.lagreFixedColumns,
                    spacing: 10
                ) {
                    Section {
                        ForEach(viewModel.trainings, id: \.trainingName) { training in
                            
                            NavigationLink {
                                switch training.trainingName {
                                case "Flash\nCards\n🌅" :
                                    FlashCardView(viewModel: FlashCardViewModel(selectedWordList: $viewModel.selectedWordList))
                                case "Write\nword\n📝":
                                    WriteWord(viewModel: WriteWordViewModel(selectedWordList: $viewModel.selectedWordList))
                                case "Choose\nOne\n💡":
                                    ChooseWord(viewModel: ChooseWordViewModel(selectedWordList: $viewModel.selectedWordList))
                                case "Make\nWord\n🧩":
                                    MakeWord(viewModel: MakeWordViewModel(selectedWordList: $viewModel.selectedWordList))
                                default:
                                    FlashCardView(viewModel: FlashCardViewModel(selectedWordList: $viewModel.selectedWordList))
                                }
                            } label: {
                                ZStack {
                                    Color.lightGrayColor
                                        .frame(
                                            width: viewModel.isMain ? 160 : 100,
                                            height: viewModel.isMain ? 160 : 100)
                                        .cornerRadius(20)
                                    Text(training.trainingName)
                                        .foregroundColor(.white)
                                        .font(viewModel.isMain ? .title : .headline)
                                }
                            }
                        }
                    }
                    .offset(y: -15)
                }
                .padding(.horizontal)

                PickerView(viewModel: viewModel)
                
            }
        }
        .embedNavigationView(with: "HAHAHA")
        .onAppear {
            viewModel.getFirstlist()
        }
    }
}

struct TrainingsScreen_Previews: PreviewProvider {
    static var previews: some View {
        TrainingsScreen(viewModel: TrainingsScreenViewModel(isMain: true))
    }
}
