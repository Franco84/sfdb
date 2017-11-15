class CreateCandidates < ActiveRecord::Migration[5.0]
  def change
    create_table :candidates do |t|
      t.integer :candidate_id
      t.integer :communication_score
      t.integer :coding_score
      t.string :title
      t.integer :company_id
      t.float :fractal_index

      t.timestamps
    end
  end
end
