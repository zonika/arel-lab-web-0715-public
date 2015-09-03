class Boat < ActiveRecord::Base
  belongs_to  :captain
  has_many    :boat_classifications
  has_many    :classifications, through: :boat_classifications

  def self.first_five
    all.limit(5)
  end

  def self.dinghy
    all.where('length < 20')
  end

  def self.ship
    all.where('length > 20')
  end

  def self.last_three_alphabetically
    all.order("name DESC").limit(3)
  end

  def self.without_a_captain
    all.where(captain_id: nil)
  end

  def self.sailboats
    i = BoatClassification.where(classification_id:2).pluck(:boat_id)
    all.where(id: i)
  end

  def self.with_three_classifications
    i = BoatClassification.all.pluck(:boat_id)
    s = i.select{|item| i.count(item) == 3}.uniq
    all.where(id: s)
  end

end
