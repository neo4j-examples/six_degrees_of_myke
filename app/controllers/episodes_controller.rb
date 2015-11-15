class EpisodesController < ApplicationController
  def show
    @episode = Episode.from_base64_guid(params[:base64_guid])
  end
end
