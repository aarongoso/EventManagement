FactoryBot.define do
  factory :event do
    title       { "Sample Event" }
    description { "A test description for an event" }
    location    { "NCI" }
    date        { Date.today }
    time        { Time.parse("12:00") }   # using fixed HH:MM since React form expects it
    capacity    { 30 }

    association :user  # event belongs to user
  end
end
