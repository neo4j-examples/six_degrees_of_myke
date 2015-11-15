require "base64"

class Episode 
  include Neo4j::ActiveNode

  id_property :guid
  property :description
  property :itunes_author
  property :link
  property :title

  has_one :in, :show, type: :HAS_EPISODE

  has_many :out, :authors, type: :HAS_AUTHOR, model_class: :Person
  has_many :in, :people_mentioned, type: :MENTIONED_IN, model_class: :Person

  def base64_guid
    Base64.encode64(self.guid)
  end

  def self.from_base64_guid(encoded_guid)
    self.find(Base64.decode64(encoded_guid))
  end

  SAFE_TAGS = %w(a b body code col colgroup div em h1 h2 h3 h4 h5 h6 hr html i img li ol p pre span strong table tbody td th thead tr ul)
  SAFE_ATTRIBUTES = %w(id class style)
  def html_safe_description
    white_list_sanitizer = Rails::Html::WhiteListSanitizer.new

    white_list_sanitizer.sanitize(self.description, tags: SAFE_TAGS, attributes: SAFE_ATTRIBUTES).html_safe
  end
end
