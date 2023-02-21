class CageSerializer
  include FastJsonapi::ObjectSerializer
  
  attributes :name, :max_capacity, :power_status, :dinosaurs_count, :created_at, :updated_at
end
