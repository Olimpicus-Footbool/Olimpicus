//
//  GameFeature.swift
//  OlimpicFind
//
//  Created by Developer on 02.12.2022.
//
import UserDefaultsStandard
import UIKit

final class GameFeature: BaseFeatureService<GameFeature> {
    
    // MARK: - Public
    public var gameState         : GameState = .Start
    public var currentOpenCell   = [GameCollectionCell]()
    public var allOpenCell       = [GameCollectionCell]()
    public var coincidencesCount = 0
    public var gameType          = GameType.New
    public var updateScoreAction : Closure<Int>?
    public var winAction         : ClosureEmpty?
    public var collectionView    : UICollectionView?
    
    public var currentScore: Int = {
        var score: Int? = (UserDefaultsStandard.shared.get(key: .score))
        score = (score == nil) ? 500 : score!
        return score!
    }()
    
    public var muteImage: UIImage = #imageLiteral(resourceName: "soundONButton")
    
    public var arrayImages: [UIImage]! {
        get {
            var oneArray = CardGame.allCases.compactMap { UIImage(named: $0.rawValue) }
            let twoArray = CardGame.allCases.compactMap { UIImage(named: $0.rawValue) }
            oneArray.append(contentsOf: twoArray)
            oneArray.append(UIImage(named: CardGame.allCases[0].rawValue)!)
            oneArray.append(UIImage(named: CardGame.allCases[0].rawValue)!)
            return oneArray.shuffled()
        }
    }
    
    override func currentService() -> GameFeature? {
        return self
    }
    // MARK: - Private
   
    
    public func show(cell: GameCollectionCell) {
       
        switch (cell.viewProperties?.cellState, gameState) {
                //Нет не одной открытой ячейки открываем первую
            case (.Close, .Start):
                UIView.transition(
                    from: cell.fonView,
                    to: cell.iconView,
                    duration: 0.5,
                    options: [.curveEaseInOut,
                              .transitionFlipFromRight,
                              .showHideTransitionViews]
                )
                cell.viewProperties?.cellState = .Open
                gameState = .Search
                currentOpenCell.append(cell)
                allOpenCell.append(cell)
                AudioPlayerService.shared.load(fileName: .openCard)
                AudioPlayerService.shared.play()
                //Открыта одна ячейка попали на нее
            case (.Open, .Search):
                UIView.transition(
                    from: cell.iconView,
                    to: cell.fonView,
                    duration: 0.5,
                    options: [.curveEaseInOut,
                              .transitionFlipFromLeft,
                              .showHideTransitionViews]
                )
                cell.viewProperties?.cellState = .Close
                gameState = .Start
                currentOpenCell.removeAll()
                //Открыта одна ячейка попали на вторую закрытую
            case (.Close, .Search):
                UIView.transition(
                    from: cell.fonView,
                    to: cell.iconView,
                    duration: 0.5,
                    options: [.curveEaseInOut,
                              .transitionFlipFromRight,
                              .showHideTransitionViews]
                )
                cell.viewProperties?.cellState = .Open
                gameState = .Opens
                currentOpenCell.append(cell)
                allOpenCell.append(cell)
                AudioPlayerService.shared.load(fileName: .openCard)
                AudioPlayerService.shared.play()
                //Сравниваем эти ячейки
                DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                    self.compareCell()
                }
            default:
                break
        }
    }
    
    public func checkOpenCard(with collectionView: UICollectionView?) -> Bool {
        guard let collectionView = self.collectionView else { return false }
        let result = collectionView.visibleCells.filter
        { ($0 as! GameCollectionCell).viewProperties?.cellState == .Close }
        if result.isEmpty {
            return true
        } else {
            return false
        }
    }
    
    public func startGame() {
        switch gameType {
            case .New:
                self.loadAllCell()
            case .Continue:
                print("")
        }
    }
    
    public func loadAllCell() {
        guard let collectionView = self.collectionView else { return }
        for cell in collectionView.visibleCells {
            let cell = cell as! GameCollectionCell
            gameState = .Start
            show(cell: cell)
            cell.viewProperties?.cellState = .Open
        }
        for cell in collectionView.visibleCells {
            let cell = cell as! GameCollectionCell
            gameState = .Search
            show(cell: cell)
            cell.viewProperties?.cellState = .Close
        }
    }
    
    public func setupMusic(){
        guard let isMute: Bool = UserDefaultsStandard.shared.get(key: .isMute) else {
            UserDefaultsStandard.shared.save(key: .isMute, value: false)
            return
        }
        self.muteImage = isMute ? #imageLiteral(resourceName: "soundOffbutton") : #imageLiteral(resourceName: "soundONButton")
        notifySubscribers()
        AudioPlayerService.shared.load(fileName: .gameFon)
        if isMute {
            AudioPlayerService.shared.pause()
        } else {
            AudioPlayerService.shared.play()
        }
    }
    
    private func compareCell(){
        let oneImage = currentOpenCell.first?.iconImageView.image
        let twoImage = currentOpenCell.last?.iconImageView.image
        if oneImage == twoImage {
            gameState = .Start
            currentOpenCell.forEach { $0.viewProperties?.cellState = .Found }
            currentOpenCell.removeAll()
            coincidencesCount += 1
            score(count: 25)
            AudioPlayerService.shared.load(fileName: .successCard)
            AudioPlayerService.shared.play()
            AudioPlayerService.shared.pause(delay: 0.5)
            if checkOpenCard(with: collectionView) {
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                    AudioPlayerService.shared.load(fileName: .winGame)
                    AudioPlayerService.shared.play()
                    self.winAction?()
                }
            }
        } else {
            AudioPlayerService.shared.load(fileName: .openCard)
            AudioPlayerService.shared.play()
            AudioPlayerService.shared.pause(delay: 0.2)
            currentOpenCell.forEach {
                gameState = .Search
                self.show(cell: $0)
            }
            currentOpenCell.removeAll()
        }
    }
    
    public func mute() {
        guard var isMute: Bool = UserDefaultsStandard.shared.get(key: .isMute) else {
            UserDefaultsStandard.shared.save(key: .isMute, value: false)
            return
        }
        isMute.toggle()
        UserDefaultsStandard.shared.save(key: .isMute, value: isMute)
        muteImage = isMute ? #imageLiteral(resourceName: "soundOffbutton") : #imageLiteral(resourceName: "soundONButton")
        if isMute {
            AudioPlayerService.shared.pause()
        } else {
            AudioPlayerService.shared.play()
        }
        notifySubscribers()
    }
    
    public func score(count: Int) {
        currentScore += count
        UserDefaultsStandard.shared.save(key: .score, value: currentScore)
        let score: Int? = (UserDefaultsStandard.shared.get(key: .score))
        currentScore = score!
        notifySubscribers()
    }
    
    public func updateGame() {
        collectionView?.reloadData()
        allOpenCell.forEach {
            $0.viewProperties?.cellState = .Open
            self.gameState = .Search
            self.show(cell: $0)
        }
    }
}

enum CellState {
    case Open
    case Close
    case Found
}

enum CardGame: String, CaseIterable {
    case oneCard
    case twoCard
    case threeCard
    case foreCard
    case fiveCard
    case sixCard
    case sevenCard
    case eightCard
    case nineCard
}

enum GameState {
    case Start
    case Search
    case Opens
    case End
}

enum GameType {
    case New
    case Continue
}
