//: Soccer Coordinator - Evenly distribute pro and rookie players between three teams

// Create individual collections for Sharks, Raptors, and Dragons
// Defined as an empty array of dictionaries.
var sharks:[[String:String]] = []
var raptors:[[String:String]] = []
var dragons:[[String:String]] = []

// contains all available players
// Would be better for items in collection to be Player objects, since
// mixed types would be easier to handle.
// it'd also reduce risk of mistyping keys or other data
let league = [
    ["name": "Joe Smith", "height": "42", "experience": "yes", "guardians": "Jim and Jan Smith"],
    ["name": "Jill Tanner", "height": "36", "experience": "yes", "guardians": "Clara Tanner"],
    ["name": "Bill Bon", "height": "43", "experience": "yes", "guardians": "Sara and Jenny Bon"],
    ["name": "Eva Gordon", "height": "45", "experience": "no", "guardians": "Wendy and Mike Gordon"],
    ["name": "Matt Gill", "height": "40", "experience": "no", "guardians": "Charles and Sylvia Gill"],
    ["name": "Kimmy Stein", "height": "41", "experience": "no", "guardians": "Bill and Hillary Stein"], // 6 players
    ["name": "Sammy Adams", "height": "45", "experience": "no", "guardians": "Jeff Adams"],
    ["name": "Karl Saygan", "height": "42", "experience": "yes", "guardians": "Heather Bledsoe"],
    ["name": "Suzane Greenberg", "height": "44", "experience": "yes", "guardians": "Henrietta Dumas"],
    ["name": "Sal Dali", "height": "41", "experience": "no", "guardians": "Gala Dali"],
    ["name": "Joe Kavalier", "height": "39", "experience": "no", "guardians": "Sam and Elaine Kavalier"],
    ["name": "Ben Finkelstein", "height": "44", "experience": "no", "guardians": "Aaron and Jill Finkelstein"], // 12 players
    ["name": "Diego Soto", "height": "41", "experience": "yes", "guardians": "Robin and Sarika Soto"],
    ["name": "Chloe Alaska", "height": "47", "experience": "no", "guardians": "David and Jamie Alaska"],
    ["name": "Arnold Willis", "height": "43", "experience": "no", "guardians": "Claire Willis"],
    ["name": "Phillip Helm", "height": "44", "experience": "yes", "guardians": "Thomas Helm and Eva Jones"],
    ["name": "Les Clay", "height": "42", "experience": "yes", "guardians": "Wynonna Brown"],
    ["name": "Herschel Krustofski", "height": "45", "experience": "yes", "guardians": "Hyman and Rachel Krustofski"]
]

let playersCount = league.count

// takes in a collection--either an individual team or the whole league,
// and returns the average height (in inches)
func calculateAverageHeight(team: [[String:String]]) -> Int {
    var sumOfHeights = 0
    for player in team {
        // We either use if-let syntax or some really ugly forced unwrapping on the optional here
        // I think this is more readable
        if let height = player["height"] {
            sumOfHeights += Int(height)! // We have to cast the value as an Int, because all values in the dictionary are stored as strings
                                         // We could use a Dictionary<String:Any> but I'm not sure if that's allowed for this lesson.
                                         // Advanced structures would also help with this issue
        } else {
            sumOfHeights += 0
        }
    }
    
    return sumOfHeights / team.count
}

// has no return value as it will simply modify our team arrays.
func sortTeams(players:[[String:String]]) {
    
}

// ****HELPERS****
// These methods are just to handle some logic out of the main flow
func isExperienced(player:[String:String]) -> Bool {
    if let experience = player["experience"] {
        
        if experience == "yes" {
            return true
        }
    }
    // if experience key is nil, or anything else but yes,
    // w
    return false
}
isExperienced(league[0])
isExperienced(league[14])


// TODO: Take in an array of teams, and iterate over each team's players
// creating a take-home letter for each guardian/player
func finalizeTeams() -> String {
    return "FINISH ME"
}

// takes in a player item in the dictionary and generates the content body of
// a letter.
func generateLetter(player: [String:String], team: String) -> String {
    // have to define letter body in able to return it
    // scope of switch statements doesn't allow us to define it later.
    var letterBody: String = "Dear \(player["guardians"]!), congratulations! Your child, \(player["name"]!), has been selected to play for the \(team) in this year's soccer league!"
    switch team {
    // there was a lot of repetition of strings, so why not extract that to our 
    // declaration and use some good ol' concatenation for the only part that changed?
    case "Sharks":
        letterBody += " Our first practice is on March 17th at 3pm."
    case "Raptors":
        letterBody += " Our first practice is on March 18th at 1pm."
    case "Dragons":
        letterBody += " Our first practice is on March 17th at 1pm. Whose the Mother of Dragons now? Best regards, Coach."
    default:
        // we totally reassign the value in team isn't valid. It must mean they didn't make the cut.
        letterBody = "Dear \(player["guardians"]), we are sorry to inform you that your child, \(player["name"]) did not make the cut for this year's soccer league. Feel free to try out next year. Signed, Coach."
    }
    return letterBody
}

generateLetter(league[4], team: "Sharks")
