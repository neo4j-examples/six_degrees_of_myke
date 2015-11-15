class Person 
  include Neo4j::ActiveNode

  id_property :name

  has_many :in, :authored_episodes, type: :HAS_AUTHOR, model_class: :Episode
  has_many :out, :mentioned_in, type: :MENTIONED_IN, model_class: :Episode
end
