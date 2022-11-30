//
//  ViewController.swift
//  Xyloph
//
//  Created by Lucinda Flores on 15/09/2022.
//
 
import UIKit
import AVFoundation


class ViewController: UIViewController {
    
    var audioPlayer: AVAudioPlayer!
    
    @IBOutlet var topPortraitButton: UIButton!    
    @IBOutlet var topLandscapeButton: UIButton!
    

    @IBOutlet var portraitKeys: [UIButton]! {
        didSet { //property observer
            portraitKeys.sort { $0.tag < $1.tag } 
        }
    }
    
    @IBOutlet var landscapeKeys: [UIButton]! {
        didSet {
            landscapeKeys.sort { $0.tag < $1.tag }
        }
    }

    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        portraitKeys = portraitKeys.sorted { $0.tag < $1.tag }
        landscapeKeys = landscapeKeys.sorted { $0.tag < $1.tag }
        
    }
    

    @IBAction func landscapeKeyPressed(_ sender: UIButton) {
        let audioFileName = audioFileNames[sender.tag]
        playSound(using: audioFileName)
        
    }
    
    @IBAction func portraitKeyPressed(_ sender: UIButton) {
        let audioFileName = audioFileNames[sender.tag]
        playSound(using: audioFileName)
        
    }
    
    
    func playSound(using audioFileName: String) {
        guard let soundURL = Bundle.main.url(forResource: audioFileName, withExtension: "mp3") else {
            fatalError("Unable to find sound \(audioFileName)")
        }
        
        do {
            audioPlayer = try AVAudioPlayer(contentsOf: soundURL)
            audioPlayer.currentTime = 0
            audioPlayer.play()
        } catch {
            print(error.localizedDescription)
        }
   
    }
    
    
    
    @IBAction func topPortraitButtonPressed(_ sender: UIButton) {
        switch topPortraitButton.tag {
        case 0:
            // Changes key button images to latin convention in both landscape and portrait
            // Changes topButton image to "C"
            keyLettersToLatin()
            
        case 1:
            // Changes key button images to Solfeggio in both landscape and portrait
            // Changes topButton image to "Do""
            keyLettersToSolfeggio()

        case 2:
            // Shows plain key buttons in both landscape and portrait
            // Changes topButton image to music note
            keyLettersToPlain()
            
        default:
            return
        }
        
    }
    
    
    @IBAction func topLandscapeButtonPressed(_ sender: UIButton) {
        switch topLandscapeButton.tag {
        case 0:
            // Changes key button images to latin convention in both landscape and portrait
            // Changes topButton image to "C"
            keyLettersToLatin()
            
        case 1:
            // Changes key button images to Solfeggio in both landscape and portrait
            keyLettersToSolfeggio()

        case 2:
            // Shows plain key buttons in both landscape and portrait
            // Changes topButton image to music note
            keyLettersToPlain()
            
        default:
            return
        }
        
    }
    
    
    func keyLettersToLatin() {
        topPortraitButton.tag = 1
        topLandscapeButton.tag = 1

        topPortraitButton.configuration?.image  = .none
        topLandscapeButton.configuration?.image = .none
        
        topPortraitButton.configuration?.background.image = UIImage(named: topButtonImages.cNote)
        topLandscapeButton.configuration?.background.image = UIImage(named: topButtonImages.cNote)
        
        for (number, key) in portraitKeys.enumerated() {
            key.configuration?.background.image = UIImage(named: englishNotation[number])
            key.configuration?.background.imageContentMode = .scaleAspectFit
        }
        
        for (number, key) in landscapeKeys.enumerated() {
            key.configuration?.background.image = UIImage(named: englishNotation[number])
            key.configuration?.background.imageContentMode = .scaleAspectFit
        }
        
    }
    
    
    func keyLettersToSolfeggio() {
        topPortraitButton.tag = 2
        topLandscapeButton.tag = 2

        topPortraitButton.configuration?.image  = .none
        topLandscapeButton.configuration?.image = .none
        
        topPortraitButton.configuration?.background.image = UIImage(named: topButtonImages.doNote)
        topLandscapeButton.configuration?.background.image = UIImage(named: topButtonImages.doNote)

        for (number, key) in portraitKeys.enumerated() {
            key.configuration?.background.image = UIImage(named: solfeggioNotation[number])
            key.configuration?.background.imageContentMode = .scaleAspectFit
        }
        
        for (number, key) in landscapeKeys.enumerated() {
            key.configuration?.background.image = UIImage(named: solfeggioNotation[number])
            key.configuration?.background.imageContentMode = .scaleAspectFit
        }
        
    }
    
    
    func keyLettersToPlain() {
        topPortraitButton.tag = 0
        topLandscapeButton.tag = 0
        
        topPortraitButton.configuration?.image = UIImage(systemName: topButtonImages.musicalNote)
        topLandscapeButton.configuration?.image = UIImage(systemName: topButtonImages.musicalNote)
        
        topPortraitButton.configuration?.background.image = .none
        topLandscapeButton.configuration?.background.image = .none

        for key in portraitKeys {
            key.configuration?.background.image = .none
        }
        
        for key in landscapeKeys {
            key.configuration?.background.image = .none
        }
        
    }
    


}

