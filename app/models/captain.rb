class Captain < ActiveRecord::Base
  has_many :boats

  def self.catamaran_operators
    b = BoatClassification.where(classification_id:3).pluck(:boat_id)
    c = Boat.where(id: b).pluck(:captain_id)
    all.where(id:c)
  end

  def self.sailors
    s = Boat.sailboats.pluck(:captain_id)
    all.where(id:s)
  end

  def self.talented_seamen
    motorboats = BoatClassification.where(classification_id:5).pluck(:boat_id)
    sailboats = Boat.sailboats.pluck(:id)
    ids = all.select do |captain|
      boats = captain.boats.pluck(:id)
      if boats & motorboats != [] && boats & sailboats != []
        captain
      end
    end
    ids.collect do |cap|
      cap.id
    end
    all.where(id:ids)
  end

  def self.non_sailors
    ns = all - sailors
    ns.collect do |cap|
      cap.id
    end
    all.where(id:ns)
  end
end
