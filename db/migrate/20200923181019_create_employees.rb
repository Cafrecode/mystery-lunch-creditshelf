# frozen_string_literal: true

class CreateEmployees < ActiveRecord::Migration[6.0]
  def change
    create_table :employees do |t|
      t.string :name
      t.integer :department
      t.integer :status

      t.timestamps
    end
  end
end
