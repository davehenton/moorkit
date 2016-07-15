require 'active_record'
require 'moorkit/webhooks/segment'

namespace :segment do
  namespace :identify do
    desc "loads all identify requests between START_DATE and END_DATE. specify dates as iso8601. e.g.: #{Time.now.iso8601}"
    task load: :environment do
      begin
        end_date = Time.parse(ENV['END_DATE'])
        start_date = ENV['START_DATE'].nil? ? Time.parse("2015-01-01") : Time.parse(ENV['START_DATE'])
      rescue
        raise StandardError.new("START_DATE/END_DATE is not a valid iso8601 date/time.  e.g.: END_DATE=#{Time.now.iso8601}")
      end

      Moorkit::Webhooks::Segment.process_identify_requests_context.call(start_date: start_date, end_date: end_date)
    end
  end

end
