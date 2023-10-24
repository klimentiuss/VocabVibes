//
//  TrainingsScreen.swift
//  VocabVibes
//
//  Created by Daniil Klimenko on 19.04.2023.
//

import SwiftUI

struct TrainingsScreen: View {
    
    @Environment(\.presentationMode) var presentationMode
    @StateObject var viewModel: TrainingsScreenViewModel
    
    var body: some View {
        ZStack(alignment: .top) {
            BackgroundView()
            
            VStack(alignment:.leading) {
                //MARK: - Header
                VStack {
                    Text("keyStartTraining".localized)
                        .foregroundColor(Color.lightWhite)
                        .font(detectedSmallScreen(isWidthCheck: false) ? .title : .largeTitle)
                        .bold()
                }
                .padding(.top, 10)
                .padding(.leading, 20)
                
                //MARK: - Grid with trainings
                LazyVGrid(
                    columns: viewModel.lagreFixedColumns,
                    spacing: 10
                ) {
                    Section {
                        ForEach(viewModel.trainings, id: \.trainingName) { training in
                            
                            NavigationLink {
                                switch training.trainingName {
                                case "keyBigFlashCards".localized :
                                    FlashCardView(viewModel: FlashCardViewModel(selectedWordList: $viewModel.selectedWordList))
                                case "keyBigWriteWords".localized:
                                    WriteWord(viewModel: WriteWordViewModel(selectedWordList: $viewModel.selectedWordList))
                                case "keyBigChooseOne".localized:
                                    ChooseWord(viewModel: ChooseWordViewModel(selectedWordList: $viewModel.selectedWordList))
                                case "keyBigMakeWord".localized:
                                    MakeWord(viewModel: MakeWordViewModel(selectedWordList: $viewModel.selectedWordList))
                                default:
                                    FlashCardView(viewModel: FlashCardViewModel(selectedWordList: $viewModel.selectedWordList))
                                }
                            } label: {
                                ZStack {
                                    Rectangle()
                                        .foregroundColor(training.color)
                                        .frame(
                                            width: 175,
                                            height: 175)
                                        .cornerRadius(20)
                                    VStack {
                                        Image(training.image)
                                            .resizable()
                                            .frame(width: 40, height: 40)
                                            
                                        Text(training.trainingName)
                                            .foregroundColor(Color.coalBlack)
                                            .font(.title2)
                                            .bold()
                                    }
                                   
                                }
                            }
                        }
                    }
                    .offset(y: -15)
                }
                .padding(.horizontal)
                //MARK: - Picker group for training
                PickerView(viewModel: viewModel)
                
            }
        }
        .embedNavigationView(with: "Memrix")
        .onAppear {
            viewModel.getFirstlist()
        }
    }
}

struct TrainingsScreen_Previews: PreviewProvider {
    static var previews: some View {
        TrainingsScreen(viewModel: TrainingsScreenViewModel())
    }
}
