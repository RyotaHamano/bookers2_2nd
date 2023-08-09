class CreateRelations < ActiveRecord::Migration[6.1]
  def change
    create_table :relations do |t|
      t.references :follow, null: false, foreign_key: {to_table: :users}
      t.references :followed, null: false, foreign_key: {to_table: :users}

      t.timestamps
    end
  end
end