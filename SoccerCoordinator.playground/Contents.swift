import UIKit

// Player data, array of dictionaries
var players = [
    [
        "Player Name": "Joe Smith",
        "Height": "42",
        "Soccer Experience": "Yes",
        "Guardian Name": "jimAndJanSmith"
    ],
    [
        "Player Name": "Jill Tanner",
        "Height": "36",
        "Soccer Experience": "Yes",
        "Guardian Name": "Clara Tanner"
    ],
    [
        "Player Name": "Bill Bon",
        "Height": "43",
        "Soccer Experience": "Yes",
        "Guardian Name": "Sara and Jenny Bon"
    ],
    [
        "Player Name": "Eva Gordon",
        "Height": "45",
        "Soccer Experience": "No",
        "Guardian Name": "Wendy and Mike Gordon"
    ],
    [
        "Player Name": "Matt Gill",
        "Height": "40",
        "Soccer Experience": "No",
        "Guardian Name": "Charles and Sylvia Gill"
    ],
    [
        "Player Name": "Kimmy Stein",
        "Height": "41",
        "Soccer Experience": "No",
        "Guardian Name": "Bill and Hillary Stein"
    ],
    [
        "Player Name": "Sammy Adams",
        "Height": "45",
        "Soccer Experience": "No",
        "Guardian Name": "Jeff Adams"
    ],
    [
        "Player Name": "Karl Saygan",
        "Height": "42",
        "Soccer Experience": "Yes",
        "Guardian Name": "Heather Bledsoe"
    ],
    [
        "Player Name": "Suzane Greenberg",
        "Height": "44",
        "Soccer Experience": "Yes",
        "Guardian Name": "Henrietta Dumas"
    ],
    [
        "Player Name": "Sal Dali",
        "Height": "41",
        "Soccer Experience": "No",
        "guarGuardian NamedianName": "Gala Dali"
    ],
    [
        "Player Name": "Joe Kavalier",
        "Height": "39",
        "Soccer Experience": "No",
        "Guardian Name": "Sam and Elaine Kavalier"
    ],
    [
        "Player Name": "Ben Finkelstein",
        "Height": "44",
        "Soccer Experience": "No",
        "Guardian Name": "Aaron and Jill Finkelstein"
    ],
    [
        "Player Name": "Diego Soto",
        "Height": "41",
        "Soccer Experience": "Yes",
        "Guardian Name": "Robin and Sarika Soto"
    ],
    [
        "Player Name": "Chloe Alaska",
        "Height": "47",
        "Soccer Experience": "No",
        "Guardian Name": "David and Jamie Alaska"
    ],
    [
        "Player Name": "Arnold Willis",
        "Height": "43",
        "Soccer Experience": "No",
        "Guardian Name": "Claire Willis"
    ],
    [
        "Player Name": "Phillip Helm",
        "Height": "44",
        "Soccer Experience": "Yes",
        "Guardian Name": "Thomas Helm and Eva Jones"
    ],
    [
        "Player Name": "Les Clay",
        "Height": "42",
        "Soccer Experience": "Yes",
        "Guardian Name": "Wynonna Brown"
    ],
    [
        "Player Name": "Herschel Krustofski",
        "Height": "45",
        "Soccer Experience": "Yes",
        "Guardian Name": "Hyman and Rachel Krustofski"
    ]
]

// Array of teams
var teamName = ["Sharks", "Dragons", "Raptors"]

// Function to sort players by experience, then height
func sortPlayers() {
    let exp = "Soccer Experience"
    players.sort
        {
            item1, item2 in
            
            // Cast height data to integers, assign to items
            let h1:Int? = Int(item1["Height"]!)
            let h2:Int? = Int(item2["Height"]!)
            
            // sorting logic
            if item1[exp]=="Yes" && item2[exp]=="No"
            {
                return true
            }
            else if (item1[exp]=="Yes" && item2[exp]=="Yes") || (item1[exp]=="No" && item2[exp]=="No")
            {
                if h1! >= h2!
                {
                    return true
                }
                else
                {
                    return false
                }
            }
            else
            {
                return false
            }
    }
}

// Sort Players
sortPlayers()

// Dictionary to hold players and their associated teams
var teamRosters = ["":""]

// Function to distribute sorted to players onto teams
func distributePlayers() {
    
    let teamCount = teamName.count
    var currentTeam = 0
    
    // distribution loop
    for player in players
    {
        teamRosters[player["Player Name"]!] = teamName[currentTeam]
        currentTeam += 1
        if currentTeam >= teamCount
        {
            currentTeam = 0
        }
    }
}

// Distribute players
distributePlayers()

teamRosters

// First practice dates hard coded by team
var firstPractice: [String:String] = ["Sharks":"March 17, 3pm",
                                      "Dragons":"March 17, 1pm",
                                      "Raptors":"March 18, 1pm"]

