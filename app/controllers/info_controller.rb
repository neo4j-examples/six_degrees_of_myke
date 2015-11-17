class InfoController < ApplicationController
  def home
  end

  def people_names
    if params[:query].present?
      names = Person.as(:person).order(:name).where('person.lower_name CONTAINS ?', params[:query].downcase).pluck(:name)

      render json: names.map { |name| {id: name, text: name} }
    else
      render json: []
    end
  end

  def path_between
    @person1 = Person.find(params[:name1])
    @person2 = Person.find(params[:name2])

    relationship_types = if params[:only_author] == 'true'
                           'HAS_AUTHOR'
                         else
                           'HAS_AUTHOR|MENTIONED_IN'
                         end
    nodes, rels = @person1.query_as(:person1)
      .match_nodes(person2: @person2)
      .match("path=shortestPath((person1)-[:#{relationship_types}*1..12]-(person2:Person))")
      .pluck('nodes(path), rels(path)')[0]

    @path = nodes.zip(rels).flatten.compact if nodes && rels

    render layout: false
  end
end

