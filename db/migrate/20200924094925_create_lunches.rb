# frozen_string_literal: true

class CreateLunches < ActiveRecord::Migration[6.0]
  def change
    create_table :lunches do |t|
      t.string :location
      t.datetime :date

      t.timestamps
    end
  end
end
