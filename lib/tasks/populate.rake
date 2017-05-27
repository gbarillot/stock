task populate: :environment do
  require 'csv'
  require 'barby'
  require 'barby/barcode/code_128'
  require 'barby/outputter/svg_outputter'

  Product.destroy_all
  Order.destroy_all
  Position.destroy_all
  Basket.destroy_all
  History.destroy_all

  puts 'Products----------------'

  empty_p = Product.create!(reference: '0000', name: 'Vide', quantity: 0, notes: 'default product')

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

  puts 'Tree----------------'

  parent = ''
  sampled = []
  ['A', 'B', 'C', 'D'].each do |allee|
    parent = allee
    Position.create!(name: "#{parent}", depth: 0, quantity: 0, product_id: nil, free: 3200)

    (1..16).each do |rak|
      Position.create!(name: "#{parent} #{rak}", depth: 1, quantity: 0, product_id: nil, free: 800)

      (1..4).each do |etage|
        Position.create!(name: "#{parent} #{rak} #{etage}", depth: 1, quantity: 0, product_id: nil, free: 200)

        (1..20).each do |pos|
          sampled.push("#{parent} #{rak} #{etage} #{pos}")

          Position.create!(name: "#{parent} #{rak} #{etage} #{pos}", depth: 1, quantity: 0, product_id: empty_p.id, free: 10)
        end
      end
    end
  end

  puts 'Populating----------------'
  from = Product.first.id
  to = Product.last.id
  $current_user = User.first

  300.times do |i|
    p = rand(from..to)
    q = rand(1..10)
    name = sampled.sample
    Position.link(product_id: p, quantity: q, name: name)
  end

end
