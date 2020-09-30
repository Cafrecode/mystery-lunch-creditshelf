class ChangeDateOnEmployeeLunch < ActiveRecord::Migration[6.0]
  def change
    change_column :employee_lunches, :date, :string
  end
end
