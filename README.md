# bible_bot

Gem for parsing and working with bible verse references.

## Usage

    $ gem install 'bible_bot'
    
    require 'bible_bot'
    p = BibleBot::Parser.new
    references = p.extract( "John 1:1 is the first but Rom 8:9-10 is another." )
    puts references.collect{ |r| r.formatted }.join( ", " )
    
    > John 1:1, Romans 8:9-10


## History

Originally ported from [https://github.com/davisd/python-scriptures](https://github.com/davisd/python-scriptures)