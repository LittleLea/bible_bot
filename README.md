# bible_bot

Gem for parsing and working with bible verse references.

## Getting Started

```ruby
# Gemfile
gem 'bible_bot', github: 'LittleLea/bible_bot'
```

```bash
$ bundle install
```

```ruby
require 'bible_bot'

# Parsing
references = BibleBot::Reference.parse( "John 1:1 is the first but Rom 8:9-10 is another." )

# Formatting
references.formatted #=> "John 1:1, Romans 8:9-10"
references.map(&:formatted).join( ", " ) #=> "John 1:1, Romans 8:9-10"
reference = references.last
reference.start_verse.formatted #=> "Romans 8:9"
reference.end_verse.formatted   #=> "Romans 8:10"

# Invalid references are skipped by default
BibleBot::Reference.parse( "Genesis 100:1" ) #=> []

# Optionally include invalid references
references = BibleBot::Reference.parse( "Genesis 100:1", validate: false )
references.first.valid? #=> false

# Optionally raise on errors
BibleBot::Reference.parse( "Genesis 100:1", validate: :raise_errors )
# => BibleBot::InvalidVerseError:
#      Verse is not valid: {:book=>"Genesis", :chapter_number=>100, :verse_number=>1}

# Find Books
book = BibleBot::Book.find_by_name("1 John")
book.reference.inspect #=> {:start_verse=>"1 John 1:1", :end_verse=>"1 John 5:21"}
```

## Terms

* `Verse` - A single verse in the bible.
* `Reference` - A range of two verses. Start and end verse may be equal, in which case it is a single verse reference.
* `ReferenceMatch` - A lower level wrapper around regular expression `Match` results. This class contains all the parsing logic. Except for advanced use cases, use `Reference.parse` instead.
* `Book` - One of the 66 books in the bible.
* `Bible` - A wrapper containing all 66 books and the regular expressions used for parsing.

## Supported Abbreviation Rules

* May abbreviate the book title. See `BibleBot::Bible` for which book abbreviations are supported.

```ruby
"Gen 1:1"
```

* May omit the end book if it is the same as the start book.

```ruby
"Genesis 1:1-2:3"  #=> Genesis 1:1 - Genesis 2:3
```

* May omit the end chapter if it is the same as the start chapter.

```ruby
"Genesis 1:1-3"    #=> Genesis 1:1 - Genesis 1:3
```

* May omit the verse number if the reference includes the entire chapter.

```ruby
"Genesis 1"    #=> Genesis 1:1 - Genesis 1:31
"Genesis 1-2"  #=> Genesis 1:1 - Genesis 2:25
```

## Persisting References and Verses

A `Reference` is made up of two `Verse` objects.

```ruby
reference.start_verse
reference.end_verse
```

Each verse is represented by an integer ID that can be stored in your database.

```ruby
#   |- book.id
#   |   |- chapter_number
#   |   |   |- verse_number
#   XX_XXX_XXX

reference.start_verse.id #=> 1_001_001  (Genesis 1:1)
reference.end_verse.id   #=> 2_010_020  (Exodus 10:20)
```

How you store the `start_verse` and `end_verse` is up to you.

To re-instantiate a reference, you can use `Reference.from_verse_ids(:start_verse_id, :end_verse_id)`.

```ruby
Reference.from_verse_ids(1_001_001, 2_010_020)

# Which is shorthand for
Reference.new(
  start_verse: Verse.from_id(1_001_001),
  end_verse: Verse.from_id(2_010_020)
)
```


## Comparing References

If you want to see if a `Reference` intersects any you have stored in your database, you might do something like:

```ruby
Foo.where("start_verse_id <= ?", reference.end_verse.id)
   .where("end_verse_id >= ?", reference.start_verse.id)
```

`Reference` and `Verse` also have built in methods for comparing against each other.

```ruby
reference.intersects_reference?(other_reference)
reference.includes_verse?(verse)
verse < other_verse
verse == other_verse
verse > other_verse
```

## Deuterocanonical References

If you want to match deuterocanonical references in your strings, you can enable a collection of matchers like this:

```ruby
BibleBot.include_deuterocanonical_content = true

ReferenceMatch.scan( "Tob 1:1" ).first.reference.formatted

# > "Tobit 1:1"
```

You can see the supported deuterocanonical works in [bible.rb](https://github.com/LittleLea/bible_bot/blob/b94fe9b3948ceb23d39961ffdc4bdf7ffe23eff3/lib/bible_bot/bible.rb#L537)

## History

Originally ported from [https://github.com/davisd/python-scriptures](https://github.com/davisd/python-scriptures)
