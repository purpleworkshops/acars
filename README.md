# Acars

Makes it easier to transmit numeric metrics to Radar.

* You MUST define an environment variable named `ACARS_KEY` that holds your secret API key for Radar.  Ask Jeff for your API key.
* At the moment, this gem only supports transmitting "gauge"-style metrics. You can pass a key/value pair to the `.gauge` method where the key is the name of the metric you'd like to report on, and the value is a single numerical value that can change arbitrarily.
* The special gauge name `heartbeat` is reserved for monitoring your application's "health" status.  Send a `1` to indicate that your application is flying normally, or `0` to send a mayday call.

## Installation

Add this line to the application's Gemfile:

```ruby
gem 'acars', git: 'https://github.com/purpleworkshops/acars'
```

## Usage

For this example, assume your app name is "research_study".

Here is a sample rake task (but also see the Dry Run example below)

``` ruby
desc "Transmit stats"
task acars: :environment do
  Acars.transmit_for :research_study do |acars|
    acars.gauge participants: Participant.count,
                events: AppEvent.count,
                messages: Message.count,
                heartbeat: (AppEvent.order(created_at: :desc).first.created_at > 1.hour.ago ? 1 : 0)
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
    acars.gauge heartbeat: (AppEvent.order(created_at: :desc).first.created_at > 1.hour.ago ? 1 : 0)
  end
end
```

### Dry Run mode

You can also pass a `dry_run: true` argument to prevent Acars from actually transmitting data. 
For example, this will only transmit stats in production, and emit to `stdout` otherwise:

``` ruby
  Acars.transmit_for :research_study, dry_run: (!Rails.env.production?) do |acars|
    ...
  end
```
