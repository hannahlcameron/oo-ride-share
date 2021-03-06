require_relative 'spec_helper'

describe "TripDispatcher class" do
  describe "Initializer" do
    it "is an instance of TripDispatcher" do
      dispatcher = RideShare::TripDispatcher.new
      dispatcher.must_be_kind_of RideShare::TripDispatcher
    end

    it "establishes the base data structures when instantiated" do
      dispatcher = RideShare::TripDispatcher.new
      [:trips, :passengers, :drivers].each do |prop|
        dispatcher.must_respond_to prop
      end

      dispatcher.trips.must_be_kind_of Array
      dispatcher.passengers.must_be_kind_of Array
      dispatcher.drivers.must_be_kind_of Array
    end
  end

  describe "find_driver method" do
    before do
      @dispatcher = RideShare::TripDispatcher.new
    end

    it "throws an argument error for a bad ID" do
      proc{ @dispatcher.find_driver(0) }.must_raise ArgumentError
    end

    it "finds a driver instance" do
      driver = @dispatcher.find_driver(2)
      driver.must_be_kind_of RideShare::Driver
    end
  end

  describe "find_passenger method" do
    before do
      @dispatcher = RideShare::TripDispatcher.new
    end

    it "throws an argument error for a bad ID" do
      proc{ @dispatcher.find_passenger(0) }.must_raise ArgumentError
    end

    it "finds a passenger instance" do
      passenger = @dispatcher.find_passenger(2)
      passenger.must_be_kind_of RideShare::Passenger
    end
  end

  describe "loader methods" do
    it "accurately loads driver information into drivers array" do
      dispatcher = RideShare::TripDispatcher.new

      first_driver = dispatcher.drivers.first
      last_driver = dispatcher.drivers.last

      first_driver.name.must_equal "Bernardo Prosacco"
      first_driver.id.must_equal 1
      first_driver.status.must_equal :UNAVAILABLE
      last_driver.name.must_equal "Minnie Dach"
      last_driver.id.must_equal 100
      last_driver.status.must_equal :AVAILABLE
    end

    it "accurately loads passenger information into passengers array" do
      dispatcher = RideShare::TripDispatcher.new

      first_passenger = dispatcher.passengers.first
      last_passenger = dispatcher.passengers.last

      first_passenger.name.must_equal "Nina Hintz Sr."
      first_passenger.id.must_equal 1
      last_passenger.name.must_equal "Miss Isom Gleason"
      last_passenger.id.must_equal 300
    end

    it "accurately loads trip info and associates trips with drivers and passengers" do
      dispatcher = RideShare::TripDispatcher.new

      trip = dispatcher.trips.first
      driver = trip.driver
      passenger = trip.passenger

      driver.must_be_instance_of RideShare::Driver
      driver.trips.must_include trip
      passenger.must_be_instance_of RideShare::Passenger
      passenger.trips.must_include trip
    end

  end # end of describe "loader methods"

  describe "find_available_driver method" do

    it "finds the first driver who has an available status" do
      dispatcher = RideShare::TripDispatcher.new

      dispatcher.find_available_driver.must_be_instance_of RideShare::Driver
    end

    it "raises an error when not enough drivers" do
    dispatcher = RideShare::TripDispatcher.new
    proc {
      55.times do
        dispatcher.find_available_driver
      end}.must_raise StandardError
    end

  end # end of find_available_driver

  describe "find_next_trip_id" do
    it "finds the next appropriate trip id" do
      dispatcher = RideShare::TripDispatcher.new
      dispatcher.find_next_trip_id.must_equal 601
    end
  end # end of describe "find_next_trip_id"

  describe "get_new_start_time" do
    it "creates an instance of time" do
      dispatcher = RideShare::TripDispatcher.new
      dispatcher.get_new_start_time.must_be_instance_of Time
    end
  end # end of describe get_current_time

  describe "request_trip(passenger_id) method" do

    it "throws an ArgumentError if passenger_id is invalid" do
      proc {
        dispatcher = RideShare::TripDispatcher.new
        dispatcher.request_trip(543)}.must_raise ArgumentError

      end # end of throws an ArgumentError if passenger_id is invalid

      it "creates a new instance of Trip" do
        dispatcher = RideShare::TripDispatcher.new
        dispatcher.request_trip(5).must_be_instance_of RideShare::Trip
      end
    end # end of describe request_trip(passenger_id) method
  end # end of describe "TripDispatcher class"
