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

func a1 () -> Bool {
    
    let a = 1
    let b = 2
    
    func df () -> Bool {
        return a == b
    }
    
    let df2 = {
        a == b
    }
    
    return df2()
}

var someInt = 0

func regularTimerFunc(timer: Timer) {
    
}

class PomodoroModel {
    
    weak var delegate: PomodoroModelDelegate?
    private var timer: Timer?
//    private var timerBreak = Timer()
    private var count = 1500
    private var countBreak = 250
    private var work = false
// 1500 300
    
    class MyTimerFunc {
        let cycleRef: PomodoroModel
        init(cycleRef: PomodoroModel) {
            self.cycleRef = cycleRef
        }
    }
    class MyTimer {
        let myFunc: MyTimerFunc
        init(myFunc: MyTimerFunc) {
            self.myFunc = myFunc
        }
    }
    var myTimer: MyTimer?

    func compareStrings(_ lhs: String, _ rhs: String) -> Bool {
        return lhs < rhs
    }
    
    func startTimer() {
        
        self.myTimer = MyTimer(myFunc: MyTimerFunc(cycleRef: self))
        
        struct MyClosure {
            weak var self1: PomodoroModel?
            // var self2: PomodoroModel
            
            func onTimer(timer: Timer) {
                guard let self2 = self1 else { return }
                assert(self2.timer == timer)
                self2.countTimer()
            }
        }
        
        self.myTimer = nil
        
        let myClosure = MyClosure(self1: self)
        self.timer = Timer.scheduledTimer(withTimeInterval: 1,
                                          repeats: true,
                                          block:myClosure.onTimer)
        
        self.timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true, block: {
            [weak weakSelf = self] (timer: Timer) -> Void in
            guard let strongSelf = weakSelf else { return }
            assert(strongSelf.timer == timer)
            strongSelf.countTimer()
        })
        
        self.timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true, block: {
            [weak self] (timer: Timer) -> Void in
            guard let self = self else { return }
            assert(self.timer == timer)
            self.countTimer()
        })
        
        let arr: [String] = ["a", "b", "c"]
        let _ = arr.sorted() {
            self.compareStrings($0, $1)
        }
        
        
        
        
//        timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) {
//            (timer: Timer) -> Void in
//            self.countTimer()
//        }
        
//        timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) {
//            (timer) in
//            self.countTimer()
//        }
                
//        timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) {
//            [weak self] timer in
//            self?.countTimer()
//        }
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
