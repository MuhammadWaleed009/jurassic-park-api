class DinosaurSerializer
  include FastJsonapi::ObjectSerializer
  
  attributes :id, :name, :species, :diet, :created_at, :updated_at, :cage_id
end
