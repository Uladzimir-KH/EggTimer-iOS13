//
//  ViewController.swift
//  EggTimer
//
//  Created by Angela Yu on 08/07/2019.
//  Copyright © 2019 The App Brewery. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {
    
    
    let tempMap = ["Soft" : 3, "Medium" : 420, "Hard" : 720]
    var timer: Timer?
    var counter = 0
    var progressStep: Float = 0.0
    var progress: Float = 0.0
    var player: AVAudioPlayer?
    
    @IBOutlet weak var mainText: UILabel!
    @IBOutlet weak var timerProgress: UIProgressView!
    @IBOutlet weak var clock: UILabel!
    @objc func prozessTimer() {
        if (0 < counter){
            counter -= 1
            print(counter, " second.")
            progress += progressStep
            setProgress(p: progress)
            setToClock(sec: counter)
            clock.alpha = 1.0
            timerProgress.alpha = 1.0
        }
        else {
            mainText.text = "How do you like your eggs?"
            clock.text = "DONE!"
            killTimer()
            progress = 0.0
            setProgress(p: progress)
            //setToClock(sec: 0)
            //clock.alpha = 0.0
            timerProgress.alpha = 0.0
            playSound()
        }
    }
    
    func killTimer() {
        timer?.invalidate()
        timer = nil
    }
    
    func setStepForProgress(seconds: Int) {
        progressStep = 1.0 / Float(seconds)
    }
    
    func setProgress(p: Float) {
        if 0.0 == p {
            timerProgress.progress = p

        } else if 0.0 <= p && p <= 1.0 {
            timerProgress.progress = p
        }
    }
    
    func setToClock(sec: Int) {
        if sec < 6000 {
            var minutes = 0
            var seconds = sec
            while seconds >= 60 {
                seconds -= 60
                minutes += 1
            }
            clock.alpha = 1.0
            
            var stringSeconds = String(seconds)
            var stringMinutes = String(minutes)
            
            if stringSeconds.count == 1 {
                stringSeconds = "0" + stringSeconds
            }
            if stringMinutes.count == 1 {
                stringMinutes = "0" + stringMinutes
            }
            clock.text = stringMinutes + ":" + stringSeconds
        }
    }
    
    func playSound() {
        guard let url = Bundle.main.url(forResource: "alarm_sound", withExtension: "mp3") else { return }

        do {
            try AVAudioSession.sharedInstance().setCategory(.playback, mode: .default)
            try AVAudioSession.sharedInstance().setActive(true)

            /* The following line is required for the player to work on iOS 11. Change the file type accordingly*/
            player = try AVAudioPlayer(contentsOf: url, fileTypeHint: AVFileType.mp3.rawValue)

            /* iOS 10 and earlier require the following line:
            player = try AVAudioPlayer(contentsOf: url, fileTypeHint: AVFileTypeMPEGLayer3) */

            guard let player = player else { return }

            player.play()

        } catch let error {
            print(error.localizedDescription)
        }
    }
    
    @IBAction func ChooseRare(_ sender: UIButton) {
        mainText.text = "Waiting..."
        killTimer()
        progress = 0.0
        progressStep = 0.0
        
        
        switch sender.currentTitle! {
        case "Soft":
            print(tempMap["Soft"]!)
            counter = tempMap["Soft"]!
            setStepForProgress(seconds: tempMap["Soft"]!)
            setToClock(sec: tempMap["Soft"]!)
            timer = Timer.scheduledTimer(timeInterval:1, target:self, selector:#selector(prozessTimer), userInfo: nil, repeats: true)
        case "Medium":
            print(tempMap["Medium"]!)
            counter = tempMap["Medium"]!
            setStepForProgress(seconds: tempMap["Medium"]!)
            setToClock(sec: tempMap["Medium"]!)
            timer = Timer.scheduledTimer(timeInterval:1, target:self, selector:#selector(prozessTimer), userInfo: nil, repeats: true)
        case "Hard":
            print(tempMap["Hard"]!)
            counter = tempMap["Hard"]!
            setStepForProgress(seconds: tempMap["Hard"]!)
            setToClock(sec: tempMap["Hard"]!)
            timer = Timer.scheduledTimer(timeInterval:1, target:self, selector:#selector(prozessTimer), userInfo: nil, repeats: true)
        default:
            print("ooops...")
        }
        
        
        

        
    }
    

}
