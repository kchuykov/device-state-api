require "api"

RSpec.describe Api do

  describe 'GET /device_state' do

    before(:each) do
      @response = Api.get_device_states()
    end

    it 'Should return 200 OK' do
      expect(@response.code).to eq(200)
    end
    it 'Should have All device_states returned ordered by timestamp ascending' do
      
      dates = Api.get_device_state_dates(@response)
      expect(dates.empty?).to be_falsey
      expect(dates).to eq(dates.sort)

    end
  end

  describe 'GET /device_state/:id' do

    it 'Should return a 200 OK if device_states are returned' do
      device_id = 1
      response = Api.get_device_state_by_id(device_id)
      expect(response.code).to eq(200)
    end

    it "Should return a 404 NOT FOUND and an empty body if no device_state's exist for the given id" do
      device_id = 123
      response = Api.get_device_state_by_id(device_id)
      expect(response.code).to eq(404)
    end

    it 'All device_states returned should be ordered by timestamp ascending' do
      device_id = 1
      response = Api.get_device_state_by_id(device_id)
      dates = Api.get_device_state_dates(response)
      expect(dates.length).to be > 2
      expect(dates).to eq(dates.sort)
    end

  end


  describe 'POST /device_state' do

    it 'Should return a 200 OK if creation is successful' do
      payload = {
          'device_id'=> 1,
          'event' => 'track'
      }
      response = Api.post_device_state(payload)
      expect(response.code).to eq(200)

    end

    it  'Should return a 400 BAD REQUEST if event is null' do
      payload = {
          'device_id'=> 1,
          'event' => nil
      }
      response = Api.post_device_state(payload)
      expect(response.code).to eq(400)
    end

    it  'Should return a 400 BAD REQUEST if device_id is null' do
      payload = {
          'device_id'=> nil,
          'event' => 'track'
      }
      response = Api.post_device_state(payload)
      expect(response.code).to eq(400)
    end

    it  'Should return a 400 BAD REQUEST if device_id and event is null' do
      payload = {
          'device_id'=> nil,
          'event' => nil
      }
      response = Api.post_device_state(payload)
      expect(response.code).to eq(400)
    end

  end

  end
