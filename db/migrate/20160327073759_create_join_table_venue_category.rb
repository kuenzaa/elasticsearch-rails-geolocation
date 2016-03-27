class CreateJoinTableVenueCategory < ActiveRecord::Migration
  def change
    create_join_table :venues, :categories do |t|
      # t.index [:venue_id, :category_id]
      # t.index [:category_id, :venue_id]
    end
  end
end
