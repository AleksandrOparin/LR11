class Palindrome < ApplicationRecord
  validates :number, presence: { message: "Число не задано" }, numericality: { only_integer: true, message: "Это не число" }

  def self.search_id(search)
    select(:id).find_by(number: search) if search
  end
end
