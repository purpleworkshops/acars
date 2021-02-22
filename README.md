# Acars

Makes it easier to transmit StatsD-like metrics to Radar.

* You MUST define an environment variable named `ACARS_KEY` that holds your secret API key for Radar.  Ask Jeff for your API key.
* At the moment, this gem only supports transmitting "gauge"-style metrics.

## Installation

Add this line to the application's Gemfile:

```ruby
gem 'acars', git: 'https://github.com/purpleworkshops/acars'
```

## Usage

For this example, assume your app name is "research_study".

Here is a sample rake task.

``` ruby
desc "Transmit stats"
task acars: :environment do
  Acars.transmit_for :research_study do |acars|
    acars.gauge participants: Participant.count,
                events: AppEvent.count
                messages: Message.count
    end
end
```

Or if you prefer to make separate calls:

``` ruby
desc "Transmit stats"
task acars: :environment do 
  Acars.transmit_for :research_study do |acars|
    acars.gauge participants: Participant.count
    acars.gauge events: AppEvent.count
    acars.gauge messages: Message.count
  end
end
```

You can also pass a `dry_run:` argument to prevent Acars from actually transmitting data:

``` ruby
  Acars.transmit_for :research_study, dry_run: true do |acars|
```
in which case you'll see a dry run message emitted to `stdout` instead.
