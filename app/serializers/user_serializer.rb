class UserSerializer < ActiveModel::Serializer
  attributes :first_name, :last_name, :address_line_1, 
  					 :date_of_birth, :age, :name
end
