class Will < ApplicationRecord
  validates_presence_of :first_name, :last_name, :lawyer_name, :firm_name, :lsuc, :telephone, :year

  def self.search(search)
    where("first_name ILIKE :search \
          or last_name ILIKE :search \
          or alt_last_name ILIKE :search \
          or city_of_birth ILIKE :search \
          or province_of_birth ILIKE :search \
          or country_of_birth ILIKE :search \
          or last_resided ILIKE :search", {search: "%#{search}%"})
  end

  def self.import(file)
    CSV.foreach(file.path, encoding:'iso-8859-1:utf-8', headers: true) do |row|
      next if row.to_s.start_with?(",,,")
      Will.create! row.to_hash.merge({"approved" => false})
    end
  end
end
