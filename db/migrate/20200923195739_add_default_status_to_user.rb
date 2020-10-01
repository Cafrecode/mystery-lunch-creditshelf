# frozen_string_literal: true

class AddDefaultStatusToUser < ActiveRecord::Migration[6.0]
  def up
    change_column :employees, :status, :integer, default: 0
  end

  def down
    change_column :employees, :status, :integer, default: nil
  end
end
