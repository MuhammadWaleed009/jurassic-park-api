# frozen_string_literal: true

builder_user_attributes = {
  email: 'builder@jurassicpark.com',
  password: 'password1234$',
  role: 0,
}
builder = User.create(builder_user_attributes)

scientist_user_attributes = {
  email: 'scientist@jurassicpark.com',
  password: 'password1234$',
  role: 1,
}
scientist = User.create(scientist_user_attributes)

doctor_user_attributes = {
  email: 'doctor@jurassicpark.com',
  password: 'password1234$',
  role: 2,
}
doctor = User.create(doctor_user_attributes)

cage_attributes = {
  name: 'Cage1',
  max_capacity: 5
}
cage = Cage.create(cage_attributes)

velo_dinosaurs_attributes = {
  name: 'Velo',
  species: 'velociraptor',
  cage_id: cage.id
}
dinosaur = Dinosaur.create(velo_dinosaurs_attributes)
