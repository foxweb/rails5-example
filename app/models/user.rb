class User < ApplicationRecord
  has_many :posts

  enum status: {
    created: 0,
    active:  1,
    blocked: 2,
    deleted: 3
  }

  def full_name
    [first_name, last_name].compact.join(' ')
  end
end
