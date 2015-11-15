class Genre 
  include Neo4j::ActiveNode

  property :itunes_id
  property :name
end
