class AddAnswer3ToPolls < ActiveRecord::Migration
  def change
    add_column :polls, :answer_3, :string
  end
end
