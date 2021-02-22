require "acars/version"
require "acars/transmitter"

module Acars
  class Error < StandardError; end

  def self.transmit_for(app, dry_run: false)
    app = app.to_s.downcase.strip
    yield Transmitter.new(app, dry_run: dry_run)
  end

end
