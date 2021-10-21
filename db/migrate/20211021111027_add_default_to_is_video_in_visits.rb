class AddDefaultToIsVideoInVisits < ActiveRecord::Migration[6.1]
  def change
    change_column :visits, :is_video, :boolean, default: false
  end
end
