# ModelFetch

A Ruby on Rails library to ease fetching of models. This is accomplished by abstracting the search to query by Integer, Existing Model's Primary Key, or a Standard Lookup. Null values are acceptable.


## Requirements

Ruby on Rails 3+, Ruby 1.8.7+

### Basic usage

```ruby
include ModelFetch
[ModelName].model_fetch(search_criteria, scope_conditions)
```

### Options

Search Criteria: The criteria (A search ID, model, or default criteria)
Scope Conditions: Pass in a string of scope conditions to chain (such as an include, or an existing scope)

## License

Licensed under the [MIT license](http://en.wikipedia.org/wiki/MIT_License).

## Credits

(C) 2012 Scott Croneberger

## A Mendelo Code Project

[@mendelo](https://github.com/mendelo).