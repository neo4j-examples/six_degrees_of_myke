class Person 
  include Neo4j::ActiveNode

  id_property :name
  property :lower_name, index: :exact

  has_many :in, :authored_episodes, type: :HAS_AUTHOR, model_class: :Episode
  has_many :out, :mentioned_in, type: :MENTIONED_IN, model_class: :Episode

  has_many :both, :episodes, type: false, model_class: :Episode

  def self.names_matching(name)
    @@names ||= Person.as(:person).episodes.query_as(:episode)
      .with('person.name AS name', 'count(episode) AS count').order('count DESC')
      .pluck(:name)

    regexp = Regexp.new(Regexp.escape(name.downcase), 'i')

    @@names.grep(regexp)
  end
end
