task populate: :environment do
  require 'csv'
  require 'barby'
  require 'barby/barcode/code_128'
  require 'barby/outputter/svg_outputter'

  barcode = Barby::Code128B.new('000000')
  Product.create!(name: 'vide', reference: '000000', ean13: barcode.to_svg(xdim:2, height:60))

  csv_text = File.read("#{Rails.root}/lib/assets/items.csv")
  csv = CSV.parse(csv_text, :headers => true)
  csv.each do |row|
    ref = row[0]
    name= row[2]
    barcode = Barby::Code128B.new(ref)

    Product.create!(name: name, reference: ref, ean13: barcode.to_svg(xdim:2, height:60))
  end

end
