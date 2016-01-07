class AddCategoryToLoanRequest < ActiveRecord::Migration
  def change
    add_column :loan_requests, :category, :string, index: true
  end
end
