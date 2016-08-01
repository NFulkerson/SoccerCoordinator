//: Soccer Coordinator - Evenly distribute pro and rookie players between three teams
import Foundation
// Create individual collections for Sharks, Raptors, and Dragons
// Defined as an empty array of dictionaries.
var sharks:[[String:String]] = []
var raptors:[[String:String]] = []
var dragons:[[String:String]] = []

var teams = [sharks, raptors, dragons]

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
    // could add some bogus players here to test for more/fewer players
    // this code still makes some assumptions... an evenly distributed number of experienced vs inexperienced players
    // and probably that there are no significant differences in average height
//    ["name": "Arya Stark", "height": "38", "experience": "no", "guardians": "Ned Stark"],
//    ["name": "Jon Snow", "height": "48", "experience": "yes", "guardians": "Lyanna and Rhaegar Targaryen"],
//    ["name": "Bran Stark", "height": "38", "experience": "yes", "guardians": "Ned Stark"],
//    ["name": "Robb Stark", "height": "48", "experience": "no", "guardians": "Catelyn Stark"],
//    ["name": "Sansa Stark", "height": "40", "experience": "no", "guardians": "Petyr Baelish"],
//    ["name": "Rickon Stark", "height": "39", "experience": "yes", "guardians": "Asha"]
    
]

let playersCount = league.count

// takes in a collection--either an individual team or the whole league,
// and returns the average height (in inches)
// Use a double in order to meet requirements for extra credit
func calculateAverageHeight(team: [[String:String]]) -> Double {
    var sumOfHeights = 0.0
    for player in team {
        // We either use if-let syntax or some really ugly forced unwrapping on the optional here
        if let height = player["height"] {
            sumOfHeights += Double(height)! // We have to cast the type to Double because height is actually a string
                                            // We could get around this by making player items Dictionary<String, Any>
                                            // But I'm not sure if that's allowed for this project
        } else {
            sumOfHeights += 0
        }
    }
    
    return sumOfHeights / Double(team.count)
}

func isExperienced(player:[String:String]) -> Bool {
    if let experience = player["experience"] {
        
        if experience == "yes" {
            return true
        }
    }
    // if experience key is nil, or anything else but yes,
    // we return false
    return false
}
isExperienced(league[0])
isExperienced(league[14])

// has no return value as it will simply modify our team arrays.
func sortTeams(players:[[String:String]]) {
    // initialize two empty arrays to separate our players into
    var experiencedPlayers: [[String:String]] = []
    var inexperiencedPlayers: [[String:String]] = []
    for player in players {
        let hasExperience = isExperienced(player)
        if (hasExperience) {
            experiencedPlayers.append(player)
        } else {
            inexperiencedPlayers.append(player)
        }
    }
    // divide each set of players by the number of teams to ensure it can be evenly assigned
    if (experiencedPlayers.count % teams.count == 0) {
        // we don't care about the iterator right now
        while (!experiencedPlayers.isEmpty && !inexperiencedPlayers.isEmpty) {
            // this doesn't account for heights so far, but it will evenly distribute teams
            // there must be a more elegant way of doing this.
            sharks.append(experiencedPlayers.removeFirst())
            raptors.append(experiencedPlayers.removeFirst())
            dragons.append(experiencedPlayers.removeFirst())
            sharks.append(inexperiencedPlayers.removeFirst())
            raptors.append(inexperiencedPlayers.removeFirst())
            dragons.append(inexperiencedPlayers.removeFirst())
        }
    } else {
        print("It seems there isn't an equal number of players...")
    }

}

func calculateAverageHeightDifference(team1: [[String:String]], team2: [[String:String]]) -> Double {
    let teamOneAverage = calculateAverageHeight(team1)
    let teamTwoAverage = calculateAverageHeight(team2)
    // we really don't care which team is greater or smaller than the other
    // only that the difference between the two is greater than 1.5.
    // If it is, we're just going to swap teammates until the difference is lower
    // So let's get an absolute value so we don't get negative values
    return abs(teamOneAverage - teamTwoAverage)
}

func rearrangeTeamMembers(team1: [[String:String]], team2: [[String:String]]) -> [[[String:String]]] {
    var teamA = team1
    var teamB = team2
    teamB.append(teamA.removeLast())
    teamA.append(teamB.removeFirst())
    
    return [teamA, teamB]
}


// let's make a function similar to the above function
// then adjusts players until they have an equal number of experienced/inexperienced players
// AND are within the allowable difference in average height
func sortTeamsByHeight(players:[[String:String]]) {
    sortTeams(league)
    // let's make a condition that is initially true and evaluate it in a while loop..
    // When it is false, the teams should all be within a 1.5 difference in average height
    var teamsNotEqual = true
    while (teamsNotEqual) {
        let sharkRaptorDif = calculateAverageHeightDifference(sharks, team2: raptors)
        let sharkDragonDif = calculateAverageHeightDifference(sharks, team2: dragons)
        let dragonRaptorDif = calculateAverageHeightDifference(dragons, team2: raptors)
        if (sharkRaptorDif <= 1.5 && sharkDragonDif <= 1.5 && dragonRaptorDif <= 1.5) {
            teamsNotEqual = false
        } else {
            if (sharkRaptorDif >= 1.5) {
                let newTeams = rearrangeTeamMembers(sharks, team2: raptors)
                sharks = newTeams[0]
                raptors = newTeams[1]
            }
            if (sharkDragonDif >= 1.5) {
                let newTeams = rearrangeTeamMembers(sharks, team2: dragons)
                sharks = newTeams[0]
                dragons = newTeams[1]
            }
            if (dragonRaptorDif >= 1.5) {
                let newTeams = rearrangeTeamMembers(dragons, team2: raptors)
                dragons = newTeams[0]
                raptors = newTeams[1]
            }
        }

    }
    
}

sortTeamsByHeight(league)
// for debugging purposes
calculateAverageHeight(sharks)
calculateAverageHeight(raptors)
calculateAverageHeight(dragons)

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

func printLetters(team:[[String:String]], name: String) {
    for player in team {
        print(generateLetter(player, team: name))
    }
}

sharks
dragons
raptors
printLetters(sharks, name: "Sharks")
printLetters(dragons, name: "Dragons")
printLetters(raptors, name: "Raptors")
