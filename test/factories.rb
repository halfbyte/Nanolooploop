Factory.sequence :email do |n|
  "user#{n}@example.com"
end


Factory.define :user do |user|
  user.email                 { Factory.next :email }
  user.identifier "achach"
  user.sequence(:nickname) {|n| "funktracker#{n}"}
end