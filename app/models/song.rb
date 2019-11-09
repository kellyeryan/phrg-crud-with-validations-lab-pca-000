# frozen_string_literal: true

require "pry"

class Song < ActiveRecord::Base
  validates :title, presence: true
  validates :title, uniqueness: true
  validates :released, inclusion: { in: [true, false] }
  validates :release_year, presence: false, if: :not_yet_released?
  validates :release_year, numericality:
      { less_than: Date.today.year }, if: :released_already?
  validates :release_year, presence: true, if: :released_already?
  validates :artist_name, presence: true

  def released_already?
    released
  end

  def not_yet_released?
    released == false
  end
end
