class CreateAddressRegions < ActiveRecord::Migration[7.0]
  def change
    create_table :address_regions do |t|
      t.string :code
      t.string :name
      t.timestamps
    end
  end
end

def fetch_region
  request = RestClient.get("#{url}/regions/")
  data = JSON.parse(request.body)
  data.each do |region|
    address_region = Address::Region.find_or_initialize_by(code: region['code'])
    address_region.name = region['regionName']
    address_region.save
  end
end