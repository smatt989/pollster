class AddAnswer4ToPolls < ActiveRecord::Migration
  def change
    add_column :polls, :answer_4, :string
  end
end
