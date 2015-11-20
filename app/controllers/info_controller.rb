class InfoController < ApplicationController
  def home
  end

  def people_names
    if params[:query].present?
      render json: Person.names_matching(params[:query]).map { |name| {id: name, text: name} }
    else
      render json: []
    end
  end

  def path_between
    @person1 = Person.all.find(params[:name1])
    @person2 = Person.all.find(params[:name2])

    relationship_types = if params[:only_author] == 'true'
                           'HAS_AUTHOR'
                         else
                           'HAS_AUTHOR|MENTIONED_IN'
                         end
    @query = @person1.query_as(:person1)
      .match_nodes(person2: @person2)
      .match("path=shortestPath((person1)-[:#{relationship_types}*1..12]-(person2:Person))")
      .return('nodes(path) AS nodes, rels(path) AS rels')

    result = nil
    @time_taken = Benchmark.realtime do
      result = @query.dup.to_a[0]
    end
    if result
      nodes, rels = [result.nodes, result.rels]

      @path = nodes.zip(rels).flatten.compact
    end

    render layout: false
  end
end

