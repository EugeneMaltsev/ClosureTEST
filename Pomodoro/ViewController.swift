//
//  ViewController.swift
//  Pomodoro
//
//  Created by Eugene Maltsev on 17.03.2021.
//

import UIKit


class ViewController: UIViewController, PomodoroModelDelegate {
    
    func didRecieveTimeUpdate(times: String) {
        displayTime(timeLabel: times)
        
    }
    
    @IBOutlet weak var startButton: UIButton!
    @IBOutlet weak var pauseButton: UIButton!
    @IBOutlet weak var stopButton: UIButton!
    
    @IBOutlet weak var stopWatchAction: UILabel!
    
    let model = PomodoroModel()
    
    @IBAction func startButton(_ sender: UIButton) {
        
        model.startTimer()

        startButton.isHidden = true
        pauseButton.isHidden = false
        stopButton.isHidden = true
    }
    
    @IBAction func pauseButton(_ sender: UIButton) {
        
        model.pause()
        
        startButton.isHidden = false
        pauseButton.isHidden = true
        stopButton.isHidden = false
    }
    
    
    @IBAction func stopButton(_ sender: UIButton) {

        model.reset()

        stopButton.isHidden = true
        startButton.isHidden = false
        pauseButton.isHidden = true
    }
    
    func displayTime(timeLabel: String) {
        stopWatchAction.text = timeLabel
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        model.delegate = self
    }
}

