Factory.sequence :email do |n|
  "user#{n}@example.com"
end


Factory.define :user do |user|
  user.email                 { Factory.next :email }
  user.sequence(:identifier) {|n| "id://achach#{n}"} 
  user.sequence(:nickname) {|n| "funktracker#{n}"}
end