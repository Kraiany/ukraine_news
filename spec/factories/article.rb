FactoryGirl.define do
  factory :article do
    title "Title of my article"
    content "Some content goes here"
    did_tweet false

    trait :empty do
      content nil
    end
  end
end
