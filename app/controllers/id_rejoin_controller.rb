
class IdRejoinController < ApplicationController

  def drop_down
    @id = params['id'] = storer.katas_completed(id)
    json = { exists: @id != '' }
    if json[:exists]
      json[:empty] = kata.avatars.started.count == 0
      json[:avatarPickerHtml] = avatar_picker_html
    end
    render json:json
  end

  private

  def avatar_picker_html
    @all_avatar_names = Avatars.names
    @started_avatar_names = avatars.names
    bind('/app/views/id_rejoin/avatar_picker.html.erb')
  end

end
