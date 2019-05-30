class UserMovies < ActiveRecord::Migration[5.2]
  def change
    create_table :user_movies do |t|
      t.string  :name
      t.integer :user_id
      t.integer :movie_id
    end
  end
end
