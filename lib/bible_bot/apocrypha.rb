module BibleBot
  # Defines Books and Regular Expressions used for parsing and other logic in this gem.
  class Apocrypha

    # Using this list to inform some of the Abbreviation decisions: https://www.logos.com/bible-book-abbreviations
    @@books = [
      Book.new(
        id: 101,
        name: "Tobit",
        abbreviation: "Tob",
        regex: "(?:To?bi?t?)",
        testament: "",
        chapters: [22, 14, 17, 21, 22, 18, 17, 21, 6, 14, 18, 22, 18, 15],
        bible: false,
        apocrypha: true
      ),
      Book.new(
        id: 102,
        name: "Judith",
        abbreviation: "Jth",
        regex: "(?:Ju?d?i?th?)",
        testament: "",
        chapters: [16, 28, 10, 15, 24, 21, 32, 36, 14, 23, 23, 20, 20, 19, 14, 25],
        bible: false,
        apocrypha: true
      ),
      Book.new(
        id: 103,
        name: "Additions to Esther",
        abbreviation: "Add Esth",
        regex: "(?:((Add\s?|(The\s)?Rest\sof\s|A))Est?h?e?r?)",
        testament: "",
        chapters: [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 17, 8, 30, 16, 24, 10],
        bible: false,
        apocrypha: true
      ),
      Book.new(
        id: 104,
        name: "Wisdom of Solomon",
        abbreviation: "Wis",
        regex: "(?:(Wi?sd?\.?(\sof\s)?(Sol|om)?))",
        testament: "",
        chapters: [16, 24, 19, 20, 23, 25, 30, 21, 18, 21, 26, 27, 19, 31, 19, 29, 21, 25, 22],
        bible: false,
        apocrypha: true
      ),
      Book.new(
        id: 105,
        name: "Sirach", # a.k.a. Ecclesiasticus
        abbreviation: "Sir",
        regex: "(?:(Sir))",
        testament: "",
        chapters: [29, 18, 30, 31, 17, 37, 36, 19, 18, 30, 34, 18, 25, 27, 20, 28, 27, 33, 26, 30, 28, 27, 27, 31, 25, 20, 30, 26, 28, 25, 31, 24, 33, 26, 24, 27, 30, 34, 35, 30, 24, 25, 35, 23, 26, 20, 25, 25, 16, 29, 30],
        bible: false,
        apocrypha: true
      ),
      Book.new(
        id: 106,
        name: "Ecclesiasticus", # a.k.a. Sirach
        abbreviation: "Ecclus",
        regex: "(?:(Eccle?u?s))",
        testament: "",
        chapters: [29, 18, 30, 31, 17, 37, 36, 19, 18, 30, 34, 18, 25, 27, 20, 28, 27, 33, 26, 30, 28, 27, 27, 31, 25, 20, 30, 26, 28, 25, 31, 24, 33, 26, 24, 27, 30, 34, 35, 30, 24, 25, 35, 23, 26, 20, 25, 25, 16, 29, 30],
        bible: false,
        apocrypha: true
      ),
      Book.new(
        id: 107,
        name: "Baruch",
        abbreviation: "Bar",
        regex: "(?:(Bar))",
        testament: "",
        chapters: [22, 35, 38, 37, 9, 72],
        bible: false,
        apocrypha: true
      ),
      Book.new(
        id: 108,
        name: "Letter of Jeremiah", # Often placed as Baruch 6, but sometimes stands alone
        abbreviation: "Ep Jer",
        regex: "(?:((Le?t?t?e?r?|Ep)(\.\s|\sof\s)?Jer?))",
        testament: "",
        chapters: [73],
        bible: false,
        apocrypha: true
      ),
      Book.new(
        id: 109,
        name: "Song of Three Youths", # An extension of Daniel 3... a.k.a. Prayer of Azariah
        abbreviation: "Sg of 3 Childr",
        regex: "(?:(((The\s)?(So?n?g)(\.?\s?o?f?\s?)(the\s)?(3|Thr).*))|((Pr)?.*Aza?r?))",
        testament: "",
        chapters: [],
        bible: false,
        apocrypha: true
      ),
      Book.new(
        id: 110,
        name: "Susanna", # A book of Daniel
        abbreviation: "Sus",
        regex: "(?:(Sus))",
        testament: "",
        chapters: [64],
        bible: false,
        apocrypha: true
      ),
      Book.new(
        id: 111,
        name: "Bel and the Dragon", # A book of Daniel
        abbreviation: "Bel and Dr",
        regex: "(?:(Bel))",
        testament: "",
        chapters: [42],
        bible: false,
        apocrypha: true
      ),
      Book.new(
        id: 112,
        name: "1 Maccabees",
        abbreviation: "1 Macc",
        regex: "(?:((1s?t?|^I{1}|First)\s?Ma?c?))",
        testament: "",
        chapters: [63, 70, 59, 61, 68, 63, 50, 32, 73, 89, 74, 53, 53, 49, 41, 24],
        bible: false,
        apocrypha: true
      ),
      Book.new(
        id: 113,
        name: "2 Maccabees",
        abbreviation: "2 Macc",
        regex: "(?:((2n?d?|^I{2}|Second)\s?Ma?c?))",
        testament: "",
        chapters: [36, 32, 40, 50, 27, 31, 42, 36, 29, 38, 38, 46, 26, 46, 39],
        bible: false,
        apocrypha: true
      ),
      Book.new(
        id: 114,
        name: "3 Maccabees",
        abbreviation: "3 Macc",
        regex: "(?:((3r?d?|^I{3}|Third)\s?Ma?c?))",
        testament: "",
        chapters: [29, 33, 30, 21, 51, 41, 23],
        bible: false,
        apocrypha: true
      ),
      Book.new(
        id: 115,
        name: "4 Maccabees",
        abbreviation: "4 Macc",
        regex: "(?:((4t?h?|IV|Fourth)\s?Ma?c?))",
        testament: "",
        chapters: [35, 24, 21, 26, 38, 35, 23, 29, 32, 21, 27, 19, 27, 20, 32, 25, 24, 24],
        bible: false,
        apocrypha: true
      ),
      Book.new(
        id: 116,
        name: "1 Esdras",
        abbreviation: "1 Esd",
        regex: "(?:((1s?t?|^I{1}|First)\s?Esd?))",
        testament: "",
        chapters: [58, 30, 24, 63, 73, 34, 15, 96, 55],
        bible: false,
        apocrypha: true
      ),
      Book.new(
        id: 117,
        name: "2 Esdras",
        abbreviation: "2 Esd",
        regex: "(?:((2n?d?|^I{2}|Second)\s?Esd?))",
        testament: "",
        chapters: [40, 48, 36, 52, 56, 59, 140, 63, 47, 59, 46, 51, 58, 48, 63, 78],
        bible: false,
        apocrypha: true
      ),
      Book.new(
        id: 118,
        name: "Prayer of Manasseh",
        abbreviation: "Pr of Man",
        regex: "(?:(Pr?.*Man?))",
        testament: "",
        chapters: [15],
        bible: false,
        apocrypha: true
      ),
      Book.new(
        id: 119,
        name: "Additional Psalm",
        abbreviation: "Add Ps",
        regex: "(?:(Add.*Ps))",
        testament: "",
        chapters: [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 7],
        bible: false,
        apocrypha: true
      ),
      Book.new(
        id: 120,
        name: "Ode",
        abbreviation: "Ode",
        regex: "(?:(Add.*Ps))",
        testament: "",
        chapters: [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 7],
        bible: false,
        apocrypha: true
      ),
    ]

    def self.books
      @@books
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
  end
end
