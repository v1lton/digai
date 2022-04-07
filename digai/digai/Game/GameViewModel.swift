//
//  GameViewModel.swift
//  digai
//
//  Created by Wilton Ramos on 31/03/22.
//

class GameViewModel {
    
    // MARK: - PRIVATE PROPERTIES
    
    private var songTitles: [String?] = []
    private var numberOfItens: Int = 10
    private var index: Int = 0
    
    // MARK: - INITIALIZER
    
    init() {
        songTitles = [String?](repeating: nil, count: numberOfItens)
        songTitles[1] = "SentaDona"
        songTitles[2] = "Melhor sozinha"
        songTitles[3] = "Envolver"
    }
    
    // MARK: PUBLIC PROPERTIES
    
    public func getSongTitles() -> [String?] {
        return songTitles
    }
    
    public func getSongTitle(at index: Int) -> String? {
        return songTitles[index]
    }
    
    public func getNumberOfItens() -> Int {
        return numberOfItens
    }
    
    public func getIndex() -> Int {
        return index
    }
    
    public func getTextFieldPlaceHolder() -> String {
        return "E o nome da música é..."
    }
    
    public func updateSongTitle(at index: Int, with songTitle: String?) {
        self.songTitles[index] = songTitle
    }
    
    public func updateIndex(_ index: Int) {
        self.index = index
    }
}
