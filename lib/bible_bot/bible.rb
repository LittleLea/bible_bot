module BibleBot
  # Defines Books and Regular Expressions used for parsing and other logic in this gem.
  class Bible

    # Using this list to inform some of the Abbreviation decisions: https://www.logos.com/bible-book-abbreviations
    # DBL Codes are from https://app.thedigitalbiblelibrary.org/static/docs/entryref/text/metadata.html#vocab-bookcode
    @@books = [
      Book.new(
        id: 1,
        name: "Genesis",
        abbreviation: "Gen",
        dbl_code: "GEN",
        regex: "(?:Gen|Ge|Gn)(?:esis)?",
        testament: "Old",
        chapters: [31, 25, 24, 26, 32, 22, 24, 22, 29, 32, 32, 20, 18, 24, 21, 16, 27, 33, 38, 18, 34, 24, 20, 67, 34, 35, 46, 22, 35, 43, 55, 32, 20, 31, 29, 43, 36, 30, 23, 23, 57, 38, 34, 34, 28, 34, 31, 22, 33, 26]
      ),
      Book.new(
        id: 2,
        name: "Exodus",
        abbreviation: "Exod",
        dbl_code: "EXO",
        regex: "Ex(?:odus|od|o)?",
        testament: "Old",
        chapters: [22, 25, 22, 31, 23, 30, 25, 32, 35, 29, 10, 51, 22, 31, 27, 36, 16, 27, 25, 26, 36, 31, 33, 18, 40, 37, 21, 43, 46, 38, 18, 35, 23, 35, 35, 38, 29, 31, 43, 38]
      ),
      Book.new(
        id: 3,
        name: "Leviticus",
        abbreviation: "Lev",
        dbl_code: "LEV",
        regex: "(?:Lev|Le|Lv)(?:iticus)?",
        testament: "Old",
        chapters: [17, 16, 17, 35, 19, 30, 38, 36, 24, 20, 47, 8, 59, 57, 33, 34, 16, 30, 37, 27, 24, 33, 44, 23, 55, 46, 34]
      ),
      Book.new(
        id: 4,
        name: "Numbers",
        abbreviation: "Num",
        dbl_code: "NUM",
        regex: "N(?:umbers|um|u|m|b)",
        testament: "Old",
        chapters: [54, 34, 51, 49, 31, 27, 89, 26, 23, 36, 35, 16, 33, 45, 41, 50, 13, 32, 22, 29, 35, 41, 30, 25, 18, 65, 23, 31, 40, 16, 54, 42, 56, 29, 34, 13]
      ),
      Book.new(
        id: 5,
        name: "Deuteronomy",
        abbreviation: "Deut",
        dbl_code: "DEU",
        regex: "D(?:euteronomy|eut|e|t)",
        testament: "Old",
        chapters: [46, 37, 29, 49, 33, 25, 26, 20, 29, 22, 32, 32, 18, 29, 23, 22, 20, 22, 21, 20, 23, 30, 25, 22, 19, 19, 26, 68, 29, 20, 30, 52, 29, 12]
      ),
      Book.new(
        id: 6,
        name: "Joshua",
        abbreviation: "Josh",
        dbl_code: "JOS",
        regex: "J(?:oshua|osh|os|sh)",
        testament: "Old",
        chapters: [18, 24, 17, 24, 15, 27, 26, 35, 27, 43, 23, 24, 33, 15, 63, 10, 18, 28, 51, 9, 45, 34, 16, 33]
      ),
      Book.new(
        id: 7,
        name: "Judges",
        abbreviation: "Judg",
        dbl_code: "JDG",
        regex: "J(?:udges|udg|dg|g|dgs)",
        testament: "Old",
        chapters: [36, 23, 31, 24, 31, 40, 25, 35, 57, 18, 40, 15, 25, 20, 20, 31, 13, 31, 30, 48, 25]
      ),
      Book.new(
        id: 8,
        name: "Ruth",
        abbreviation: "Ruth",
        dbl_code: "RUT",
        regex: "R(?:uth|u|th)",
        testament: "Old",
        chapters: [22, 23, 18, 22]
      ),
      Book.new(
        id: 9,
        name: "1 Samuel",
        abbreviation: "1Sam",
        dbl_code: "1SA",
        regex: "(?:1|1st|I|First)(?:\\s)?S(?:amuel|am|m)",
        testament: "Old",
        chapters: [28, 36, 21, 22, 12, 21, 17, 22, 27, 27, 15, 25, 23, 52, 35, 23, 58, 30, 24, 42, 15, 23, 29, 22, 44, 25, 12, 25, 11, 31, 13]
      ),
      Book.new(
        id: 10,
        name: "2 Samuel",
        abbreviation: "2Sam",
        dbl_code: "2SA",
        regex: "(?:2|2nd|II|Second)(?:\\s)?S(?:amuel|am|m)",
        testament: "Old",
        chapters: [27, 32, 39, 12, 25, 23, 29, 18, 13, 19, 27, 31, 39, 33, 37, 23, 29, 33, 43, 26, 22, 51, 39, 25]
      ),
      Book.new(
        id: 11,
        name: "1 Kings",
        abbreviation: "1Kgs",
        dbl_code: "1KI",
        regex: "(?:1|I)(?:\\s)?K(?:in)?gs",
        testament: "Old",
        chapters: [53, 46, 28, 34, 18, 38, 51, 66, 28, 29, 43, 33, 34, 31, 34, 34, 24, 46, 21, 43, 29, 53]
      ),
      Book.new(
        id: 12,
        name: "2 Kings",
        abbreviation: "2Kgs",
        dbl_code: "2KI",
        regex: "(?:2|II)(?:\\s)?K(?:in)?gs",
        testament: "Old",
        chapters: [18, 25, 27, 44, 27, 33, 20, 29, 37, 36, 21, 21, 25, 29, 38, 20, 41, 37, 37, 21, 26, 20, 37, 20, 30]
      ),
      Book.new(
        id: 13,
        name: "1 Chronicles",
        abbreviation: "1Chr",
        dbl_code: "1CH",
        regex: "(?:1|I)(?:\\s)?Chr(?:on)?(?:icles)?",
        testament: "Old",
        chapters: [54, 55, 24, 43, 26, 81, 40, 40, 44, 14, 47, 40, 14, 17, 29, 43, 27, 17, 19, 8, 30, 19, 32, 31, 31, 32, 34, 21, 30]
      ),
      Book.new(
        id: 14,
        name: "2 Chronicles",
        abbreviation: "2Chr",
        dbl_code: "2CH",
        regex: "(?:2|II)(?:\\s)?Chr(?:on)?(?:icles)?",
        testament: "Old",
        chapters: [17, 18, 17, 22, 14, 42, 22, 18, 31, 19, 23, 16, 22, 15, 19, 14, 19, 34, 11, 37, 20, 12, 21, 27, 28, 23, 9, 27, 36, 27, 21, 33, 25, 33, 27, 23]
      ),
      Book.new(
        id: 15,
        name: "Ezra",
        abbreviation: "Ezra",
        dbl_code: "EZR",
        regex: "Ez(?:ra|r)",
        testament: "Old",
        chapters: [11, 70, 13, 24, 17, 22, 28, 36, 15, 44]
      ),
      Book.new(
        id: 16,
        name: "Nehemiah",
        abbreviation: "Neh",
        dbl_code: "NEH",
        regex: "Ne(?:hemiah|h)?",
        testament: "Old",
        chapters: [11, 20, 32, 23, 19, 19, 73, 18, 38, 39, 36, 47, 31]
      ),
      Book.new(
        id: 17,
        name: "Esther",
        abbreviation: "Esth",
        dbl_code: "EST",
        regex: "Es(?:ther|th|t|h)?",
        testament: "Old",
        chapters: [22, 23, 15, 17, 14, 14, 10, 17, 32, 3]
      ),
      Book.new(
        id: 18,
        name: "Job",
        abbreviation: "Job",
        dbl_code: "JOB",
        regex: "Jo?b",
        testament: "Old",
        chapters: [22, 13, 26, 21, 27, 30, 21, 22, 35, 22, 20, 25, 28, 22, 35, 22, 16, 21, 29, 29, 34, 30, 17, 25, 6, 14, 23, 28, 25, 31, 40, 22, 33, 37, 16, 33, 24, 41, 30, 24, 34, 17]
      ),
      Book.new(
        id: 19,
        name: "Psalms",
        abbreviation: "Ps",
        dbl_code: "PSA",
        regex: "Ps(?:alms|alm|s|m|a)?",
        testament: "Old",
        chapters: [6, 12, 8, 8, 12, 10, 17, 9, 20, 18, 7, 8, 6, 7, 5, 11, 15, 50, 14, 9, 13, 31, 6, 10, 22, 12, 14, 9, 11, 12, 24, 11, 22, 22, 28, 12, 40, 22, 13, 17, 13, 11, 5, 26, 17, 11, 9, 14, 20, 23, 19, 9, 6, 7, 23, 13, 11, 11, 17, 12, 8, 12, 11, 10, 13, 20, 7, 35, 36, 5, 24, 20, 28, 23, 10, 12, 20, 72, 13, 19, 16, 8, 18, 12, 13, 17, 7, 18, 52, 17, 16, 15, 5, 23, 11, 13, 12, 9, 9, 5, 8, 28, 22, 35, 45, 48, 43, 13, 31, 7, 10, 10, 9, 8, 18, 19, 2, 29, 176, 7, 8, 9, 4, 8, 5, 6, 5, 6, 8, 8, 3, 18, 3, 3, 21, 26, 9, 8, 24, 13, 10, 7, 12, 15, 21, 10, 20, 14, 9, 6]
      ),
      Book.new(
        id: 20,
        name: "Proverbs",
        abbreviation: "Prov",
        dbl_code: "PRO",
        regex: "Pr(?:overbs|ov|o|v)?",
        testament: "Old",
        chapters: [33, 22, 35, 27, 23, 35, 27, 36, 18, 32, 31, 28, 25, 35, 33, 33, 28, 24, 29, 30, 31, 29, 35, 34, 28, 28, 27, 28, 27, 33, 31]
      ),
      Book.new(
        id: 21,
        name: "Ecclesiastes",
        abbreviation: "Eccl",
        dbl_code: "ECC",
        regex: "Ec(?:clesiastes|cles|cle|c)?",
        testament: "Old",
        chapters: [18, 26, 22, 16, 20, 12, 29, 17, 18, 20, 10, 14]
      ),
      Book.new(
        id: 22,
        name: "Song of Solomon",
        abbreviation: "Song",
        dbl_code: "SNG",
        regex: "Song(?: of )?(?:Solomon|Songs)?",
        testament: "Old",
        chapters: [17, 17, 11, 16, 16, 13, 13, 14]
      ),
      Book.new(
        id: 23,
        name: "Isaiah",
        abbreviation: "Isa",
        dbl_code: "ISA",
        regex: "Is(?:a|aiah)?",
        testament: "Old",
        chapters: [31, 22, 26, 6, 30, 13, 25, 22, 21, 34, 16, 6, 22, 32, 9, 14, 14, 7, 25, 6, 17, 25, 18, 23, 12, 21, 13, 29, 24, 33, 9, 20, 24, 17, 10, 22, 38, 22, 8, 31, 29, 25, 28, 28, 25, 13, 15, 22, 26, 11, 23, 15, 12, 17, 13, 12, 21, 14, 21, 22, 11, 12, 19, 12, 25, 24]
      ),
      Book.new(
        id: 24,
        name: "Jeremiah",
        abbreviation: "Jer",
        dbl_code: "JER",
        regex: "J(?:eremiah|e|er|r)",
        testament: "Old",
        chapters: [19, 37, 25, 31, 31, 30, 34, 22, 26, 25, 23, 17, 27, 22, 21, 21, 27, 23, 15, 18, 14, 30, 40, 10, 38, 24, 22, 17, 32, 24, 40, 44, 26, 22, 19, 32, 21, 28, 18, 16, 18, 22, 13, 30, 5, 28, 7, 47, 39, 46, 64, 34]
      ),
      Book.new(
        id: 25,
        name: "Lamentations",
        abbreviation: "Lam",
        dbl_code: "LAM",
        regex: "Lam(?:entations)?",
        testament: "Old",
        chapters: [22, 22, 66, 22, 22]
      ),
      Book.new(
        id: 26,
        name: "Ezekiel",
        abbreviation: "Ezek",
        dbl_code: "EZK",
        regex: "Ezek(?:iel)?",
        testament: "Old",
        chapters: [28, 10, 27, 17, 17, 14, 27, 18, 11, 22, 25, 28, 23, 23, 8, 63, 24, 32, 14, 49, 32, 31, 49, 27, 17, 21, 36, 26, 21, 26, 18, 32, 33, 31, 15, 38, 28, 23, 29, 49, 26, 20, 27, 31, 25, 24, 23, 35]
      ),
      Book.new(
        id: 27,
        name: "Daniel",
        abbreviation: "Dan",
        dbl_code: "DAN",
        regex: "Dan(?:iel)?",
        testament: "Old",
        chapters: [21, 49, 30, 37, 31, 28, 28, 27, 27, 21, 45, 13]
      ),
      Book.new(
        id: 28,
        name: "Hosea",
        abbreviation: "Hos",
        dbl_code: "HOS",
        regex: "Hos(?:ea)?",
        testament: "Old",
        chapters: [11, 23, 5, 19, 15, 11, 16, 14, 17, 15, 12, 14, 16, 9]
      ),
      Book.new(
        id: 29,
        name: "Joel",
        abbreviation: "Joel",
        dbl_code: "JOL",
        regex: "Joel",
        testament: "Old",
        chapters: [20, 32, 21]
      ),
      Book.new(
        id: 30,
        name: "Amos",
        abbreviation: "Amos",
        dbl_code: "AMO",
        regex: "Amos",
        testament: "Old",
        chapters: [15, 16, 15, 13, 27, 14, 17, 14, 15]
      ),
      Book.new(
        id: 31,
        name: "Obadiah",
        abbreviation: "Obad",
        dbl_code: "OBA",
        regex: "Obad(?:iah)?",
        testament: "Old",
        chapters: [21]
      ),
      Book.new(
        id: 32,
        name: "Jonah",
        abbreviation: "Jonah",
        dbl_code: "JON",
        regex: "Jonah",
        testament: "Old",
        chapters: [17, 10, 10, 11]
      ),
      Book.new(
        id: 33,
        name: "Micah",
        abbreviation: "Mic",
        dbl_code: "MIC",
        regex: "Mic(?:ah)?",
        testament: "Old",
        chapters: [16, 13, 12, 13, 15, 16, 20]
      ),
      Book.new(
        id: 34,
        name: "Nahum",
        abbreviation: "Nah",
        dbl_code: "NAM",
        regex: "Nah(?:um)?",
        testament: "Old",
        chapters: [15, 13, 19]
      ),
      Book.new(
        id: 35,
        name: "Habakkuk",
        abbreviation: "Hab",
        dbl_code: "HAB",
        regex: "Hab(?:akkuk)?",
        testament: "Old",
        chapters: [17, 20, 19]
      ),
      Book.new(
        id: 36,
        name: "Zephaniah",
        abbreviation: "Zeph",
        dbl_code: "ZEP",
        regex: "Z(?:ephaniah|eph|ep|p)",
        testament: "Old",
        chapters: [18, 15, 20]
      ),
      Book.new(
        id: 37,
        name: "Haggai",
        abbreviation: "Hag",
        dbl_code: "HAG",
        regex: "Hag(?:gai)?",
        testament: "Old",
        chapters: [15, 23]
      ),
      Book.new(
        id: 38,
        name: "Zechariah",
        abbreviation: "Zech",
        dbl_code: "ZEC",
        regex: "Zech(?:ariah)?",
        testament: "Old",
        chapters: [21, 13, 10, 14, 11, 15, 14, 23, 17, 12, 17, 14, 9, 21]
      ),
      Book.new(
        id: 39,
        name: "Malachi",
        abbreviation: "Mal",
        dbl_code: "MAL",
        regex: "Mal(?:achi)?",
        testament: "Old",
        chapters: [14, 17, 18, 6]
      ),
      Book.new(
        id: 40,
        name: "Matthew",
        abbreviation: "Matt",
        dbl_code: "MAT",
        regex: "M(?:atthew|t|at|att)",
        testament: "New",
        chapters: [25, 23, 17, 25, 48, 34, 29, 34, 38, 42, 30, 50, 58, 36, 39, 28, 27, 35, 30, 34, 46, 46, 39, 51, 46, 75, 66, 20]
      ),
      Book.new(
        id: 41,
        name: "Mark",
        abbreviation: "Mark",
        dbl_code: "MRK",
        regex: "M(?:k|ark)",
        testament: "New",
        chapters: [45, 28, 35, 41, 43, 56, 37, 38, 50, 52, 33, 44, 37, 72, 47, 20]
      ),
      Book.new(
        id: 42,
        name: "Luke",
        abbreviation: "Luke",
        dbl_code: "LUK",
        regex: "(?:Luke|Lk)",
        testament: "New",
        chapters: [80, 52, 38, 44, 39, 49, 50, 56, 62, 42, 54, 59, 35, 35, 32, 31, 37, 43, 48, 47, 38, 71, 56, 53]
      ),
      Book.new(
        id: 43,
        name: "John",
        abbreviation: "John",
        dbl_code: "JHN",
        regex: "(?<!(?:1|2|3|I)\\s)(?<!(?:1|2|3|I))(?:John|Jn)",
        testament: "New",
        chapters: [51, 25, 36, 54, 47, 71, 53, 59, 41, 42, 57, 50, 38, 31, 27, 33, 26, 40, 42, 31, 25]
      ),
      Book.new(
        id: 44,
        name: "Acts",
        abbreviation: "Acts",
        dbl_code: "ACT",
        regex: "Acts",
        testament: "New",
        chapters: [26, 47, 26, 37, 42, 15, 60, 40, 43, 48, 30, 25, 52, 28, 41, 40, 34, 28, 41, 38, 40, 30, 35, 27, 27, 32, 44, 31]
      ),
      Book.new(
        id: 45,
        name: "Romans",
        abbreviation: "Rom",
        dbl_code: "ROM",
        regex: "(?:Rom|Rm)(?:ans)?",
        testament: "New",
        chapters: [32, 29, 31, 25, 21, 23, 25, 39, 33, 21, 36, 21, 14, 23, 33, 27]
      ),
      Book.new(
        id: 46,
        name: "1 Corinthians",
        abbreviation: "1Cor",
        dbl_code: "1CO",
        regex: "(?:1|I)(?:\\s)?Cor(?:inthians)?",
        testament: "New",
        chapters: [31, 16, 23, 21, 13, 20, 40, 13, 27, 33, 34, 31, 13, 40, 58, 24]
      ),
      Book.new(
        id: 47,
        name: "2 Corinthians",
        abbreviation: "2Cor",
        dbl_code: "2CO",
        regex: "(?:2|II)(?:\\s)?Cor(?:inthians)?",
        testament: "New",
        chapters: [24, 17, 18, 18, 21, 18, 16, 24, 15, 18, 33, 21, 14]
      ),
      Book.new(
        id: 48,
        name: "Galatians",
        abbreviation: "Gal",
        dbl_code: "GAL",
        regex: "Gal(?:atians)?",
        testament: "New",
        chapters: [24, 21, 29, 31, 26, 18]
      ),
      Book.new(
        id: 49,
        name: "Ephesians",
        abbreviation: "Eph",
        dbl_code: "EPH",
        regex: "Eph(?:esians)?",
        testament: "New",
        chapters: [23, 22, 21, 32, 33, 24]
      ),
      Book.new(
        id: 50,
        name: "Philippians",
        abbreviation: "Phil",
        dbl_code: "PHP",
        regex: "Phil(?!e)(?:ippians)?",
        testament: "New",
        chapters: [30, 30, 21, 23]
      ),
      Book.new(
        id: 51,
        name: "Colossians",
        abbreviation: "Col",
        dbl_code: "COL",
        regex: "Col(?:ossians)?",
        testament: "New",
        chapters: [29, 23, 25, 18]
      ),
      Book.new(
        id: 52,
        name: "1 Thessalonians",
        abbreviation: "1Thess",
        dbl_code: "1TH",
        regex: "(?:1|I)(?:\\s)?Thes(?:s)?(?:alonians)?",
        testament: "New",
        chapters: [10, 20, 13, 18, 28]
      ),
      Book.new(
        id: 53,
        name: "2 Thessalonians",
        abbreviation: "2Thess",
        dbl_code: "2TH",
        regex: "(?:2|II)(?:\\s)?Thes(?:s)?(?:alonians)?",
        testament: "New",
        chapters: [12, 17, 18]
      ),
      Book.new(
        id: 54,
        name: "1 Timothy",
        abbreviation: "1Tim",
        dbl_code: "1TI",
        regex: "(?:1|I)(?:\\s)?Tim(?:othy)?",
        testament: "New",
        chapters: [20, 15, 16, 16, 25, 21]
      ),
      Book.new(
        id: 55,
        name: "2 Timothy",
        abbreviation: "2Tim",
        dbl_code: "2TI",
        regex: "(?:2|II)(?:\\s)?Tim(?:othy)?",
        testament: "New",
        chapters: [18, 26, 17, 22]
      ),
      Book.new(
        id: 56,
        name: "Titus",
        abbreviation: "Titus",
        dbl_code: "TIT",
        regex: "Tit(?:us)?",
        testament: "New",
        chapters: [16, 15, 15]
      ),
      Book.new(
        id: 57,
        name: "Philemon",
        abbreviation: "Philem",
        dbl_code: "PHM",
        regex: "Philem(?:on)?",
        testament: "New",
        chapters: [25]
      ),
      Book.new(
        id: 58,
        name: "Hebrews",
        abbreviation: "Heb",
        dbl_code: "HEB",
        regex: "Heb(?:rews)?",
        testament: "New",
        chapters: [14, 18, 19, 16, 14, 20, 28, 13, 28, 39, 40, 29, 25]
      ),
      Book.new(
        id: 59,
        name: "James",
        abbreviation: "Jas",
        dbl_code: "JAS",
        regex: "Ja(?:me)?s",
        testament: "New",
        chapters: [27, 26, 18, 17, 20]
      ),
      Book.new(
        id: 60,
        name: "1 Peter",
        abbreviation: "1Pet",
        dbl_code: "1PE",
        regex: "(?:1|I)(?:\\s)?Pet(?:er)?",
        testament: "New",
        chapters: [25, 25, 22, 19, 14]
      ),
      Book.new(
        id: 61,
        name: "2 Peter",
        abbreviation: "2Pet",
        dbl_code: "2PE",
        regex: "(?:2|II)(?:\\s)?Pet(?:er)?",
        testament: "New",
        chapters: [21, 22, 18]
      ),
      Book.new(
        id: 62,
        name: "1 John",
        abbreviation: "1John",
        dbl_code: "1JN",
        regex: "(?:(?:1|I)(?:\\s)?)(?:John|Jn)",
        testament: "New",
        chapters: [10, 29, 24, 21, 21]
      ),
      Book.new(
        id: 63,
        name: "2 John",
        abbreviation: "2John",
        dbl_code: "2JN",
        regex: "(?:(?:2|II)(?:\\s)?)(?:John|Jn)",
        testament: "New",
        chapters: [13]
      ),
      Book.new(
        id: 64,
        name: "3 John",
        abbreviation: "3John",
        dbl_code: "3JN",
        regex: "(?:(?:3|III)(?:\\s)?)(?:John|Jn)",
        testament: "New",
        chapters: [15]
      ),
      Book.new(
        id: 65,
        name: "Jude",
        abbreviation: "Jude",
        dbl_code: "JUD",
        regex: "Jude",
        testament: "New",
        chapters: [25]
      ),
      Book.new(
        id: 66,
        name: "Revelation",
        abbreviation: "Rev",
        dbl_code: "REV",
        regex: "Rev(?:elation)?(?:\\sof Jesus Christ)?",
        testament: "New",
        chapters: [20, 29, 22, 11, 14, 17, 17, 13, 21, 11, 19, 17, 18, 20, 8, 21, 18, 24, 21, 15, 27, 21]
      )
    ]

    @@apocryphal_books = [
      Book.new(
        id: 101,
        name: "Tobit",
        abbreviation: "Tob",
        dbl_code: "TOB",
        regex: "(?:(Tb|Tob|Tobit))",
        testament: "Apocrypha",
        chapters: [22, 14, 17, 21, 22, 18, 18, 21, 6, 13, 18, 22, 18, 15],
      ),
      Book.new(
        id: 102,
        name: "Judith",
        abbreviation: "Jth",
        dbl_code: "JDT",
        regex: "(?:(Jdt|Jth|Jdth|Judith))",
        testament: "Apocrypha",
        chapters: [16, 28, 10, 15, 24, 21, 32, 36, 14, 23, 23, 20, 20, 19, 14, 25],
      ),
      Book.new(
        id: 103,
        name: "Additions to Esther",
        abbreviation: "Add Esth",
        dbl_code: "ESG",
        regex: "(?:(Add(itions)?(\\sto)?|(The\\s)?Rest\\sof|A)\\s*Est?h?e?r?)",
        testament: "Apocrypha",
        chapters: [39, 23, 22, 47, 28, 14, 10, 41, 32, 14],
      ),
      Book.new(
        id: 104,
        name: "Wisdom of Solomon",
        abbreviation: "Wis",
        dbl_code: "WIS",
        regex: "(?:(Wi?sd?(om)?(\\sof\\s)?(Sol|Solomon)?))",
        testament: "Apocrypha",
        chapters: [16, 24, 19, 20, 23, 25, 30, 21, 18, 21, 26, 27, 19, 31, 19, 29, 21, 25, 22],
      ),
      Book.new(
        id: 105,
        name: "Sirach", # a.k.a. Ecclesiasticus
        abbreviation: "Sir",
        dbl_code: "SIR",
        regex: "(?:(Sir(?:ach)?)|Ecclus|Ecclesiasticus)",
        testament: "Apocrypha",
        chapters: [29, 18, 30, 31, 17, 37, 36, 19, 18, 30, 34, 18, 25, 27, 20, 28, 27, 33, 26, 30, 28, 27, 27, 31, 25, 20, 30, 26, 28, 25, 31, 24, 33, 26, 24, 27, 30, 34, 35, 30, 24, 25, 35, 23, 26, 20, 25, 25, 16, 29, 30],
      ),
      Book.new(
        id: 106,
        name: "Baruch",
        abbreviation: "Bar",
        dbl_code: "BAR",
        regex: "(?:Bar(?:uch)?)",
        testament: "Apocrypha",
        chapters: [22, 35, 38, 37, 9],
      ),
      Book.new(
        id: 107,
        name: "Letter of Jeremiah", # Often placed as Baruch 6, but sometimes stands alone
        abbreviation: "Ep Jer",
        dbl_code: "LJE",
        regex: "(?:(Letter of Jeremiah|Ep Jer|Let Jer|Ltr Jer|LJe))",
        testament: "Apocrypha",
        chapters: [73],
      ),
      Book.new(
        id: 108,
        name: "Prayer of Azariah and the Song of the Three Jews", # An extension of Daniel 3... a.k.a. Prayer of Azariah
        abbreviation: "Sg of 3 Childr",
        dbl_code: "S3Y",
        regex: "(?:(?:Pr\\sAz|Prayer\\sof\\sAzariah|Azariah|(?:The\\s)?So?n?g\\s(?:of\\s)?(?:the\\s)?(?:3|Three|Thr)(?:\\s(?:Holy|Young)?\\s*(?:Childr(?:en)?|Jews))?))",
        testament: "Apocrypha",
        chapters: [68],
      ),
      Book.new(
        id: 109,
        name: "Susanna", # A book of Daniel
        abbreviation: "Sus",
        dbl_code: "SUS",
        regex: "(?:Sus(?:anna)?)",
        testament: "Apocrypha",
        chapters: [64],
      ),
      Book.new(
        id: 110,
        name: "Bel and the Dragon", # A book of Daniel
        abbreviation: "Bel and Dr",
        dbl_code: "BEL",
        regex: "(?:Bel(\\s(and\\sthe\\sDragon|and\\sDr))?)",
        testament: "Apocrypha",
        chapters: [42],
      ),
      Book.new(
        id: 111,
        name: "1 Maccabees",
        abbreviation: "1 Macc",
        dbl_code: "1MA",
        regex: "(?:(1|1st|I|First)\\s*(M|Ma|Mac|Macc|Maccabees))",
        testament: "Apocrypha",
        chapters: [63, 70, 59, 61, 68, 63, 50, 32, 73, 89, 74, 53, 53, 49, 41, 24],
      ),
      Book.new(
        id: 112,
        name: "2 Maccabees",
        abbreviation: "2 Macc",
        dbl_code: "2MA",
        regex: "(?:(2|2nd|II|Second)\\s*(M|Ma|Mac|Macc|Maccabees))",
        testament: "Apocrypha",
        chapters: [36, 32, 40, 50, 27, 31, 42, 36, 29, 38, 38, 46, 26, 46, 39],
      ),
      Book.new(
        id: 113,
        name: "1 Esdras",
        abbreviation: "1 Esd",
        dbl_code: "1ES",
        regex: "(?:(1|1st|I|First)\\s*(Esd|Esdr|Esdras))",
        testament: "Apocrypha",
        chapters: [58, 30, 24, 63, 73, 34, 15, 96, 55],
      ),
      Book.new(
        id: 114,
        name: "Prayer of Manasseh",
        abbreviation: "Pr of Man",
        dbl_code: "MAN",
        regex: "(?:(Prayer\\sof\\sManasseh|Pr\\sof\\sMan|PMa|Prayer\\sof\\sManasses))",
        testament: "Apocrypha",
        chapters: [15],
      ),
      Book.new(
        id: 115,
        name: "Psalm 151",
        abbreviation: "Psalm 151",
        dbl_code: "PS2",
        regex: "(?:Ps(?:alms|alm|s|m|a)?\\s151)",
        testament: "Apocrypha",
        chapters: [7],
      ),
      Book.new(
        id: 116,
        name: "3 Maccabees",
        abbreviation: "3 Macc",
        dbl_code: "3MA",
        regex: "(?:(3|3rd|III|Third)\\s*(M|Ma|Mac|Macc|Maccabees))",
        testament: "Apocrypha",
        chapters: [29, 33, 30, 21, 51, 41, 23],
      ),
      Book.new(
        id: 117,
        name: "2 Esdras",
        abbreviation: "2 Esd",
        dbl_code: "2ES",
        regex: "(?:(2|2nd|II|Second)\\s*(Esd|Esdr|Esdras))",
        testament: "Apocrypha",
        chapters: [40, 48, 36, 52, 56, 59, 140, 63, 47, 59, 46, 51, 58, 48, 63, 78],
      ),
      Book.new(
        id: 118,
        name: "4 Maccabees",
        abbreviation: "4 Macc",
        dbl_code: "4MA",
        regex: "(?:(4|4th|IV|Fourth)\\s*(M|Ma|Mac|Macc|Maccabees))",
        testament: "Apocrypha",
        chapters: [35, 24, 21, 26, 38, 35, 23, 29, 32, 21, 27, 19, 27, 20, 32, 25, 24, 24],
      ),
    ]

    def self.books
      if BibleBot.include_apocryphal_content?
        # Apocryphal books have to come first, since there's some overlap in the regex, but
        # the apocryphal books are more verbose. "Song", "Esther", "Psalm"
        @@apocryphal_books + @@books
      else
        @@books
      end
    end

    # assemble the book regex
    def self.book_re_string
      @@book_re_string ||= Bible.books.map(&:regex).join('|')
    end

    # compiled book regular expression
    def self.book_re
      @@book_re ||= Regexp.new(book_re_string, Regexp::IGNORECASE)
    end

    # compiled scripture reference regular expression
    def self.scripture_re
      @@scripture_re ||= Regexp.new(
        sprintf('\b' +
         '(?<BookTitle>%s)' +
         '[\s\.]*' +
         '(?<ChapterNumber>\d{1,3})' +
         '(?:\s*[:\.]\s*' +
         '(?<VerseNumber>\d{1,3})\w?)?' +
         '(?:\s*-\s*' +
           '(?<EndBookTitle>%s)?[\s\.]*' +
           '(?<EndChapterNumber>\d{1,3})?' +
           '(?:\s*[:\.]\s*)?' +
           '(?<EndVerseNumber>\d{1,3})?' +
         ')?', book_re_string, book_re_string), Regexp::IGNORECASE)
    end

    def self.reset_regular_expressions
      @@book_re_string = nil
      @@book_re = nil
      @@scripture_re = nil
    end
  end
end
