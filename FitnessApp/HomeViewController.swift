//
//  HomeViewController.swift
//  SimpleWorkoutApp
//
//  Created by Saurabh Kumar on 22/04/25.
//

import UIKit

class HomeViewController: UIViewController {

    @IBOutlet weak var hour: UILabel!
    @IBOutlet weak var second: UILabel!
    @IBOutlet weak var minute: UILabel!
    
    
    @IBOutlet weak var controlSegmented: UISegmentedControl!
    
    var timer: Timer?
    var secondsElapsed = 0
    
    @IBAction func controlSegmentChanged(_ sender: Any) {
        switch (sender as AnyObject).selectedSegmentIndex {
                case 0: // Start
                    pauseTimer()
                case 1: // Pause
                    startTimer()
                case 2: // Reset
                    resetTimer()
                default:
                    break
                }
    }
    override func viewDidLoad() {
            super.viewDidLoad()
            updateLabels()
     }
    func startTimer() {
            timer?.invalidate()
            timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { _ in
                self.secondsElapsed += 1
                self.updateLabels()
            }
        }

        func pauseTimer() {
            timer?.invalidate()
        }

        func resetTimer() {
            timer?.invalidate()
            secondsElapsed = 0
            updateLabels()
        }

        func updateLabels() {
            let hours = secondsElapsed / 3600
            let minutes = (secondsElapsed % 3600) / 60
            let seconds = secondsElapsed % 60

            hour.text = String(format: "%02d", hours)
            minute.text = String(format: "%02d", minutes)
            second.text = String(format: "%02d", seconds)
        }
}
