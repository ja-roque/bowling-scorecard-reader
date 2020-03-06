# bowling-scorecard-reader
This is a pure Ruby scorecard reader that draws the scoreboard on terminal.


# Installation:

To be able tu run the script, only 2 gems must be installed which are conveniently located in the Gemfile.
Just run bundle install in the scripts root directory.

# Usage:

For the sake of simplicity and versatility, the script takes one optional argument to be able to switch between scorecards:
You may run:

`$ Ruby start_bowling.rb` <br>
or <br>
`$ Ruby start_bowling.rb 'sample.txt'` 

# Notes:

Integration and Unit test was made with Rspec ( my weapon of choice when it comes to testing. )

# Bonus details:

In the score_card class, I added an extra line because of a different approach that was discussed
in an unofficial manner. ( Not in written in the official specifications document. )

So it's commented out but it's functionality was tested and it works as expected.
It is basically a more flexible way to parse the score data by using regexp.

 