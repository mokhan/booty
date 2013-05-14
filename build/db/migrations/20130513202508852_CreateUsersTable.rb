Sequel.migration do
  change do
    create_table(:users) do
      primary_key :id
      String :username
      String :password_hash
    end
  end
end
