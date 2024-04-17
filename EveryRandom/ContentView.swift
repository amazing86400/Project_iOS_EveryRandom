//
//  ContentView.swift
//  EveryRandom
//
//  Created by KIBEOM SHIN on 4/16/24.
//

import SwiftUI

struct ContentView: View {
    enum Flavor: String, CaseIterable, Identifiable {
        case king, eat, you, pick
        
        var id: Self { self }
    }
    
    // MARK: 변수 초기화
    @State private var names: [String] = []
    @State private var selectedFlavor = Flavor.king
    @State private var inputedName = ""
    @State private var showAlert = false
    @State private var showAlert2 = false
    @State private var result = ""
    
    var body: some View {
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
            Picker("Flavor", selection: $selectedFlavor) {
                Text("오늘의 주인공").tag(Flavor.king)
                Text("뭐먹지").tag(Flavor.eat)
                Text("너로 정했다").tag(Flavor.you)
                Text("걸려들었군").tag(Flavor.pick)
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
            TextField("이름을 입력해 주세요.", text: $inputedName)
                .onSubmit {
                    if !inputedName.isEmpty && !names.contains(inputedName) {
                        names.append(inputedName)
                        inputedName = ""
                    } else {
                        showAlert = true
                    }
                }
                .alert(isPresented: $showAlert) {
                    Alert(
                        title: Text("경고"),
                        message: Text(inputedName.isEmpty ? "이름을 입력하세요." : names.contains(inputedName) ? "이미 똑같은 이름이 있어요." : "이름을 다시 입력해 주세요."),
                        dismissButton: .default(Text("확인"))
                    )
                }
                .padding(.bottom, 30)
            
            // 뽑기 버튼
            Button("랜덤 뽑기") {
                if let randomValue = names.randomElement() {
                    result = randomValue
                    showAlert2 = true
                    names = []
                }
            }
            .alert(isPresented: $showAlert2) {
                Alert(title: Text("ㅋㅋㅋㅋㅋ"),
                      message: Text(result),
                      dismissButton: .default(Text("확인")))
            }
            .padding()
            .foregroundStyle(.white)
            .background(.pick, in: RoundedRectangle(cornerRadius: 10))
        }
        .padding()
    }
    
    // MARK: List 이름 제거 함수
    func delete(at offsets: IndexSet) {
        names.remove(atOffsets: offsets)
    }
}

#Preview {
    ContentView()
}
