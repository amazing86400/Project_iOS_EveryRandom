//
//  ContentView.swift
//  EveryRandom
//
//  Created by KIBEOM SHIN on 4/16/24.
//

import SwiftUI

struct ContentView: View {
    enum pickList: String, CaseIterable, Identifiable {
        case king, eat, you, pick
        
        var id: Self { self }
    }
    
    // MARK: 변수 초기화
    @State private var names: [String] = []
    @State private var selectedPick = pickList.king
    
    @State private var inputName = ""
    @State private var randomName = ""
    @State private var animationCount = 1
    
    @State private var showAlert = false
    @State private var showResultView = false
    
    
    var body: some View {
        ZStack {
            VStack {
                // 상단 로고
                VStack {
                    Image(systemName: "gamecontroller.fill")
                        .font(.title)
                        .bold()
                        .foregroundStyle(.gameLogo)
                        .padding(10)
                    Text("모두의 랜덤 게임")
                        .font(.title2)
                        .bold()
                        .foregroundStyle(.title)
                }
                .padding()
                
                // 게임 종목
                Picker("Flavor", selection: $selectedPick) {
                    Text("오늘의 주인공").tag(pickList.king)
                    Text("뭐먹지").tag(pickList.eat)
                    Text("너로 정했다").tag(pickList.you)
                    Text("걸려들었군").tag(pickList.pick)
                }
                .pickerStyle(.menu)
                .padding()
                
                // 리스트
                List {
                    ForEach(names, id: \.self) { name in
                        Text(name)
                    }
                    .onDelete(perform: delete)
                }
                .clipShape(RoundedRectangle(cornerRadius: 10))
                
                // 이름 입력
                TextField("이름을 입력해 주세요.", text: $inputName)
                    .onSubmit {
                        if !inputName.isEmpty && !names.contains(inputName) {
                            names.append(inputName)
                            inputName = ""
                        } else {
                            showAlert = true
                        }
                    }
                    .alert(isPresented: $showAlert) {
                        Alert(
                            title: Text("경고"),
                            message: Text(inputName.isEmpty ? "이름을 입력하세요." : names.contains(inputName) ? "이미 똑같은 이름이 있어요." : "이름을 다시 입력해 주세요."),
                            dismissButton: .default(Text("확인"))
                        )
                    }
                    .padding(.bottom, 30)
                    .textFieldStyle(.roundedBorder)
                    .autocorrectionDisabled()
                
                // 뽑기 버튼
                Button("랜덤 뽑기") {
                    if let randomValue = names.randomElement() {
                        randomName = randomValue
                        showResultView = true
                        names = []
                    }
                }
                .padding()
                .foregroundStyle(.white)
                .background(.pick, in: RoundedRectangle(cornerRadius: 10))
            }
            .padding()
            
            // 랜덤 뽑기 버튼 클릭 후 실행
            if showResultView {
                Color.black.opacity(0.4).edgesIgnoringSafeArea(.all)
                ResultView(showResultView: $showResultView, animationCount: $animationCount, winner: randomName)
            }
        }
    }
    
    // MARK: List 이름 제거 함수
    func delete(at offsets: IndexSet) {
        names.remove(atOffsets: offsets)
    }
}

#Preview {
    ContentView()
}
