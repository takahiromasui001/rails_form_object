class CreatePostsTagsTaggings < ActiveRecord::Migration[6.1]
  def change
    create_table :posts do |t|
      t.string :name
      t.string :content

      t.timestamps
    end

    create_table :tags do |t|
      t.string :name

      t.timestamps
    end

    create_join_table :posts, :tags, table_name: :taggings
  end
end
