class Show 
  include Neo4j::ActiveNode

  id_property :itunes_id

  property :release_date
  property :artwork_url600
  property :artwork_url100
  property :country
  property :name
  property :primary_genre_name
  property :artwork_url60
  property :episode_count
  property :view_url
  property :radio_station_url
  property :explicitness
  property :feed_url
  property :artwork_url30
end
