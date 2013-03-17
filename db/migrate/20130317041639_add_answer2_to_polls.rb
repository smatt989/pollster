class AddAnswer2ToPolls < ActiveRecord::Migration
  def change
    add_column :polls, :answer_2, :string
  end
end
