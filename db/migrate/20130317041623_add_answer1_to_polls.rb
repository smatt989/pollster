class AddAnswer1ToPolls < ActiveRecord::Migration
  def change
    add_column :polls, :answer_1, :string
  end
end
