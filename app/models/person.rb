class Person 
  include Neo4j::ActiveNode

  id_property :name
  property :lower_name, index: :exact

  has_many :in, :authored_episodes, type: :HAS_AUTHOR, model_class: :Episode
  has_many :out, :mentioned_in, type: :MENTIONED_IN, model_class: :Episode

  has_many :both, :episodes, type: false, model_class: :Episode

  NAME_CACHE_PATH = Rails.root.join('tmp/cache/person_names')
  NAME_CACHE = ActiveSupport::Cache::FileStore.new(NAME_CACHE_PATH, expires_in: 1.week)

  def self.names_matching(name)
    names = NAME_CACHE.fetch('all_names') do
      Person.as(:person).episodes.query_as(:episode)
        .with('person.name AS name', 'count(episode) AS count').order('count DESC')
        .pluck(:name)
    end

    regexp = Regexp.new(Regexp.escape(name.downcase), 'i')

    names.grep(regexp)
  end
end
