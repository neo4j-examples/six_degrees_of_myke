class Artist 
  include Neo4j::ActiveNode

  id_property :itunes_id

  property :name
  property :view_url
end
