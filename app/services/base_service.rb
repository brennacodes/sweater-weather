class BaseService
  include Parsable

  private
    def self.faraday_conn(url)
      Faraday.new(url)
    end
end