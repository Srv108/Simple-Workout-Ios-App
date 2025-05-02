import UIKit

class WorkoutDetailsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    var workoutTitle: String?
    var exerciseNames: [String] = []
    var exerciseVideos: [String] = []
    var exerciseDescriptions: [String] = []

    @IBOutlet weak var tableView: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = workoutTitle ?? "Workout"

        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "ExerciseCell")
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return exerciseNames.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ExerciseCell", for: indexPath)
        let exerciseName = exerciseNames[indexPath.row]

        cell.textLabel?.numberOfLines = 0
        cell.textLabel?.text = exerciseName
        cell.textLabel?.font = UIFont.systemFont(ofSize: 16)

        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)

        let selectedExerciseName = exerciseNames[indexPath.row]
        let selectedVideoName = exerciseVideos[indexPath.row]
        let selectedExerciseDescription = exerciseDescriptions[indexPath.row]

        if let videoVC = storyboard?.instantiateViewController(withIdentifier: "VideoViewController") as? VideoViewController {
            videoVC.exerciseTitle = selectedExerciseName
            videoVC.videoName = selectedVideoName
            videoVC.exerciseDescription = selectedExerciseDescription 
            navigationController?.pushViewController(videoVC, animated: true)
        }
    }
}
