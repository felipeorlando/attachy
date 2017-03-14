FactoryGirl.define do
  factory :file, class: Attachy::File do
    format :jpg
    height 600
    scope  :avatar
    width  800

    sequence(:public_id) { |i| "PublicId#{i}" }

    sequence :version, &:to_s
  end
end
