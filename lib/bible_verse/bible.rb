module BibleVerse
  class Bible
    BOOKS = [
      {
        id: 1,
        display_name: "Genesis",
        abbreviation: "Gen",
        regex: "Gen(?:esis)?",
        chapters: [31, 25, 24, 26, 32, 22, 24, 22, 29, 32, 32, 20, 18, 24, 21, 16, 27, 33, 38, 18, 34, 24, 20, 67, 34, 35, 46, 22, 35, 43, 55, 32, 20, 31, 29, 43, 36, 30, 23, 23, 57, 38, 34, 34, 28, 34, 31, 22, 33, 26]
      }, 
      {
        id: 2,
        display_name: "Exodus",
        abbreviation: "Exod",
        regex: "Exod(?:us)?",
        chapters: [22, 25, 22, 31, 23, 30, 25, 32, 35, 29, 10, 51, 22, 31, 27, 36, 16, 27, 25, 26, 36, 31, 33, 18, 40, 37, 21, 43, 46, 38, 18, 35, 23, 35, 35, 38, 29, 31, 43, 38]
      }, 
      {
        id: 3,
        display_name: "Leviticus",
        abbreviation: "Lev",
        regex: "Lev(?:iticus)?",
        chapters: [17, 16, 17, 35, 19, 30, 38, 36, 24, 20, 47, 8, 59, 57, 33, 34, 16, 30, 37, 27, 24, 33, 44, 23, 55, 46, 34]
      }, 
      {
        id: 4,
        display_name: "Numbers",
        abbreviation: "Num",
        regex: "Num(?:bers)?",
        chapters: [54, 34, 51, 49, 31, 27, 89, 26, 23, 36, 35, 16, 33, 45, 41, 50, 13, 32, 22, 29, 35, 41, 30, 25, 18, 65, 23, 31, 40, 16, 54, 42, 56, 29, 34, 13]
      }, 
      {
        id: 5,
        display_name: "Deuteronomy",
        abbreviation: "Deut",
        regex: "Deut(?:eronomy)?",
        chapters: [46, 37, 29, 49, 33, 25, 26, 20, 29, 22, 32, 32, 18, 29, 23, 22, 20, 22, 21, 20, 23, 30, 25, 22, 19, 19, 26, 68, 29, 20, 30, 52, 29, 12]
      }, 
      {
        id: 6,
        display_name: "Joshua",
        abbreviation: "Josh",
        regex: "Josh(?:ua)?",
        chapters: [18, 24, 17, 24, 15, 27, 26, 35, 27, 43, 23, 24, 33, 15, 63, 10, 18, 28, 51, 9, 45, 34, 16, 33]
      }, 
      {
        id: 7,
        display_name: "Judges",
        abbreviation: "Judg",
        regex: "Judg(?:es)?",
        chapters: [36, 23, 31, 24, 31, 40, 25, 35, 57, 18, 40, 15, 25, 20, 20, 31, 13, 31, 30, 48, 25]
      }, 
      {
        id: 8,
        display_name: "Ruth",
        abbreviation: "Ruth",
        regex: "Ruth",
        chapters: [22, 23, 18, 22]
      }, 
      {
        id: 9,
        display_name: "1 Samuel",
        abbreviation: "1Sam",
        regex: "(?:1|I)(?:\\s)?Sam(?:uel)?",
        chapters: [28, 36, 21, 22, 12, 21, 17, 22, 27, 27, 15, 25, 23, 52, 35, 23, 58, 30, 24, 42, 15, 23, 29, 22, 44, 25, 12, 25, 11, 31, 13]
      }, 
      {
        id: 10,
        display_name: "2 Samuel",
        abbreviation: "2Sam",
        regex: "(?:2|II)(?:\\s)?Sam(?:uel)?",
        chapters: [27, 32, 39, 12, 25, 23, 29, 18, 13, 19, 27, 31, 39, 33, 37, 23, 29, 33, 43, 26, 22, 51, 39, 25]
      }, 
      {
        id: 11,
        display_name: "1 Kings",
        abbreviation: "1Kgs",
        regex: "(?:1|I)(?:\\s)?K(?:in)?gs",
        chapters: [53, 46, 28, 34, 18, 38, 51, 66, 28, 29, 43, 33, 34, 31, 34, 34, 24, 46, 21, 43, 29, 53]
      }, 
      {
        id: 12,
        display_name: "2 Kings",
        abbreviation: "2Kgs",
        regex: "(?:2|II)(?:\\s)?K(?:in)?gs",
        chapters: [18, 25, 27, 44, 27, 33, 20, 29, 37, 36, 21, 21, 25, 29, 38, 20, 41, 37, 37, 21, 26, 20, 37, 20, 30]
      }, 
      {
        id: 13,
        display_name: "1 Chronicles",
        abbreviation: "1Chr",
        regex: "(?:1|I)(?:\\s)?Chr(?:o)?(?:nicles)?",
        chapters: [54, 55, 24, 43, 26, 81, 40, 40, 44, 14, 47, 40, 14, 17, 29, 43, 27, 17, 19, 8, 30, 19, 32, 31, 31, 32, 34, 21, 30]
      }, 
      {
        id: 14,
        display_name: "2 Chronicles",
        abbreviation: "2Chr",
        regex: "(?:2|II)(?:\\s)?Chr(?:o)?(?:nicles)?",
        chapters: [17, 18, 17, 22, 14, 42, 22, 18, 31, 19, 23, 16, 22, 15, 19, 14, 19, 34, 11, 37, 20, 12, 21, 27, 28, 23, 9, 27, 36, 27, 21, 33, 25, 33, 27, 23]
      }, 
      {
        id: 15,
        display_name: "Ezra",
        abbreviation: "Ezra",
        regex: "Ezra",
        chapters: [11, 70, 13, 24, 17, 22, 28, 36, 15, 44]
      }, 
      {
        id: 16,
        display_name: "Nehemiah",
        abbreviation: "Neh",
        regex: "Neh(?:emiah)?",
        chapters: [11, 20, 32, 23, 19, 19, 73, 18, 38, 39, 36, 47, 31]
      }, 
      {
        id: 17,
        display_name: "Esther",
        abbreviation: "Esth",
        regex: "Esth(?:er)?",
        chapters: [22, 23, 15, 17, 14, 14, 10, 17, 32, 3]
      }, 
      {
        id: 18,
        display_name: "Job",
        abbreviation: "Job",
        regex: "Job",
        chapters: [22, 13, 26, 21, 27, 30, 21, 22, 35, 22, 20, 25, 28, 22, 35, 22, 16, 21, 29, 29, 34, 30, 17, 25, 6, 14, 23, 28, 25, 31, 40, 22, 33, 37, 16, 33, 24, 41, 30, 24, 34, 17]
      }, 
      {
        id: 19,
        display_name: "Psalms",
        abbreviation: "Ps",
        regex: "Ps(?:a)?(?:lm)?",
        chapters: [6, 12, 8, 8, 12, 10, 17, 9, 20, 18, 7, 8, 6, 7, 5, 11, 15, 50, 14, 9, 13, 31, 6, 10, 22, 12, 14, 9, 11, 12, 24, 11, 22, 22, 28, 12, 40, 22, 13, 17, 13, 11, 5, 26, 17, 11, 9, 14, 20, 23, 19, 9, 6, 7, 23, 13, 11, 11, 17, 12, 8, 12, 11, 10, 13, 20, 7, 35, 36, 5, 24, 20, 28, 23, 10, 12, 20, 72, 13, 19, 16, 8, 18, 12, 13, 17, 7, 18, 52, 17, 16, 15, 5, 23, 11, 13, 12, 9, 9, 5, 8, 28, 22, 35, 45, 48, 43, 13, 31, 7, 10, 10, 9, 8, 18, 19, 2, 29, 176, 7, 8, 9, 4, 8, 5, 6, 5, 6, 8, 8, 3, 18, 3, 3, 21, 26, 9, 8, 24, 13, 10, 7, 12, 15, 21, 10, 20, 14, 9, 6]
      }, 
      {
        id: 20,
        display_name: "Proverbs",
        abbreviation: "Prov",
        regex: "Prov(?:erbs)?",
        chapters: [33, 22, 35, 27, 23, 35, 27, 36, 18, 32, 31, 28, 25, 35, 33, 33, 28, 24, 29, 30, 31, 29, 35, 34, 28, 28, 27, 28, 27, 33, 31]
      }, 
      {
        id: 21,
        display_name: "Ecclesiastes",
        abbreviation: "Eccl",
        regex: "Ecc(?:l)?(?:esiastes)?",
        chapters: [18, 26, 22, 16, 20, 12, 29, 17, 18, 20, 10, 14]
      }, 
      {
        id: 22,
        display_name: "Song of Solomon",
        abbreviation: "Song",
        regex: "Song(?: of Solomon)?",
        chapters: [17, 17, 11, 16, 16, 13, 13, 14]
      }, 
      {
        id: 23,
        display_name: "Isaiah",
        abbreviation: "Isa",
        regex: "Isa(?:iah)?",
        chapters: [31, 22, 26, 6, 30, 13, 25, 22, 21, 34, 16, 6, 22, 32, 9, 14, 14, 7, 25, 6, 17, 25, 18, 23, 12, 21, 13, 29, 24, 33, 9, 20, 24, 17, 10, 22, 38, 22, 8, 31, 29, 25, 28, 28, 25, 13, 15, 22, 26, 11, 23, 15, 12, 17, 13, 12, 21, 14, 21, 22, 11, 12, 19, 12, 25, 24]
      }, 
      {
        id: 24,
        display_name: "Jeremiah",
        abbreviation: "Jer",
        regex: "Jer(?:emiah)?",
        chapters: [19, 37, 25, 31, 31, 30, 34, 22, 26, 25, 23, 17, 27, 22, 21, 21, 27, 23, 15, 18, 14, 30, 40, 10, 38, 24, 22, 17, 32, 24, 40, 44, 26, 22, 19, 32, 21, 28, 18, 16, 18, 22, 13, 30, 5, 28, 7, 47, 39, 46, 64, 34]
      }, 
      {
        id: 25,
        display_name: "Lamentations",
        abbreviation: "Lam",
        regex: "Lam(?:entations)?",
        chapters: [22, 22, 66, 22, 22]
      }, 
      {
        id: 26,
        display_name: "Ezekiel",
        abbreviation: "Ezek",
        regex: "Ezek(?:iel)?",
        chapters: [28, 10, 27, 17, 17, 14, 27, 18, 11, 22, 25, 28, 23, 23, 8, 63, 24, 32, 14, 49, 32, 31, 49, 27, 17, 21, 36, 26, 21, 26, 18, 32, 33, 31, 15, 38, 28, 23, 29, 49, 26, 20, 27, 31, 25, 24, 23, 35]
      }, 
      {
        id: 27,
        display_name: "Daniel",
        abbreviation: "Dan",
        regex: "Dan(?:iel)?",
        chapters: [21, 49, 30, 37, 31, 28, 28, 27, 27, 21, 45, 13]
      }, 
      {
        id: 28,
        display_name: "Hosea",
        abbreviation: "Hos",
        regex: "Hos(?:ea)?",
        chapters: [11, 23, 5, 19, 15, 11, 16, 14, 17, 15, 12, 14, 16, 9]
      }, 
      {
        id: 29,
        display_name: "Joel",
        abbreviation: "Joel",
        regex: "Joel",
        chapters: [20, 32, 21]
      }, 
      {
        id: 30,
        display_name: "Amos",
        abbreviation: "Amos",
        regex: "Amos",
        chapters: [15, 16, 15, 13, 27, 14, 17, 14, 15]
      }, 
      {
        id: 31,
        display_name: "Obadiah",
        abbreviation: "Obad",
        regex: "Obad(?:iah)?",
        chapters: [21]
      }, 
      {
        id: 32,
        display_name: "Jonah",
        abbreviation: "Jonah",
        regex: "Jonah",
        chapters: [17, 10, 10, 11]
      }, 
      {
        id: 33,
        display_name: "Micah",
        abbreviation: "Mic",
        regex: "Mic(?:ah)?",
        chapters: [16, 13, 12, 13, 15, 16, 20]
      }, 
      {
        id: 34,
        display_name: "Nahum",
        abbreviation: "Nah",
        regex: "Nah(?:um)?",
        chapters: [15, 13, 19]
      }, 
      {
        id: 35,
        display_name: "Habakkuk",
        abbreviation: "Hab",
        regex: "Hab(?:akkuk)?",
        chapters: [17, 20, 19]
      }, 
      {
        id: 36,
        display_name: "Zephaniah",
        abbreviation: "Zeph",
        regex: "Zeph(?:aniah)?",
        chapters: [18, 15, 20]
      }, 
      {
        id: 37,
        display_name: "Haggai",
        abbreviation: "Hag",
        regex: "Hag(?:gai)?",
        chapters: [15, 23]
      }, 
      {
        id: 38,
        display_name: "Zechariah",
        abbreviation: "Zech",
        regex: "Zech(?:ariah)?",
        chapters: [21, 13, 10, 14, 11, 15, 14, 23, 17, 12, 17, 14, 9, 21]
      }, 
      {
        id: 39,
        display_name: "Malachi",
        abbreviation: "Mal",
        regex: "Mal(?:achi)?",
        chapters: [14, 17, 18, 6]
      }, 
      {
        id: 40,
        display_name: "Matthew",
        abbreviation: "Matt",
        regex: "Matt(?:hew)?",
        chapters: [25, 23, 17, 25, 48, 34, 29, 34, 38, 42, 30, 50, 58, 36, 39, 28, 27, 35, 30, 34, 46, 46, 39, 51, 46, 75, 66, 20]
      }, 
      {
        id: 41,
        display_name: "Mark",
        abbreviation: "Mark",
        regex: "Mark",
        chapters: [45, 28, 35, 41, 43, 56, 37, 38, 50, 52, 33, 44, 37, 72, 47, 20]
      }, 
      {
        id: 42,
        display_name: "Luke",
        abbreviation: "Luke",
        regex: "Luke",
        chapters: [80, 52, 38, 44, 39, 49, 50, 56, 62, 42, 54, 59, 35, 35, 32, 31, 37, 43, 48, 47, 38, 71, 56, 53]
      }, 
      {
        id: 43,
        display_name: "John",
        abbreviation: "John",
        regex: "(?<!(?:1|2|3|I)\\s)(?<!(?:1|2|3|I))John",
        chapters: [51, 25, 36, 54, 47, 71, 53, 59, 41, 42, 57, 50, 38, 31, 27, 33, 26, 40, 42, 31, 25]
      }, 
      {
        id: 44,
        display_name: "Acts",
        abbreviation: "Acts",
        regex: "Acts",
        chapters: [26, 47, 26, 37, 42, 15, 60, 40, 43, 48, 30, 25, 52, 28, 41, 40, 34, 28, 41, 38, 40, 30, 35, 27, 27, 32, 44, 31]
      }, 
      {
        id: 45,
        display_name: "Romans",
        abbreviation: "Rom",
        regex: "Rom(?:ans)?",
        chapters: [32, 29, 31, 25, 21, 23, 25, 39, 33, 21, 36, 21, 14, 23, 33, 27]
      }, 
      {
        id: 46,
        display_name: "1 Corinthians",
        abbreviation: "1Cor",
        regex: "(?:1|I)(?:\\s)?Cor(?:inthians)?",
        chapters: [31, 16, 23, 21, 13, 20, 40, 13, 27, 33, 34, 31, 13, 40, 58, 24]
      }, 
      {
        id: 47,
        display_name: "2 Corinthians",
        abbreviation: "2Cor",
        regex: "(?:2|II)(?:\\s)?Cor(?:inthians)?",
        chapters: [24, 17, 18, 18, 21, 18, 16, 24, 15, 18, 33, 21, 14]
      }, 
      {
        id: 48,
        display_name: "Galatians",
        abbreviation: "Gal",
        regex: "Gal(?:atians)?",
        chapters: [24, 21, 29, 31, 26, 18]
      }, 
      {
        id: 49,
        display_name: "Ephesians",
        abbreviation: "Eph",
        regex: "Eph(?:esians)?",
        chapters: [23, 22, 21, 32, 33, 24]
      }, 
      {
        id: 50,
        display_name: "Philippians",
        abbreviation: "Phil",
        regex: "Phil(?:ippians)?",
        chapters: [30, 30, 21, 23]
      }, 
      {
        id: 51,
        display_name: "Colossians",
        abbreviation: "Col",
        regex: "Col(?:ossians)?",
        chapters: [29, 23, 25, 18]
      }, 
      {
        id: 52,
        display_name: "1 Thessalonians",
        abbreviation: "1Thess",
        regex: "(?:1|I)(?:\\s)?Thess(?:alonians)?",
        chapters: [10, 20, 13, 18, 28]
      }, 
      {
        id: 53,
        display_name: "2 Thessalonians",
        abbreviation: "2Thess",
        regex: "(?:2|II)(?:\\s)?Thess(?:alonians)?",
        chapters: [12, 17, 18]
      }, 
      {
        id: 54,
        display_name: "1 Timothy",
        abbreviation: "1Tim",
        regex: "(?:1|I)(?:\\s)?Tim(?:othy)?",
        chapters: [20, 15, 16, 16, 25, 21]
      }, 
      {
        id: 55,
        display_name: "2 Timothy",
        abbreviation: "2Tim",
        regex: "(?:2|II)(?:\\s)?Tim(?:othy)?",
        chapters: [18, 26, 17, 22]
      }, 
      {
        id: 56,
        display_name: "Titus",
        abbreviation: "Titus",
        regex: "Tit(?:us)?",
        chapters: [16, 15, 15]
      }, 
      {
        id: 57,
        display_name: "Philemon",
        abbreviation: "Phlm",
        regex: "Phile(?:mon)?",
        chapters: [25]
      }, 
      {
        id: 58,
        display_name: "Hebrews",
        abbreviation: "Heb",
        regex: "Heb(?:rews)?",
        chapters: [14, 18, 19, 16, 14, 20, 28, 13, 28, 39, 40, 29, 25]
      }, 
      {
        id: 59,
        display_name: "James",
        abbreviation: "Jas",
        regex: "Ja(?:me)?s",
        chapters: [27, 26, 18, 17, 20]
      }, 
      {
        id: 60,
        display_name: "1 Peter",
        abbreviation: "1Pet",
        regex: "(?:1|I)(?:\\s)?Pet(?:er)?",
        chapters: [25, 25, 22, 19, 14]
      }, 
      {
        id: 61,
        display_name: "2 Peter",
        abbreviation: "2Pet",
        regex: "(?:2|II)(?:\\s)?Pet(?:er)?",
        chapters: [21, 22, 18]
      }, 
      {
        id: 62,
        display_name: "1 John",
        abbreviation: "1John",
        regex: "(?:(?:1|I)(?:\\s)?)John",
        chapters: [10, 29, 24, 21, 21]
      }, 
      {
        id: 63,
        display_name: "2 John",
        abbreviation: "2John",
        regex: "(?:(?:2|II)(?:\\s)?)John",
        chapters: [13]
      }, 
      {
        id: 64,
        display_name: "3 John",
        abbreviation: "3John",
        regex: "(?:(?:3|III)(?:\\s)?)John",
        chapters: [14]
      }, 
      {
        id: 65,
        display_name: "Jude",
        abbreviation: "Jude",
        regex: "Jude",
        chapters: [25]
      }, 
      {
        id: 66,
        display_name: "Revelation of Jesus Christ",
        abbreviation: "Rev",
        regex: "Rev(?:elation)?(?:\\sof Jesus Christ)?",
        chapters: [20, 29, 22, 11, 14, 17, 17, 13, 21, 11, 19, 17, 18, 20, 8, 21, 18, 24, 21, 15, 27, 21]
      }
    ]

  
  
    def initialize
      # assemble the book regex
      @@book_re_string = get_book_re_string
    
      # compiled book regular expression
      @@book_re = Regexp.new(@@book_re_string, Regexp::IGNORECASE)
    
      # compiled scripture reference regular expression
      @@scripture_re = Regexp.new(
          sprintf('\b(?<BookTitle>%s)[\s\.]*' +
           '(?<ChapterNumber>\d{1,3})' +
           '(?:\s*[:\.]\s*(?<VerseNumber>\d{1,3}))?' +
           '(?:\s*-\s*' +
           '(?<BookTitleSecond>%s)?[\s\.]*' +
           '(?<EndChapterNumber>\d{1,3}(?=\s*[:\.]\s*))?' +
           '(?:\s*[:\.]\s*)?' +
           '(?<EndVerseNumber>\d{1,3})?' +
           ')?', @@book_re_string, @@book_re_string), Regexp::IGNORECASE) 
    end

    def book_re_string
      @@book_re_string
    end

    def book_re
      @@book_re
    end

    def scripture_re
      @@scripture_re
    end

    def get_book_re_string
      # Get a regular expression string that will match any book of the Bible
      r=''
      BOOKS.each do |b|
        r += sprintf('%s|', b[:regex])
      end
      return r
    end
  end  
end