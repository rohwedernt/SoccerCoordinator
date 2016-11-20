// iOS Tech Degree Project-01 Soccer Coordinator
// Nate Rohweder

var players = [
    [
        "Player Name": "Joe Smith",
        "Height": "42",
        "Soccer Experience": "Yes",
        "Guardian Name": "Jim and Jan Smith"
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
        "Guardian Name": "Gala Dali"
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

// First practice dates hard coded by team
var firstPractice: [String:String] = ["Sharks":"March 17, 3pm",
                                      "Dragons":"March 17, 1pm",
                                      "Raptors":"March 18, 1pm"]

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
AssignPlData()

var updatedAvg: [String:Float] = [:]
let playerCount: Float = Float(plData.count)
var sum: Float = 0.0
var eachTeam: [String:Float] = [:]

// Calculate average of each team
func avgCalc() -> [String:Float] {
    
    for tn in teamName
    {
        eachTeam = dataByTeam[tn] as! [String : Float]
        
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

avgCalc()

var shortestAvgHeight: Float = 1000.0
var tallestAvgHeight: Float = 0.0
var shortestTeam: String = ""
var tallestTeam: String = ""

func teamsToSwap() {
    // Calculate shortest team name and it's average height
    shortestAvgHeight = 1000.0
    tallestAvgHeight = 0.0
    for team in updatedAvg
    {
        if (team.value <= shortestAvgHeight)
        {
            shortestAvgHeight = team.value
            shortestTeam = team.key
        }
    }
    
    // Calculate tallest team name and it's average height
    for team in updatedAvg
    {
        if (team.value >= tallestAvgHeight)
        {
            tallestAvgHeight = team.value
            tallestTeam = team.key
        }
    }
}
teamsToSwap()


// Calculate difference between tallest and shortest team averages
var diff = tallestAvgHeight - shortestAvgHeight
var newDiff = diff
// Determines if the team averages are within or outside of the 1.5inch limit and if they are not balanced correctly executes the following code
repeat {
    
    diff = newDiff
    
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
    var minDifSoFar: Float = 1000.0
    var curDiff: Float
    
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
        curDiff = abs((plHtTallest - pl.value) - diff)
        if curDiff < minDifSoFar {
            minDifSoFar = curDiff
            plNameShortest = pl.key
            plHtShortest = pl.value
        }
    }
    
    // Switches the players to the other team by updating the teamRosters data
    teamRosters[plNameShortest] = tallestTeam
    teamRosters[plNameTallest] = shortestTeam
    dataByTeam = AssignPlData()
    
    // Recalculates average
    updatedAvg = avgCalc()
    
    teamsToSwap()
    
    newDiff = tallestAvgHeight - shortestAvgHeight
    
} while newDiff < diff


// Letter to the parents
for player in players
{
    print("Dear \(player["Guardian Name"]!),\r\nWelcome to the youth soccor league. We are happy to announce that the team rosters have been finalized and \(player["Player Name"]!) has bean placed on the \(teamRosters[player["Player Name"]!]!). The \(teamRosters[player["Player Name"]!]!) first practice will be held on \(firstPractice[teamRosters[player["Player Name"]!]!]!)\n")
}
