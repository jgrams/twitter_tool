# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

Example.create([
  {
    username: "SwiftOnSecurity"
  },
  {
    trimmed_at_tweet_count: {"@swiftonsecurity"=>"180", "@hacks4pancakes"=>"39", "@jepaynemsft"=>"32", 
      "@filmgirl"=>"31", "@stevesi"=>"27", "@internetofshit"=>"22", "@jessysaurusrex"=>"21", "@selenalarson"=>"18", 
      "@munin"=>"16", "@tayandyou"=>"15", "@rosyna"=>"15", "@blowdart"=>"14", "@thegrugq"=>"13", 
      "@jzdziarski"=>"13", "@sarahjeong"=>"13", "@asktweety"=>"13", "@highmeh"=>"12", "@malwaretechblog"=>"12", 
      "@popehat"=>"11", "@pwnallthethings"=>"11", "@carmencrincoli"=>"11", "@octal"=>"11", 
      "@nuclearanthro"=>"11", "@ciphpercoder"=>"10", "@bizzyunderscore"=>"10", "@da667"=>"10", "@dakami"=>"10", 
      "@fmanjoo"=>"10", "@jeremiahg"=>"10", "@jack"=>"10", "@apf"=>"10", "@edbott"=>"9", "@josephfcox"=>"9", 
      "@gossithedog"=>"9", "@richardkenyan"=>"9", "@kashhill"=>"9", "@eevee"=>"9", "@zackwhittaker"=>"8", 
      "@vessonsecurity"=>"8", "@jsnover"=>"8"}
  }, 
  { 
    trimmed_content_count: {"@swiftonsecurity"=>"180", "can"=>"158", "people"=>"130", "windows"=>"120", "know"=>"117",
     "security"=>"104", "get"=>"102", "use"=>"98", "one"=>"95", "linux"=>"88", "time"=>"86", "now"=>"86", 
     "will"=>"75", "even"=>"70", "make"=>"69", "think"=>"69", "work"=>"68", "microsoft"=>"68", "someone"=>"66", 
     "users"=>"65", "see"=>"64", "new"=>"64", "still"=>"63", "going"=>"62", "need"=>"61", "good"=>"59", 
     "got"=>"59", "every"=>"56", "twitter"=>"53", "actually"=>"49", "want"=>"48", "thing"=>"48", "never"=>"47", 
     "read"=>"47", "using"=>"46", "https"=>"45", "apple"=>"45", "life"=>"45", "code"=>"45", "tweet"=>"44"}
  }, 
  {
    trimmed_hashtag_count: {"#badlock"=>"3", "#dfir"=>"3", "#"=>"3", "#ff"=>"2", "#speeddatingpickuplines"=>"2",
      "#squad"=>"2", "#deusexatomica"=>"2", "#aces2016"=>"2", "#devops"=>"1", "#neverforget"=>"1", 
      "#bohemianrhapsody"=>"1", "#privacy"=>"1", "#justblackhatthings"=>"1", "#justwhitehatthings"=>"1", 
      "#websecurity"=>"1", "#hawp"=>"1", "#th"=>"1", "#reasonshumanswillgoextinct"=>"1", "#rickroll"=>"1", 
      "#mossackfonseca"=>"1", "#thinkbeforeyoupost"=>"1", "#botsummit"=>"1", "#issw"=>"1", "#badinfographics"=>"1", 
      "#alexa"=>"1", "#drones"=>"1", "#edsec"=>"1", "#sadlock"=>"1", "#deusexatomicaht"=>"1", "#applevsfbi"=>"1", 
      "#hipaa"=>"1", "#homeo"=>"1", "#abc15"=>"1", "#nevarforget"=>"1", "#opensource101this"=>"1", 
      "#infosecand"=>"1", "#justcorporatethings"=>"1", "#scifest"=>"1", "#coloradoa"=>"1", "#malware"=>"1"}

  }
  ])

Example.create([
  {
    username: "realDonaldTrump"
  },
  {
    trimmed_at_tweet_count: {"@realdonaldtrump"=>"568", "@foxnews"=>"123", "@cnn"=>"118", "@jebbush"=>"49", "@megynkelly"=>"45", "@seanhannity"=>"38", "@nytimes"=>"31", "@oreillyfactor"=>"30", "@morningjoe"=>"30", "@foxandfriends"=>"29", "@erictrump"=>"28", "@abc"=>"25", "@tedcruz"=>"25", "@wsj"=>"24", "@donaldjtrumpjr"=>"21", "@karlrove"=>"20", "@nbcsnl"=>"19", "@danscavino"=>"18", "@joenbc"=>"18", "@greta"=>"16", "@barbarajwalters"=>"15", "@borntobegop"=>"15", "@gop"=>"14", "@ivankatrump"=>"14", "@drudgereport"=>"14", "@chucktodd"=>"14", "@oann"=>"14", "@washingtonpost"=>"13", "@gstephanopoulos"=>"13", "@anncoulter"=>"13", "@jaketapper"=>"12", "@politico"=>"12", "@lindseygrahamsc"=>"11", "@meetthepress"=>"11", "@melaniatrump"=>"11", "@realbencarson"=>"10", "@bobvanderplaats"=>"10", "@glennbeck"=>"10", "@clewandowski"=>"10", "@andersoncooper"=>"9"}
  }, 
  { 
    trimmed_content_count: {"will"=>"580", "@realdonaldtrump"=>"568", "trump"=>"514", "great"=>"483", "thank"=>"461", "#trump2016"=>"323", "amp"=>"284", "america"=>"235", "new"=>"235", "#makeamericagreatagain"=>"224", "people"=>"207", "cruz"=>"204", "hillary"=>"163", "poll"=>"161", "make"=>"157", "now"=>"156", "big"=>"151", "get"=>"142", "donald"=>"137", "ted"=>"131", "vote"=>"123", "@foxnews"=>"123", "@cnn"=>"118", "president"=>"113", "one"=>"113", "rubio"=>"110", "tonight"=>"104", "many"=>"98", "time"=>"97", "iowa"=>"96", "debate"=>"96", "last"=>"96", "night"=>"93", "said"=>"92", "us"=>"90", "win"=>"90", "going"=>"88", "much"=>"86", "can"=>"86", "good"=>"84"}
  }, 
  {
    trimmed_hashtag_count: {"#trump2016"=>"323", "#makeamericagreatagain"=>"224", "#votetrump"=>"56", "#gopdebate"=>"35", "#fitn"=>"26", "#trump"=>"23", "#trumptrain"=>"20", "#iacaucus"=>"18", "#snl"=>"16", "#teamtrump"=>"15", "#supertuesday"=>"12", "#votetrump2016"=>"12", "#crippledamerica"=>"9", "#trump2016#makeamericagreatagain"=>"9", "#potus"=>"7", "#1"=>"7", "#inprimary"=>"7", "#votetrumpsc"=>"7", "#wiprimary"=>"6", "#scprimary"=>"6", "#votetrumpnh"=>"6", "#caucusfortrump"=>"6", "#nyprimary"=>"6", "#gop"=>"6", "#nhprimary"=>"6", "#icymi"=>"5", "#votetrumpnv"=>"5", "#trump2016#supertuesday"=>"5", "#'s"=>"5", "#isis"=>"5", "#demdebate"=>"5", "#abc2020"=>"5", "#msm"=>"4", "#donaldtrump"=>"4", "#"=>"4", "#wisconsin"=>"4", "#obamacare"=>"4", "#democratsfortrump"=>"3", "#trumparmy"=>"3", "#cnn"=>"3"}

  }
  ])