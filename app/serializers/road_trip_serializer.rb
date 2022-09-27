class RoadTripSerializer
  include JSONAPI::Serializer
  set_type :roadtrip
  attributes :id,
             :origin, 
             :destination, 
             :travel_time, 
             :weather_at_eta
end