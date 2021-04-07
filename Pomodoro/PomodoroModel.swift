//
//  Timer.swift
//  Pomodoro
//
//  Created by Eugene Maltsev on 17.03.2021.
//

import Foundation

protocol PomodoroModelDelegate: class {
    func didRecieveTimeUpdate(times: String)
}


class PomodoroModel {
    
    weak var delegate: PomodoroModelDelegate?
    private var timer: Timer?
//    private var timerBreak = Timer()
    private var count = 1500
    private var countBreak = 250
    private var work = false
// 1500 300

    func startTimer() {
//        timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true, block: {
//            (timer: Timer) -> Void in
//            self.countTimer()
//        })
        
//        timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) {
//            (timer: Timer) -> Void in
//            self.countTimer()
//        }
        
//        timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) {
//            (timer) in
//            self.countTimer()
//        }
        
        timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) {
            [weak self] timer in
            self?.countTimer()
        }
    }
    
    func countTimer() {
        
        if count > -1 {
            work = true
            delegate?.didRecieveTimeUpdate(times: formatTime(time: count))
            count -= 1
        } else {
            work = false
        }
        
        if work == false {
            if countBreak > -1 {
                delegate?.didRecieveTimeUpdate(times: formatTime(time: countBreak))
                countBreak -= 1
            } else {
                reset()
                startTimer()
            }
        }
        
    }
    
    func formatTime(time: Int) -> String {
        
        let minutes = Int(time) / 60 % 60
        let seconds = Int(time) % 60

        return String(format: "%02i:%02i", minutes, seconds)
    }
    
    func reset() {
        timer?.invalidate()
        timer = nil
        count = 1500
        countBreak = 300
    }
    
    func pause() {
        timer?.invalidate()
    }
}
