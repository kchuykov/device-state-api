require "api"

RSpec.describe Api do

  describe 'GET /device_state' do
    before(:all) do
      @request = Api.get_device_states
    end
    before(:each) do
      @request.run
    end

    it 'Should return 200 OK' do
      act_resp = @request.response
      expect(act_resp.code).to eq(200)
    end
    it 'Should have All device_states returned ordered by timestamp ascending' do
      act_resp = @request.response
      dates = Api.get_device_state_dates(act_resp)
      expect(dates.empty?).to be_falsey
      expect(dates).to eq(dates.sort)

    end
  end

  describe 'GET /device_state/:id' do

    it 'Should return a 200 OK if device_states are returned' do
      device_id = 1
      request = Api.get_device_state_by_id(device_id)
      request.run
      act_resp = request.response
      expect(act_resp.code).to eq(200)
    end

    it "Should return a 404 NOT FOUND and an empty body if no device_state's exist for the given id" do
      device_id = 123
      request = Api.get_device_state_by_id(device_id)
      request.run
      act_resp = request.response
      expect(act_resp.code).to eq(404)
    end

    it 'All device_states returned should be ordered by timestamp ascending' do
      device_id = 1
      request = Api.get_device_state_by_id(device_id)
      request.run
      act_resp = request.response
      dates = Api.get_device_state_dates(act_resp)
      expect(dates.empty?).to be_falsey
      expect(dates).to eq(dates.sort)
    end

  end


  describe 'POST /device_state' do

    it 'Should return a 200 OK if creation is successful' do
      payload = {
          'device_id'=> 1,
          'event' => 'track'
      }
      request = Api.post_device_state(payload)
      request.run
      act_resp = request.response
      expect(act_resp.code).to eq(200)

    end

    it  'Should return a 400 BAD REQUEST if event is null' do
      payload = {
          'device_id'=> 1,
          'event' => nil
      }
      request = Api.post_device_state(payload)
      request.run
      act_resp = request.response
      expect(act_resp.code).to eq(400)
    end

    it  'Should return a 400 BAD REQUEST if device_id is null' do
      payload = {
          'device_id'=> nil,
          'event' => 'track'
      }
      request = Api.post_device_state(payload)
      request.run
      act_resp = request.response
      expect(act_resp.code).to eq(400)
    end

    it  'Should return a 400 BAD REQUEST if device_id and event is null' do
      payload = {
          'device_id'=> nil,
          'event' => nil
      }
      request = Api.post_device_state(payload)
      request.run
      act_resp = request.response
      expect(act_resp.code).to eq(400)
    end

  end

  end
