Sequel.migration do
  change do
    create_table(:products) do
      primary_key :id
      String :name
    end
  end
end
