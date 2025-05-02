import UIKit
import AVKit
import AVFoundation

class VideoViewController: UIViewController {
    var videoName: String?
    var exerciseTitle: String?
    var exerciseDescription: String?
    
    @IBOutlet weak var containerView: UIView!
    
    @IBOutlet weak var descriptionLabel: UILabel!
    private var player: AVPlayer?

    override func viewDidLoad() {
        super.viewDidLoad()

        title = exerciseTitle ?? "Exercise Video"

        descriptionLabel.text = exerciseDescription ?? "No description available."

        guard let rawVideoName = videoName else {
            showErrorAlert(message: "No video specified")
            return
        }

        let cleanedVideoName = rawVideoName.replacingOccurrences(of: "Videos/", with: "")
        print("Attempting to load video: \(cleanedVideoName)")

        printAvailableVideos()

        if let path = Bundle.main.path(forResource: cleanedVideoName, ofType: "mp4") {
            playVideo(at: URL(fileURLWithPath: path))
        } else {
            print("ERROR: Video file '\(cleanedVideoName).mp4' not found in bundle.")
            showErrorAlert(message: "Exercise video not found")
        }
        descriptionLabel.numberOfLines = 0
        descriptionLabel.sizeToFit()

    }

    private func printAvailableVideos() {
        let bundleContents = try? FileManager.default.contentsOfDirectory(atPath: Bundle.main.bundlePath)
        let videoFiles = bundleContents?.filter { $0.lowercased().hasSuffix(".mp4") }
        print("Available MP4 files: \(videoFiles ?? [])")
    }

    private func playVideo(at url: URL) {
        player?.pause()
        containerView.layer.sublayers?.removeAll(where: { $0 is AVPlayerLayer })

        player = AVPlayer(url: url)
        let playerLayer = AVPlayerLayer(player: player)

        playerLayer.frame = containerView.bounds
        playerLayer.videoGravity = .resizeAspect
        containerView.layer.addSublayer(playerLayer)

        player?.play()

        NotificationCenter.default.addObserver(self,
           selector: #selector(videoDidEnd),
           name: .AVPlayerItemDidPlayToEndTime,
           object: player?.currentItem)
    }

    @objc private func videoDidEnd(notification: Notification) {
        
        player?.seek(to: .zero)
        player?.play()
    }

    private func showErrorAlert(message: String) {
        let alert = UIAlertController(title: "Video Error",
                                      message: message,
                                      preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        present(alert, animated: true)
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        containerView.layer.sublayers?
            .first(where: { $0 is AVPlayerLayer })?
            .frame = containerView.bounds
    }

    deinit {
        player?.pause()
        NotificationCenter.default.removeObserver(self)
    }
}
