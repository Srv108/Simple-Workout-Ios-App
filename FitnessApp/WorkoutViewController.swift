import UIKit

struct Exercise {
    let name: String
    let description: String
}

struct Workout {
    let title: String
    let exercises: [Exercise]
}

class WorkoutViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    let workouts: [Workout] = [
        Workout(title: "Push Day", exercises: [
            Exercise(name: "Bench Press", description: "Strengthens your chest, shoulders, and triceps. A core compound lift for upper body power."),
            Exercise(name: "Incline Dumbbell Press", description: "Targets the upper chest muscles and shoulders. Enhances stability and strength."),
            Exercise(name: "Shoulder Press", description: "Builds strong shoulders and improves overhead strength."),
            Exercise(name: "Lateral Raise", description: "Isolates the side deltoid muscles for broader shoulders."),
            Exercise(name: "Triceps Pushdown", description: "Focuses on triceps strength using a cable machine."),
            Exercise(name: "Overhead Triceps", description: "Targets the long head of the triceps for bigger arms.")
        ]),
        Workout(title: "Pull Day", exercises: [
            Exercise(name: "Pull Ups", description: "A bodyweight exercise that builds back, shoulders, and arm strength."),
            Exercise(name: "Lat Pulldown", description: "Strengthens the latissimus dorsi muscles of the back."),
            Exercise(name: "Barbell Row", description: "Develops back thickness and core stability."),
            Exercise(name: "Face Pulls", description: "Improves shoulder health and posture."),
            Exercise(name: "Bicep Curls", description: "Isolates the biceps to build arm strength."),
            Exercise(name: "Hammer Curls", description: "Targets the biceps and forearms for overall arm development.")
        ]),
        Workout(title: "Leg Day", exercises: [
            Exercise(name: "Squats", description: "A full-body movement that targets quads, glutes, hamstrings, and core."),
            Exercise(name: "Leg Press", description: "Develops lower body strength and muscle mass."),
            Exercise(name: "Lunges", description: "Improves balance, coordination, and targets the legs and glutes."),
            Exercise(name: "Leg Curl", description: "Focuses on strengthening the hamstrings."),
            Exercise(name: "Leg Extension", description: "Isolates and strengthens the quadriceps."),
            Exercise(name: "Calf Raises", description: "Strengthens calf muscles for better lower leg definition.")
        ]),
        Workout(title: "Cardio", exercises: [
            Exercise(name: "Treadmill", description: "An efficient way to improve cardiovascular health and endurance."),
            Exercise(name: "Incline Treadmill", description: "Increases intensity, targeting glutes and hamstrings."),
            Exercise(name: "Running", description: "A full-body exercise that enhances heart and lung function."),
            Exercise(name: "Step Mill", description: "Simulates stair climbing for cardio and leg strengthening."),
            Exercise(name: "Burpees", description: "A high-intensity full-body movement that boosts endurance."),
            Exercise(name: "Jumping Rope", description: "Improves coordination, burns calories, and boosts cardio fitness.")
        ])
    ]

    let exerciseVideoMapping: [String: String] = [
        "Bench Press": "benchPress",
        "Incline Dumbbell Press": "inclinePress",
        "Shoulder Press": "shoulderPress",
        "Lateral Raise": "lateralRaise",
        "Triceps Pushdown": "tricepsPushdown",
        "Overhead Triceps": "overheadTriceps",

        "Pull Ups": "Videos/pullUps",
        "Lat Pulldown": "Videos/latPulldown",
        "Barbell Row": "Videos/barbellRow",
        "Face Pulls": "Videos/facePulls",
        "Bicep Curls": "Videos/bicepCurls",
        "Hammer Curls": "Videos/hammerCurls",

        "Squats": "Videos/squats",
        "Leg Press": "Videos/legPress",
        "Lunges": "Videos/lunges",
        "Leg Curl": "Videos/legCurl",
        "Leg Extension": "Videos/legExtension",
        "Calf Raises": "Videos/calfRaises",

        "Treadmill": "treadmill",
        "Incline Treadmill": "inclineTreadmill",
        "Running": "running",
        "Step Mill": "stepmill",
        "Burpees": "burpees",
        "Jumping Rope": "jumpingRope"
    ]

    @IBOutlet weak var tableView: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Workout"

        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "WorkoutCell")
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return workouts.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "WorkoutCell", for: indexPath)
        let workout = workouts[indexPath.row]
        cell.textLabel?.text = workout.title
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)

        let selectedWorkout = workouts[indexPath.row]

        let exerciseNames = selectedWorkout.exercises.map { $0.name }
        let exerciseDescriptions = selectedWorkout.exercises.map { $0.description }
        let exerciseVideos = selectedWorkout.exercises.map { exerciseVideoMapping[$0.name] ?? "" }

        if let detailVC = storyboard?.instantiateViewController(withIdentifier: "WorkoutDetailsViewController") as? WorkoutDetailsViewController {
            detailVC.workoutTitle = selectedWorkout.title
            detailVC.exerciseNames = exerciseNames
            detailVC.exerciseVideos = exerciseVideos
            detailVC.exerciseDescriptions = exerciseDescriptions  
            navigationController?.pushViewController(detailVC, animated: true)
        }
    }
}
