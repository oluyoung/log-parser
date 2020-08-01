# Log Parser

### Description

Project to parse a .log file into an ordered list of unique views and most visited

### Requirements
 - [Ruby](https://www.ruby-lang.org/en/documentation/installation/): A dynamic, open source programming language with a focus on simplicity and productivity.
 - [Ruby Gems](https://rubygems.org/pages/download): RubyGems is a package management framework for Ruby
 - [Rake](https://github.com/ruby/rake): `gem install rake`
 - [Bundler](https://bundler.io/): `gem install bundler`


### Run

1. bundle install
2. run `ruby parser.rb <file_name>.log`
3. Check for `_most_visited.txt` and `_unique_views.txt` in your current working directory

#### Testing & Coverage

As easy as running `rake` in your terminal.

A coverage folder will be generated in your directory, simply open coverage/index.html in a web browser.
