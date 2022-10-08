class CreateBooks < ActiveRecord::Migration[7.0]
  def change
    # defines a table
    create_table :books do |t|
      t.string :title
      t.string :author

      t.timestamps
    end
  end
end
