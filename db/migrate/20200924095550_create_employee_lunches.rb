# frozen_string_literal: true

class CreateEmployeeLunches < ActiveRecord::Migration[6.0]
  def change
    create_table :employee_lunches do |t|
      t.date :date
      t.bigint :employee_id
      t.bigint :lunch_id

      t.timestamps
    end
  end
end
