rosette-extractor-json
====================

Extracts translatable strings from JSON files for the Rosette internationalization platform.

## Installation

`gem install rosette-extractor-json`

Then, somewhere in your project:

```ruby
# this project must be run under jruby
require 'jbundler' # or somehow add dependent jars to your CLASSPATH
require 'rosette/extractors/json-extractor'
```

### Introduction

This library is generally meant to be used with the Rosette internationalization platform that extracts translatable phrases from git repositories. rosette-extractor-json is capable of identifying translatable key/value, phrase/translation pairs in JSON files.

### Usage with rosette-server

Let's assume you're configuring an instance of [`Rosette::Server`](https://github.com/rosette-proj/rosette-server). Adding dotted key (rails) support would cause your configuration to look something like this:

```ruby
require 'rosette/extractors/json-extractor'

config = Rosette.build_config do |config|
  config.add_repo('my_awesome_repo') do |repo_config|
    repo_config.add_extractor('json/key-value') do |extractor_config|
      extractor_config.match_file_extensions(['.json'])
    end
  end
end
```

See the documentation contained in [rosette-core](https://github.com/rosette-proj/rosette-core) for a complete list of extractor configuration options in addition to `match_file_extensions`.

### Standalone Usage

While most of the time rosette-extractor-json will probably be used alongside rosette-server, there may arise use cases where someone might want to use it on its own. The `extract_each_from` method on `KeyValueExtractor` yields `Rosette::Core::Phrase` objects (or returns an enumerator):

```ruby
json_source_code = '{"phrase": "translation"}'
extractor = Rosette::Extractors::JsonExtractor::KeyValueExtractor.new
extractor.extract_each_from(json_source_code) do |phrase|
  phrase.meta_key # => "phrase"
  phrase.key      # => "translation"
end
```

## Requirements

This project must be run under jRuby. It uses [jbundler](https://github.com/mkristian/jbundler) to manage java dependencies via Maven. Run `gem install jbundler` and `jbundle` in the project root to download and install java dependencies.

## Running Tests

`bundle exec rake` or `bundle exec rspec` should do the trick.

## Authors

* Cameron C. Dutro: http://github.com/camertron
