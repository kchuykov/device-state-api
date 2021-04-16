require 'typhoeus'
require 'json'
require 'date'

class Api
  @url = 'http://sdet-interview-api.herokuapp.com/'

  def self.get_device_states()
    path = 'device_state'
    method = 'GET'
    headers = {}
    request = Typhoeus::Request.new(
        @url + path,
        method: method,
        body: nil,
        headers: headers)
    request
  end
  def self.get_device_state_by_id(id)
    request = Typhoeus::Request.new(
        @url + 'device_state/' + id.to_s,
        method: 'GET',
        body: nil,
        headers: {})
    request
  end

  def self.post_device_state(payload)
    path = 'device_state'
    method = 'POST'
    headers = {"Content-Type"=> "application/json" }
    request = Typhoeus::Request.new(
        @url + path,
        method: method,
        body: payload.to_json,
        headers: headers)
    request
  end

  def self.get_device_state_dates(act_resp)
    json_response = JSON.parse(act_resp.body)
    dates = []
    json_response.each {|device|
      dates.push(DateTime.parse(device['timestamp']).to_time.to_i)
    }
    dates
  end

end