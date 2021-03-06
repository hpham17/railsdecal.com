# == Schema Information
#
# Table name: lectures
#
#  id          :integer          not null, primary key
#  number      :integer
#  title       :string
#  partial     :string
#  created_at  :datetime
#  updated_at  :datetime
#  semester_id :integer
#

class Lecture < ActiveRecord::Base
  belongs_to :semester

  default_scope -> { order(:number) }

  def year
    semester.year
  end

  def semester_name
    semester.semester
  end

  def filename
    "lectures/#{year}/#{semester_name.downcase}/#{partial.downcase}"
  end

  class << self

    def by_year_and_semester
      all.group_by(&:semester).map{|semester, lectures| {semester.year => lectures.group_by{|lecture| semester.semester}}}
    end

  end

end
