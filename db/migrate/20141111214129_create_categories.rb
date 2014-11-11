class CreateCategories < ActiveRecord::Migration
  def change
    create_table :categories do |t|
      t.string :name

      t.timestamps
    end
    add_index :categories, :name

    Category.create!(name: "my_content")
    Category.create!(name: "other_peoples_content")
    Category.create!(name: "questions")
    Category.create!(name: "words_of_wisdom")
    Category.create!(name: "quotes_from_others")
    Category.create!(name: "resources")
  end
end