// Letter to the parents
for player in players
{
    print("Dear \(player["Guardian Name"]),\r\nCongratulations! Welcome to the youth soccor league. We are happy to announce that the team rosters have been finalized and \(player["Player Name"]) has bean placed on the one and only \(teamRosters[player["Player Name"]!])! The \(teamRosters[player["Player Name"]!]) first practice will be held on \(firstPractice[teamRosters[player["Player Name"]!]!])")
}

// Dictionary declarations for
var dataByTeam: [String: Any?] = [:]
var plData: [String:Float] = [:]

// Function to assign plData to each team
func AssignPlData() -> [String: Any?] {
    
    for tn in teamName
    {
        for player in players
        {
            let h:Float? = Float(player["Height"]!)
            if teamRosters[player["Player Name"]!]! == tn
            {
                plData[player["Player Name"]!] = h
                dataByTeam[tn] = plData
            }
        }
        plData.removeAll()
    }
    return dataByTeam
}

// Update dataByTeam
dataByTeam = AssignPlData()

var updatedAvg: [String:Float] = [:]
let playerCount: Float = Float(plData.count)
var sum: Float = 0.0
var eachTeam: [String:Float] = [:]

// Calculate average of each team
func avgCalc() -> [String:Float] {
    
    for tn in teamName
    {
        eachTeam = AssignPlData()[tn] as! [String : Float]
        
        let teamHeights: [Float] = Array(eachTeam.values)
        for th in teamHeights
        {
            sum += th
        }
        
        let avg: Float = sum / Float(eachTeam.count)
        updatedAvg[tn] = avg
        sum = 0.0
        
    }
    return updatedAvg
}

var averages = avgCalc()
var shortestAvgHeight: Float = 1000.0
var tallestAvgHeight: Float = 0.0
var shortestTeam: String = ""
var tallestTeam: String = ""

func teamsToSwap() {
// Calculate shortest team name and it's average height
for team in averages
{
    if (team.value < shortestAvgHeight)
    {
        shortestAvgHeight = team.value
        shortestTeam = team.key
    }
}

// Calculate tallest team name and it's average height
for team in averages
{
    if (team.value > tallestAvgHeight)
    {
        tallestAvgHeight = team.value
        tallestTeam = team.key
    }
}
}
teamsToSwap()


// Calculate difference between tallest and shortest team averages
var diff = tallestAvgHeight - shortestAvgHeight

//
//
// These were for my own use, should they be left in here
//
//
shortestTeam
shortestAvgHeight
tallestTeam
tallestAvgHeight


// Could also check to see if delta is still valid, is it still improving and stop iterating

// Determines if the team averages are within or outside of the 1.5inch limit and if they are not balanced correctly executes the following code
if tallestAvgHeight - shortestAvgHeight > 1.5 {
    
    // Dictionary for tallest team players and their heights
    var tallestRoster: [String:Float] = [:]
    tallestRoster = dataByTeam[tallestTeam] as! [String : Float]
    
    // Dictionary for shortest team players and their heights
    var shortestRoster: [String:Float] = [:]
    shortestRoster = dataByTeam[shortestTeam] as! [String : Float]
    
    var plNameTallest = ""
    var plHtTallest: Float = 0.0
    var plNameShortest = ""
    var plHtShortest: Float = 0.0
    var minDiff: Float = 1000.0
    
    
    // Determines the tallest player from the tallest average team
    for pl in tallestRoster
    {
        if pl.value > plHtTallest
        {
            plNameTallest = pl.key
            plHtTallest = pl.value
        }
    }
    
    // Iterates through the roster of the shortest average team to find the player who's height difference to plNameTallest is closest to the height diff I am looking for
    for pl in shortestRoster
    {
        if (plHtTallest - pl.value) - diff < minDiff {
            minDiff = pl.value
            plNameShortest = pl.key
            plHtShortest = pl.value
        }
    }
    
    //
    //
    // These were for my own use, should they be left in here
    //
    //
    plNameTallest
    plHtTallest
    plNameShortest
    plHtShortest
    minDiff
    
    
    // Switches the players to the other team by updating the teamRosters data
    teamRosters[plNameShortest] = tallestTeam
    teamRosters[plNameTallest] = shortestTeam
    
    // Recalculates average
    var swappedAverages = avgCalc()
    teamsToSwap()
    
    /*
     
    Extra credit Notes
        - While this logic does successfully bring the teams within a 1.5 inch average height difference, it doesn't work as a loop to swap until the teams are as close as possible like I had originally intended
        - I wanted to set up a while loop that executed the player swap 'while tallestAvgHeight - shortestAvgHeight > 1.5'
        - I was unable to pass my updated average calculation back to the if (or while) statement
        - I think (not sure) if i could declare a new type 'averages' and have my teams to swap method accept that as a parameter I could pass in the swapped averages here at the bottom of the while loop to get an update tallestAvgHeight and shortestAvgHeight for the loop
        - It would look like func teamsToSwap(averages Avg) {...} up above and teamsToSwap(swappedAverages) down here
     
    */
    
}
