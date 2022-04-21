class CreatePalindromes < ActiveRecord::Migration[6.1]
  def change
    create_table :palindromes do |t|
      t.integer :number, null:false
      t.text :result, null:false

      t.timestamps
    end
  end
end
