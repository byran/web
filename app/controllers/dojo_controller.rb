
class DojoController < ApplicationController

  def index
    @title = 'home'
    @id = id
    @message = ENV['MESSAGE']
    @shuffled_avatar_names = Avatars.names.shuffle
  end

end
