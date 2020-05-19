# bible_bot

Gem for parsing and working with bible verse references.

## Usage

```ruby
# Gemfile
gem 'bible_bot', github: 'LittleLea/bible_bot'
```

```bash
$ bundle install
```

```ruby
# Use it
require 'bible_bot'
references = BibleBot::Reference.parse( "John 1:1 is the first but Rom 8:9-10 is another." )
puts references.map(&:formatted).join( ", " )
#=> "John 1:1, Romans 8:9-10"

reference = references.last
reference.start_verse.formatted
#=> "Romans 8:9"
reference.end_verse.formatted
#=> "Romans 8:10"
```

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

* May omit the chapter number if the book is only a single chapter book.

```ruby
"Jude 5" #=> Jude 1:5 - Jude 1:5
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
reference.verse_ids      #=> [1_001_001, 2_010_020]
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
Foo.where("start_verse <= ?", reference.end_verse)
   .where("end_verse >= ?", reference.start_verse)
```

`Reference` and `Verse` also have built in methods for comparing against each other.

```ruby
reference.intersects_reference?(other_reference)

reference.includes_verse?(verse)

verse < other_verse
verse == other_verse
verse > other_verse
```


## History

Originally ported from [https://github.com/davisd/python-scriptures](https://github.com/davisd/python-scriptures)
